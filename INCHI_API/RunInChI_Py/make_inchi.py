#!/usr/bin/python
#
# International Chemical Identifier (InChI)
# Version 1
# Software version 1.02-beta
# August 23, 2007
# Developed at NIST
# 
# The InChI library and programs are free software developed under the
# auspices of the International Union of Pure and Applied Chemistry (IUPAC);
# you can redistribute this software and/or modify it under the terms of 
# the GNU Lesser General Public License as published by the Free Software 
# Foundation:
# http://www.opensource.org/licenses/lgpl-license.php
# 
 

"""
	Test the INCHI API

"""

import os
import sys
import string

from ctypes import *
from optparse import OptionParser

from lightsdf import *
from PyINCHI import *


def make_pystring(p):
	s = ""	
	try:
		for c in p:
			if c=='\0':
				break
			s = s + c
	except:
		pass
	return s



def process_sdf_record(insdf,irec,r,fw,fl,iopts,baux,getinchi,freeinchi,getikey,ikey,inchilogmess):


	# Skip if no structure field present

	if isstruct(r)==0:
		return

	guessname=''


	# Parse SD/MOL fields

	info = convert_MDL_structure_as_text_to_preobject(r['Structure_as_text'],guessname)
	name = info['Name']
	if (name==''):	
		j = irec + 1
		name = insdf.fname+'#'+`j`


	
	nat = info['Natoms']
	nbonds = info['Nbonds']
#	fw.write('***************************************************************************\n')
#	fw.write('RECORD %-d Name = %-s\n' %  (irec+1,name) )
#	if (fl!=sys.stdout):
#		fl.write('RECORD %-d Name = %-s\n' %  (i+1,name) )



	# Make array of inchi_Atom (storage space) anf resp. pointers

	iatoms = (inchi_Atom * nat) ()
	piatoms = (POINTER(inchi_Atom) * nat) ()


	# Fill inchi_Atom's by SDF record atom block content

	atoms = info['Atoms']
	ia = -1
	valences = []
	for a in atoms:

		ia = ia + 1
		atname, charge, (x,y,z) , stereo_pairity, hydrogen_count, stereo_care, valence, h0_designator, reac_component_type, reac_component_num, atom_mapping_num, inv_ret_flag, exact_change_flag, dd = a
		x,y,z  = (x,y,z) 
		valences.append(valence)

		# Make inchi_Atom

		elname = (c_byte * PYINCHI_ATOM_EL_LEN) (PYINCHI_ATOM_EL_LEN*0)
		num_iso_H = (c_byte * (PYINCHI_NUM_H_ISOTOPES+1)) ((PYINCHI_NUM_H_ISOTOPES+1)*0)
		neighbor = (c_short * PYINCHI_MAXVAL) (PYINCHI_MAXVAL*0)
		bond_type = (c_byte * PYINCHI_MAXVAL) (PYINCHI_MAXVAL*0)
		bond_stereo = (c_byte * PYINCHI_MAXVAL) (PYINCHI_MAXVAL*0)

		i = 0
		for c in atname:
			elname[i] = ord(c)
			i = i + 1
		isotopic_mass = 0
            	if dd != 0:
                	isotopic_mass = dd + PYINCHI_ISOTOPIC_SHIFT_FLAG
		radical = 0
		if charge == 4:
                	radical = 2 #doublet
		else:
			if charge != 0:
				charge = 4 - charge
            
		iatom = inchi_Atom(
				x, y, z, 
			    	neighbor, # to be filled later
				bond_type, # to be filled later
				bond_stereo, # to be filled later
				elname, 
			    	0, # num_bonds, to be filled later
			    	num_iso_H, # to be filled later
			    	isotopic_mass, 
			    	radical, 
			    	charge
			    	)


		iatoms[ia] = iatom
		pia = pointer(iatoms[ia])
		piatoms[ia] = pia
		#print piatoms[ia]


	# Get bond block
	# push all bonding info to inchi_Atom structures

	bonds = info['Bonds']
	for b in bonds:
		atom1, atom2, type, stereo, topology,reac_center = b
		# fw.write('(%-d,%-d)\ttype=%-d\tster=%-d\ttopo=%-d\treac=%-d\n' %  b )
		j = atom1-1
		k = atom2-1
		# both atnums must be valid
		if ( (j>=0) and (j<nat) and (k>=0) and (k<nat) ):
			nbj = iatoms[j].num_bonds
			nbk = iatoms[k].num_bonds
			iatoms[j].neighbor[nbj] = k
				# getinchi does not like duplicated bonds
				# iatoms[k].neighbor[nbk] = j
			iatoms[j].bond_type[nbj] = type
				#iatoms[k].bond_type[nbk] = type
			iatoms[j].bond_stereo[nbj] = stereo
				#iatoms[k].bond_stereo[nbk] = stereo

			iatoms[j].num_bonds = nbj + 1
			#iatoms[k].num_bonds = nbk + 1



	# Process property lines

	lines = info['Prop']
	for line in lines:
		try:
			code = 	line[3:6]
			vals = string.split(line[7:],' ')		
			nf = len(vals)
			for k in range(nf-1,-1,-1):
				if vals[k] =='': del vals[k]
			nv = int(vals[0])
			if nv<1:
				continue
			if code=="ISO":
				#for j in range(nat):
					#iatoms[j].isotopic_mass = 0
				for j in range(1,2*nv+1,2):
					ia = int(vals[j]) - 1
					imass = int(vals[j+1])
					#print 'j',j, 'ia',ia
					if (ia<0) or (ia>nat):
						continue
					iatoms[ia].isotopic_mass = imass

			elif code=="CHG":
				#for j in range(nat):
					#iatoms[j].charge = 0
					#iatoms[j].radical = 0
				for j in range(1,2*nv+1,2):
					ia = int(vals[j]) - 1
					ichg = int(vals[j+1])	
					if (ia<0) or (ia>nat):
						continue
					iatoms[ia].charge = ichg

			elif code=="RAD":
				#for j in range(nat):
					#iatoms[j].charge = 0
					#iatoms[j].radical = 0
				for j in range(1,2*nv+1,2):
					ia = int(vals[j]) - 1
					irad = int(vals[j+1])	#1=singlet, 2=doublet, 3=triplet
				        if irad==1:
						#InChI should treat singlet (additional lone pair) as a triplet which reduces numH by 2
						irad = 3 
					#print 'j',j, 'ia',ia
					if (ia<0) or (ia>nat):
						continue
					iatoms[ia].radical = irad

		except:
			pass

	for ia in range(0,nat):
	        # need to use valences if any to find out number of H
		v = valences[ia]
		if v>0:
			# to do later...
			continue
		else:
			# let inchi hydrogenize automatically
			iatoms[ia].num_iso_H[0] = -1



	# Compose inchi_Input

	istereo0D = (inchi_Stereo0D * 1) ()
	pistereo0D = (POINTER(inchi_Stereo0D) * 1) ()

	iinput = inchi_Input(
			iatoms,		# inchi-style atoms
		    	istereo0D,      # stereo0D (empty)
		    	iopts, 		# command line switches
		    	nat, 		# natoms
		    	0		# num_stereo0D
			) 	


	# Prepare inchi_Output

	szInChI  = create_string_buffer(1) # NB: will be reallocd by inchi dll
	szIKey = create_string_buffer(256) # 
	szAuxInfo  = create_string_buffer(1) 
	szMessage = create_string_buffer(1) 
	szLog = create_string_buffer(1) 
	ioutput = inchi_Output( cast(pointer(szInChI), POINTER(c_char)),
			cast(szAuxInfo, POINTER(c_char)),
			cast(szMessage, POINTER(c_char)),
			cast(szLog, POINTER(c_char)) )



	# Call DLL function(s)

	result = getinchi(byref(iinput), byref(ioutput))  # 0 = okay, 
							  # 1 => warning, 
							  # 2=>error, 
							  # 3=>fatal


	# Process results

	si = make_pystring(ioutput.szInChI)
	fw.write('%-s\n' % si)

	if (result!=0) and (result!=1) :
		# error!
		if (fl!=sys.stdout):
			fl.write('RECORD %-d Name = %-s\t' %  (irec+1,name) )
		if (result==1):
			fl.write('Warning : ')
		else:
			fl.write('InChI creation error (%-d) : ' % result)
		fl.write('%-s\n' % make_pystring(ioutput.szMessage))

	else:
		# no error or just warnings
		if (ikey==1):
			result1 = getikey(ioutput.szInChI, szIKey)
			if (result1!=0):
				if (fl!=sys.stdout):
					fl.write('RECORD %-d Name = %-s\t' %  (irec+1,name) )
				fl.write('Key calculation error (%-d) : ' % result1)
			else:
				fw.write('InChIKey=%-s\n' % make_pystring(szIKey))


	if baux:
		fw.write('%-s\n' % make_pystring(ioutput.szAuxInfo))
	if inchilogmess=="":
		inchilogmess = make_pystring(ioutput.szLog)


	# Deallocate memory reallocated by inchi dll 

	freeinchi(byref(ioutput))


	return inchilogmess







if __name__ == "__main__":



	print "This Python demo program reads SD file and calls InChI DLL (libinchi.dll/libinchi.so.1)"
	print "functions to generate InChI strings and InChIKey codes."
	print "Note: the code in this example is provided for illustrative purposes only."
	print

	parser = OptionParser(usage="""\
Usage: %prog [options]
""")
	parser.add_option('-i', '--input',
                      	type='string', action='store',
                      	help='name of SD file to convert to INCHIes (required)')
	parser.add_option('-o', '--output',
                      	type='string', action='store',
                      	help='name of output file (default=inchi_out.txt)')
	parser.add_option('-l', '--log',
                      	type='string', action='store',
                      	help='name of log file (errors/warnings; default=stdout)')
	parser.add_option('-s', '--start_record',
                      	type='int', action='store',
                      	help='starting number of record to be converted')
	parser.add_option('-e', '--end_record',
                      	type='int', action='store',
                      	help='number of the last record to be converted')
	parser.add_option('-x', '--aux', dest='aux', 
			help='print auxilary info', default=False, action='store_true')
	parser.add_option('-k', '--key', dest='key', 
			help='calculate InChIKey', default=False, action='store_true')
	parser.add_option('-p', '--inchi_options', 
                      	type='string', action='store',
			help='string with InChI options')

	opts, args = parser.parse_args()

	if not opts.input:
		parser.print_help()
		sys.exit(1)
	fname = opts.input

	if opts.output:		
		fwrite = opts.output
	else:			
		fwrite = "inchi_out.txt"
	try:
		fw = open(fwrite,'wt')
	except:
		print "COUD NOT OPEN OUTPUT FILE"
		exit(2)

	if opts.inchi_options:
		iopts = opts.inchi_options
	else:
		iopts = ""

	if opts.log:
		try:
			fl = open(opts.log,'wt')
		except:
			print "COUD NOT OPEN LOG FILE"
			exit(3)
	else:
		fl = sys.stdout
	if not opts.aux:
		baux = 0
	else:
		baux = 1

	if not opts.key:
		ikey = 0
	else:
		ikey = 1

	startr = 0
	if opts.start_record:
		startr = opts.start_record
	else:
		startr = -1
	if opts.end_record:
		endr = opts.end_record
	else:
		endr = -1


        insdf = SDF_file()
        if not insdf.open(fname):
                print '\n* IO fatal error *'
                sys.exit(4)


	libname = ''
	opsys = sys.platform
	if (opsys[:3]=='win'):
		libname = 'libinchi.dll'
	else:
		if (opsys[:5]=='linux'):
			libname = '/usr/lib/libinchi.so.1'
	try:
		libinchi = cdll.LoadLibrary(libname)
		getinchi = libinchi.GetINCHI
		freeinchi = libinchi.FreeINCHI
		getikey = libinchi.GetINCHIKeyFromINCHI
	except:
		print '** ERROR ** Could not access InChI library', libname
		sys.exit()
	inchilogmess = ""
	timing = time.clock()
	i = -1
        while 1: 
		try:
			rec = insdf.readnext()
                	if rec == None:
               			break
			else:
       		        	i = i + 1
				if (i+1<startr):
					continue
				if (endr>0):
					if (i+1>endr):
						break
				print 'RECORD #',i+1
				inchilogmess = process_sdf_record(insdf,i,rec,
						   fw,fl,
						   iopts,baux,
						   getinchi,freeinchi,getikey, ikey,
						   inchilogmess)
		except:
			print "***ERROR IN RECORD",i+1,", SKIPPED"
			fw.write('***ERROR IN RECORD %-ld", SKIPPED\n'% i)

	 
	fl.write('\n[Used InChI %-s]\n' %  inchilogmess )
	

	
	timing = time.clock() - timing
	fl.write( '\nELAPSED TIME: %-.2f SEC' % timing )

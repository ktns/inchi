/*
 * International Chemical Identifier (InChI)
 * Version 1
 * Software version 1.02-beta
 * August 23, 2007
 * Developed at NIST
 *
 * The InChI library and programs are free software developed under the
 * auspices of the International Union of Pure and Applied Chemistry (IUPAC);
 * you can redistribute this software and/or modify it under the terms of 
 * the GNU Lesser General Public License as published by the Free Software 
 * Foundation:
 * http://www.opensource.org/licenses/lgpl-license.php
 */


RunINCHI_Py   contains a sample program illustrating how the 
============  InChI library functions may be called from within Python.
	      It has a simple Mol/SDfile reader and  produces InChI strings 
	      for a SD file and, optionally, generates InChIKey.

              Tested with Python 2.5.1 under MS Windows XP Pro SP2 and
              Python 2.5 under Fedora Core 7.

              It is assumed that under Wiindows the InChI library name is 
              'libinchi.dll' while under Linux it is '/usr/lib/libinchi.so.1'
              (see readme.txt file in INCHI_API/gcc_so_makefile folder
              for the description of InChI software library creation).

              Note that this Python program should not be used as an 
              InChI generator. The code in this example is provided for 
              illustrative purposes only. It does not extensively check 
              the input data and does not provide any diagnostic concerning 
              input structure(s).
              Due to its simplicity, this SDFile reader cannot interpret
              correctly some of molfile features properly interpreted
              by cInChI-1.		




Usage:  make_inchi.py [options]

Example:
	make_inchi.py -i test1.sd -o out1 -l log1 -x -k -p "/RecMet /fb /FixedH"

Options:
  -h, --help            show this help message and exit
  -i INPUT, --input=INPUT
                        name of SD file to convert to INCHIes (required)
  -o OUTPUT, --output=OUTPUT
                        name of output file (default=inchi_out.txt)
  -l LOG, --log=LOG     name of log file (errors/warnings; default=stdout)
  -s START_RECORD, --start_record=START_RECORD
                        starting number of record to be converted
  -e END_RECORD, --end_record=END_RECORD
                        number of the last record to be converted
  -x, --aux             print auxilary info
  -k, --key             calculate InChIKey
  -p INCHI_OPTIONS, --inchi_options=INCHI_OPTIONS
                        string with InChI options



Files:
make_inchi.py
-------------
	Main program.
PyINCHI.py         
-------------
	Python interface to INCHI library
lightsdf.py
-------------
	Light SDF reader: parses SD file records and collects information
libinchi.dll
-------------
	dynamic-link InChI library 

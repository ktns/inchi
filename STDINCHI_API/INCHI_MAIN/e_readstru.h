/*
 * International Chemical Identifier (InChI)
 * Version 1
 * Software version 1.02
 * October 31, 2008
 * Developed at NIST
 *
 * The InChI library and programs are free software developed under the
 * auspices of the International Union of Pure and Applied Chemistry (IUPAC);
 * you can redistribute this software and/or modify it under the terms of 
 * the GNU Lesser General Public License as published by the Free Software 
 * Foundation:
 * http://www.opensource.org/licenses/lgpl-license.php
 */


#ifndef __READSTRU_H__
#define __READSTRU_H__


#ifndef INCHI_ALL_CPP
#ifdef __cplusplus
extern "C" {
#endif
#endif



int e_ReadStructure(STRUCT_DATA *sd, INPUT_PARMS *ip, 
                    INCHI_IOSTREAM *inp_file, 
                    INCHI_IOSTREAM *log_file, INCHI_IOSTREAM *output_file, INCHI_IOSTREAM *prb_file,
                    inchi_Input *pInp, long num_inp,  /* for CML:*/ int inp_index, int *out_index );


#ifndef INCHI_ALL_CPP
#ifdef __cplusplus
}
#endif
#endif


#endif /* __READSTRU_H__ */

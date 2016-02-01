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


#ifndef __ICHI_PARMS_H__
#define __ICHI_PARMS_H__



#ifndef INCHI_ALL_CPP
#ifdef __cplusplus
extern "C" {
#endif
#endif


int e_ReadCommandLineParms( int argc, const char *argv[], INPUT_PARMS *ip, char *szSdfDataValue,
                          unsigned long *ulDisplTime, int bReleaseVersion, INCHI_FILE *log_file );

int e_PrintInputParms( INCHI_FILE *log_file, INPUT_PARMS *ip );
int e_OpenFiles( FILE **inp_file, FILE **output_file, FILE **log_file, FILE **prb_file, INPUT_PARMS *ip );
void e_HelpCommandLineParms( INCHI_FILE *f );
#ifdef CREATE_INCHI_STEP_BY_STEP
void e_HelpCommandLineParmsReduced( INCHI_FILE *f );
#endif





#ifndef INCHI_ALL_CPP
#ifdef __cplusplus
}
#endif
#endif

#endif /* __ICHI_PARMS_H__ */

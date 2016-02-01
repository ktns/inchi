/*
 * International Union of Pure and Applied Chemistry (IUPAC)
 * International Chemical Identifier (InChI)
 * Version 1
 * Software version 1.01
 * July 21, 2006
 * Developed at NIST
 */

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <math.h>
#include <float.h>
#include <string.h>
#include <ctype.h>

/* for use in the main program */


#include "e_mode.h"
#include "inchi_api.h"
#include "e_ctl_data.h"
#include "e_inchi_atom.h"
#include "e_ichi_io.h"

#include "e_ichisize.h"
#include "e_comdef.h"
#include "e_util.h"
#include "e_ichierr.h"
#include "e_ichicomp.h"
#include "e_readstru.h"
#include "e_inpdef.h"

/* rename to avoid duplicated entry points */

#define mystrncpy            e_mystrncpy       
#define LtrimRtrim           e_LtrimRtrim      
#define FreeInchi_Atom       e_FreeInchi_Atom
#define FreeInchi_Stereo0D   e_FreeInchi_Stereo0D
#define CreateInchi_Atom     e_CreateInchi_Atom
#define CreateInchi_Stereo0D e_CreateInchi_Stereo0D
#define FreeInchi_Input      e_FreeInchi_Input
#define AddMOLfileError      e_AddMOLfileError
#define my_fgets             e_my_fgets
#define my_fgetsTab          e_my_fgetsTab 
#define my_fgetsTab1         e_my_fgetsTab1 
#define is_in_the_slist      e_is_in_the_slist
#define is_element_a_metal   e_is_element_a_metal
#define INChIToInchi_Atom    e_INChIToInchi_Atom
#define INChIToInchi_Input   e_INChIToInchi_Input

#define IGNORE_HEADERS
#define STATIC

/* This contains executable code. Included in lReadAux.c, e_ReadINCH.c, ReadINCH.c,  */
#include "../INCHI_DLL/aux2atom.h"


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



/*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

InChI - API v. 1.02-beta

Demo caller using new library interface (see main() below)

Activated if (CREATE_INCHI_STEP_BY_STEP==1) [e_mode.h]

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/




#if( defined( WIN32 ) && defined( _CONSOLE ) && defined(_MSC_VER) && _MSC_VER >= 800 )
#define ADD_WIN_CTLC   /* detect Ctrl-C under Win-32 and Microsoft Visual C ++ */
#endif

#if( defined( WIN32 ) && defined( _CONSOLE ) && defined(_MSC_VER) && _MSC_VER >= 800 && defined(ADD_WIN_CTLC) && !(defined(__STDC__) && __STDC__ == 1) )
#include <windows.h>
#endif


/* #define CREATE_0D_PARITIES */      /* uncomment to replace coordinates and 2D-parirties with 0D-parities */
/* in case of CREATE_0D_PARITIES, the hardcoded bFixSp3Bug = 1 fixes sp3 bugs in original InChI v. 1.00  */
/* in case of CREATE_0D_PARITIES, the Phosphine and Arsine sp3 stereo options are not supported */

#define NEIGH_ONLY_ONCE               /* comment out to include each bond in both neighboring atoms adjacency lists */


#include <stdio.h>
#include <stdlib.h>

#include <string.h>
#include <ctype.h>
#include <stdarg.h>
#include <errno.h>
#include <limits.h>
#include <float.h>
#include <time.h>

#include "e_mode.h"
#ifdef CREATE_INCHI_STEP_BY_STEP

#include "e_ctl_data.h"

#include "inchi_api.h"      


#include "e_inchi_atom.h"
#include "e_ichi_parms.h"
#include "e_util.h"
#include "e_ichi_io.h"
#include "e_ichierr.h"
#include "e_readstru.h"
#include "e_ichicomp.h"
#ifdef CREATE_0D_PARITIES
#include "e_0dstereo.h"
#endif




/*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Local prototypes.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
static char *e_stristr(const char * string1, const char * string2);
int e_MakeOutputHeader(char *pSdfLabel, char *pSdfValue, long lSdfId, long num_inp, char *pStr1, char *pStr2);
char *e_GetChiralFlagString( int bChiralFlagOn );
static int e_bEnableCmdlineOption(char *szCmdLine, const char *szOption, int bEnable);


/*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Console-specific
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/

/*^^^ Ctrl+C trap; works under Win32 + MS VC++ */
int e_bInterrupted = 0;
int stop = 0;
#if( defined( _WIN32 ) && defined( _CONSOLE ) )
#if( defined(_MSC_VER) && _MSC_VER >= 800 && defined(ADD_WIN_CTLC) && !(defined(__STDC__) && __STDC__ == 1) )
BOOL WINAPI MyHandlerRoutine(DWORD dwCtrlType)   /*   control signal type */
{
    if ( dwCtrlType == CTRL_C_EVENT     ||
         dwCtrlType == CTRL_BREAK_EVENT ||
         dwCtrlType == CTRL_CLOSE_EVENT ||
         dwCtrlType == CTRL_LOGOFF_EVENT ) {
        e_bInterrupted = 1;
        return TRUE;
    }
    return FALSE;
}
#endif
int e_WasInterrupted(void) 
{
#ifdef _DEBUG            
    if ( e_bInterrupted ) stop=1;  /*  for debug only <BRKPT> */
#endif
    return e_bInterrupted;
}

#endif


#define EXIT_ON_ERR





/*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

main(): caller program demonstrating 'another InChI library interface'
        and InChIKey calculation

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/

int main( int argc, char *argv[ ] )
{
#define nStrLen 256
int bReleaseVersion = bRELEASE_VERSION;

FILE    *inp_file = NULL, *output_file = NULL, *log_file = NULL, *prb_file = NULL;
char    szSdfDataValue[MAX_SDF_VALUE+1];
char    szInchiCmdLine[512];
char    pStrInchiId[nStrLen], pStrLogId[nStrLen];
const   char *p1, *p2;


int   retcode= 0, retcode1 = 0,  i, k, tot_len;
int   inp_index, out_index;
int   nStructNo;

long  lSdfId;
long num_inp, num_err, num_output;

INPUT_PARMS inp_parms, *ip = &inp_parms;
STRUCT_DATA struct_data, *sd = &struct_data;

inchi_Input inchi_inp,      *pInp   = &inchi_inp;
inchi_Output genout, *pResults = &genout;
INCHIGEN_DATA       inchi_gendata,      *pGenData   = &inchi_gendata;
INCHIGEN_HANDLE  HGen = NULL;

char *pinfo;
int len_mess=0, len_mess1, mshift=0, was_print = 0;
char ik_string[256];    /*^^^ Resulting InChIKey string */
int ik_ret=0;           /*^^^ InChIKey-calc result code */

unsigned long  ulDisplTime = 0;    /*  infinite, milliseconds */
time_t elapsed;




/*^^^ Set debug output */

#if (TRACE_MEMORY_LEAKS == 1)

    _CrtSetDbgFlag(_CRTDBG_CHECK_ALWAYS_DF | _CRTDBG_LEAK_CHECK_DF | _CRTDBG_ALLOC_MEM_DF);
    /* for execution outside of the VC++ debugger uncomment one of the following two */
    /*#define MY_REPORT_FILE  _CRTDBG_FILE_STDERR */
    /*#define MY_REPORT_FILE  _CRTDBG_FILE_STDOUT */
#ifdef MY_REPORT_FILE 
   _CrtSetReportMode( _CRT_WARN, _CRTDBG_MODE_FILE );
   _CrtSetReportFile( _CRT_WARN, MY_REPORT_FILE );
   _CrtSetReportMode( _CRT_ERROR, _CRTDBG_MODE_FILE );
   _CrtSetReportFile( _CRT_ERROR, MY_REPORT_FILE );
   _CrtSetReportMode( _CRT_ASSERT, _CRTDBG_MODE_FILE );
   _CrtSetReportFile( _CRT_ASSERT, MY_REPORT_FILE );
#else
    _CrtSetReportMode(_CRT_WARN | _CRT_ERROR, _CRTDBG_MODE_DEBUG);
#endif
   /* turn on floating point exceptions */
#if ( !defined(__STDC__) || __STDC__ != 1 )
    {
        /* Get the default control word. */
        int cw = _controlfp( 0,0 );

        /* Set the exception masks OFF, turn exceptions on. */
        /*cw &=~(EM_OVERFLOW|EM_UNDERFLOW|EM_INEXACT|EM_ZERODIVIDE|EM_DENORMAL);*/
        cw &=~(EM_OVERFLOW|EM_UNDERFLOW|EM_ZERODIVIDE|EM_DENORMAL);

        /* Set the control word. */
        _controlfp( cw, MCW_EM ); 
    }
#endif

#endif /* #if (TRACE_MEMORY_LEAKS == 1) */




/*^^^ Set Ctrl+C trap under Win32 + MS VC++ */

#if( defined( _WIN32 ) && defined( _CONSOLE ) && defined(_MSC_VER) && _MSC_VER >= 800 && defined(ADD_WIN_CTLC) && !(defined(__STDC__) && __STDC__ == 1))
    if ( SetConsoleCtrlHandler( MyHandlerRoutine, 1 ) ) 
    {
        ; /*ConsoleQuit = WasInterrupted*/;
    }
#endif



    num_inp    = 0;
    num_err    = 0;
    num_output = 0;

    /*^^^ Set original input structure */
    memset(pInp, 0, sizeof(*pInp));
    memset(pResults, 0, sizeof(*pResults));
    memset(pGenData, 0, sizeof(*pGenData));
    memset(szSdfDataValue, 0, sizeof(szSdfDataValue));
    
    /*^^^ Check command line */
    if ( argc < 2 || argc==2 && ( argv[1][0]==INCHI_OPTION_PREFX ) &&
        (!strcmp(argv[1]+1, "?") || !stricmp(argv[1]+1, "help") ) ) 
    {
        /* e_HelpCommandLineParms(stdout); */
        e_HelpCommandLineParmsReduced(stdout);
        return 0;
    }
                
    if ( 0 > e_ReadCommandLineParms( argc, (const char **)argv, ip, szSdfDataValue, &ulDisplTime, bReleaseVersion, NULL ) ) 
                                    /*^^^ Explicitly cast to (const char **) to avoid a 
                                          warning about "incompatible pointer type":*/
        goto exit_function;



    /*^^^ Create InChI generator object. */
    HGen = INCHIGEN_Create();
    if (NULL==HGen)
    {
        /*^^^ Probably, out of RAM. Could do nothing. */
        e_my_fprintf( stderr, "Could not create InChI generator (out of RAM?)\n" );
        goto exit_function;
    }


    /*^^^ Open files. */
    if ( !e_OpenFiles( &inp_file, &output_file, &log_file, &prb_file, ip ) ) 
        goto exit_function;


    /*^^^ Set input labelling opts */
    if ( ip->bNoStructLabels ) 
    {
        ip->pSdfLabel = NULL;
        ip->pSdfValue = NULL;
    } 
    else
    if ( ip->nInputType == INPUT_INCHI_PLAIN  ||
         ip->nInputType == INPUT_INCHI_XML    ||
         ip->nInputType == INPUT_CMLFILE      ) 
    {
        /* the input may contain both the header and the label of the structure */
        if ( !ip->pSdfLabel )   ip->pSdfLabel  = ip->szSdfDataHeader;
        if ( !ip->pSdfValue )   ip->pSdfValue  = szSdfDataValue;
    }
    e_PrintInputParms( log_file, ip );
    pStrInchiId[0] = '\0';




    /*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                Main cycle:  read input structures and create their InChI
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/    
    
    out_index = 0;
    
    elapsed = time(NULL); 

    while (!e_bInterrupted) 
    {

        int bHasTimeout = 0;
        if ( ip->last_struct_number && num_inp >= ip->last_struct_number ) 
        {
            retcode = _IS_EOF; /*  simulate end of file */
            goto exit_function;
        }

        /*^^^ Create command line */
        szInchiCmdLine[0] = '\0';
        for ( i = 1; i < argc; i ++ ) 
        {
            if ( argv[i] && INCHI_OPTION_PREFX == argv[i][0] && argv[i][1] ) 
            {
                /*^^^ Omit certain options */
                if ( !memicmp( argv[i]+1, "start:", 6) ||
                     !memicmp( argv[i]+1, "end:",   4) ||
                     !stricmp( argv[i]+1, "Tabbed" )
                     ) 
                {
                    continue;
                }

                if ( !stricmp( argv[i]+1, "Inchi2Inchi" ) ) 
                {
                    e_my_fprintf( stderr, "\n\rOption Inchi2Inchi is currently not supported (use classic interface). \n"  );
                    goto exit_function;
                }
                if ( !stricmp( argv[i]+1, "Inchi2Struct" ) ) 
                {
                    e_my_fprintf( stderr, "\n\rOption Inchi2Struct is currently not supported (use classic interface). \n"  );
                    goto exit_function;
                }
 

                if ( !memicmp( argv[i]+1, "w", 1 ) && isdigit( UCINT argv[i][2] ) ) 
                {
                    bHasTimeout = 1;
                }
                /*^^^ Add option to szInchiCmdLine */
                if ( strlen(szInchiCmdLine)+strlen(argv[i]) + 4 < sizeof(szInchiCmdLine) ) 
                {
                    if ( szInchiCmdLine[0] )
                        strcat( szInchiCmdLine, " " );
                    k = ( !(k=strcspn( argv[i], " \t" )) || argv[i][k] ); /* k means enclose in "" */
                    if (k)
                        strcat( szInchiCmdLine, "\"" );
                    strcat( szInchiCmdLine, argv[i] );
                    if (k)
                        strcat( szInchiCmdLine, "\"" );
                } else 
                {
                    e_my_fprintf( stderr, "Too many options. Option \"%s\" ignored\n", argv[i] );
                }
            }
        }
        if ( !bHasTimeout ) 
        {
            /*^^^ Add default timeout option -W60: 60 seconds */
            char szW60[] = " ?W60";
            szW60[1] = INCHI_OPTION_PREFX;
            if ( strlen(szInchiCmdLine) + strlen( szW60 ) < sizeof(szInchiCmdLine) ) 
                strcat( szInchiCmdLine, szW60 );
            else 
                e_my_fprintf( stderr, "Too many options. Option \"%s\" ignored\n", szW60 );
        }
        /*^^^ End of command line deal */


        /*^^^ Skip input cycle */
        while(!e_bInterrupted) 
        {
            inp_index = out_index;
            
            
            /*^^^ Read one structure from input */
            e_FreeInchi_Input( pInp );



            retcode = e_ReadStructure( sd, ip, inp_file, log_file, output_file, prb_file, pInp, num_inp+1,
                          /* for CML:*/ inp_index, &out_index );


            if ( _IS_SKIP != retcode) 
            {
                lSdfId    = ( ip->bGetSdfileId )? ip->lSdfId : 0; /* if requested then CAS r.n. otherwise struct. number*/
                nStructNo = ( ip->lMolfileNumber > 0 )? ip->lMolfileNumber : num_inp+1;
                e_MakeOutputHeader( ip->pSdfLabel, ip->pSdfValue, lSdfId, nStructNo, pStrInchiId, pStrLogId );
            }
            
            /* e_ReadStructure() outputs the error/warning messages, so we do not need to re-output them here */
            switch (retcode) 
            {
            case _IS_FATAL:
                num_inp ++;
                num_err ++;
                goto exit_function;
            case _IS_EOF:
                e_my_fprintf( stderr, "\rStructure %d could not be read: Detected end of file. \r", num_inp+1 );
                goto exit_function;
            case _IS_ERROR:
                num_inp ++;
                num_err ++;
                continue;
            case _IS_SKIP:
                num_inp ++;
                continue;
            }
            break;
        }
        if ( e_bInterrupted ) 
        {
            e_my_fprintf( log_file, "\nStructure %d could not be read: User Quit.\n", num_inp+1 );
            num_err ++;
            goto exit_function;
        }
        

        /*^^^ Analyze the chiral flag */
        
        p1 = NULL;       
        if ( (ip->nMode & REQ_MODE_CHIR_FLG_STEREO) && (ip->nMode & REQ_MODE_STEREO) &&
             ( ip->bChiralFlag & (FLAG_SET_INP_AT_CHIRAL | FLAG_SET_INP_AT_NONCHIRAL) ) ) 
                ; /* cmd line has priority over the chiral flag in Molfile */

        else if ( sd->bChiralFlag & FLAG_INP_AT_CHIRAL ) 
            p1 =  e_GetChiralFlagString( 1 );  /* input file has chiral flag */

        else if ( (ip->nMode & REQ_MODE_CHIR_FLG_STEREO) && (ip->nMode & REQ_MODE_STEREO) ||
             (sd->bChiralFlag & FLAG_INP_AT_NONCHIRAL) )  /* fix 04/05/2005 D.T.*/
            /* chiral flag requested (/SUCF) or input has non-chiral flag */
            p1 =  e_GetChiralFlagString( 0 );

        if (p1) 
            if ( strlen(szInchiCmdLine) + strlen( p1 ) < sizeof(szInchiCmdLine) ) 
                strcat( szInchiCmdLine, p1 );
            else 
                e_my_fprintf( stderr, "Too many options. Option \"%s\" ignored\n", p1 );

        pInp->szOptions = szInchiCmdLine;


        /*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        create INChI for each connected component of the structure and optionally 
        display them; output INChI for the whole structure.
        Use compartmentalized library interface.
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/

#ifdef CREATE_0D_PARITIES
        if ( !pInp->stereo0D && !pInp->num_stereo0D ) 
        {
            int bPointedEdgeStereo = (0 != (TG_FLAG_POINTED_EDGE_STEREO & ip->bTautFlags));
            set_0D_stereo_parities( pInp, bPointedEdgeStereo );
            Clear3D2Dstereo(pInp);
        }
#endif
#ifdef NEIGH_ONLY_ONCE
        e_RemoveRedundantNeighbors(pInp);
#endif

        len_mess = len_mess1 = 0;
        pinfo = (char*) &(pGenData->pStrErrStruct);
        was_print = 0;



        /*^^^ Set up */
        retcode = INCHIGEN_Setup( HGen, pGenData, pInp );
        
        len_mess1 = strlen(pinfo);
        if (len_mess1 > len_mess)
        {
            mshift = len_mess?1:0;
            e_my_fprintf(log_file, "*** %-s [Initialization] %-s\n", pStrLogId, pinfo+len_mess+mshift);
            len_mess = len_mess1;
            was_print = 1;
        }

            

        /*^^^ Normalization step */
        if ( (retcode == inchi_Ret_OKAY) || (retcode == inchi_Ret_WARNING) )
        {

            retcode = INCHIGEN_DoNormalization(HGen, pGenData);
        
            len_mess1 = strlen(pinfo);
            if (len_mess1 > len_mess)
            {
                mshift = len_mess?1:0;
                e_my_fprintf(log_file, "*** %-s [Normalization] %-s\n", pStrLogId, pinfo+len_mess+mshift);
                len_mess = len_mess1;
                was_print = 1;
            }

#ifdef OUTPUT_NORMALIZATION_DATA
            {
                int ic, istruct, itaut, ia, ib, nc[2];
                NORM_ATOMS *inp_norm_data[TAUT_NUM]; /*  = { &NormAtomsNontaut, &NormAtomsTaut}; */
                NORM_ATOM *atom;
                nc[0] = pGenData->num_components[0];
                nc[1] = pGenData->num_components[1];
                e_my_fprintf(log_file, "=== %-s Intermediate normalization data follow", pStrLogId);
                for (istruct=0; istruct<2; istruct++)
                {
                    /*^^^ Print results for 1) original/disconnected structure and 
                                            2)reconnected structure */
                    if (nc[istruct]>0)
                    {
                        if (istruct==0)
                            e_my_fprintf(log_file, "\n\tOriginal/disconnected structure: ");
                        else
                            e_my_fprintf(log_file, "\n\tReconnected structure: ");
                        e_my_fprintf(log_file, "%-d component(s)\n", nc[istruct]);
                        e_my_fprintf(log_file, "\t===============================================\n");
                        
                        for (ic=0; ic < nc[istruct]; ic++)
                        {
                            /* Print results for each component of the structure */
                            inp_norm_data[0] = &(pGenData->NormAtomsNontaut[istruct][ic]);
                            inp_norm_data[1] = &(pGenData->NormAtomsTaut[istruct][ic]);
                            for (itaut=0;itaut<2;itaut++)
                            {
                                /* Print results for 1) non-tautomeric and 
                                                     2) tautomeric  version (if present) 
                                                     of the component                   */
                                if (NULL!=inp_norm_data[itaut])
                                {

                                    if (inp_norm_data[itaut]->num_at>0)
                                    {
                                        if (itaut==0)
                                            e_my_fprintf(log_file, "\tComponent %-d, non-tautomeric:", ic+1);
                                        else
                                            e_my_fprintf(log_file, "\tComponent %-d, tautomeric:", ic+1);

                                        e_my_fprintf(log_file, "\t%-d atom(s)\n", inp_norm_data[itaut]->num_at);
    
                                        for (ia=0; ia< inp_norm_data[itaut]->num_at; ia++)
                                        {               
                                            /*^^^ Print data for each atom */
                                            if (inp_norm_data[itaut]->at != NULL)
                                            {
                                                atom = &( inp_norm_data[itaut]->at[ia] );
                                                if (NULL!=atom)
                                                {
                                                    /*^^^ Print: element, number, original number, no. of Hs, 
                                                                 charge, coordination number, valence */
                                                    e_my_fprintf(log_file, "\t\tatom %-s%-d (orig.%-s%-d) [H%-d] charge=%-+d  CN=%-d val=%-d ", 
                                                        atom->elname, ia+1, atom->elname, atom->orig_at_number, atom->num_H, atom->charge, 
                                                        atom->valence, atom->chem_bonds_valence);
                                                    if (atom->valence > 0)
                                                    {
                                                        /*^^^ Neighbors */
                                                        e_my_fprintf(log_file, "nbrs { ");
                                                        for (ib=0; ib <atom->valence; ib++)
                                                        {
                                                            e_my_fprintf(log_file, "%-d ", atom->neighbor[ib]+1);
                                                        }
                                                        e_my_fprintf(log_file, "}");
                                                    }
                                                    /* Indicate if atom shares Hs with others */
                                                    if (atom->endpoint > 0)
                                                    {
                                                        e_my_fprintf(log_file, "\n\t\t(in taut. group: %-d)", atom->endpoint);
                                                    }
                                                    e_my_fprintf(log_file, "\n");
                                                }
                                            }
                                        }
                                    }

                                }
                            }
                    
                        }
                    }
                }

            }
#endif
        }
        
        /*^^^ Canonicalization step */
        if ( (retcode == inchi_Ret_OKAY) || (retcode == inchi_Ret_WARNING) )
        {
            retcode = INCHIGEN_DoCanonicalization( HGen, pGenData );

            len_mess1 = strlen(pinfo);
            if (len_mess1 > len_mess)
            {
                mshift = len_mess?1:0;
                e_my_fprintf(log_file, "*** %-s [Canonicalization] %-s\n", pStrLogId, pinfo+len_mess+mshift);
                len_mess = len_mess1;
                was_print = 1;
            }           
        }

        /*^^^ Serialization (final) step */
        if ( (retcode == inchi_Ret_OKAY) || (retcode == inchi_Ret_WARNING) ) 
        {
            retcode1 = INCHIGEN_DoSerialization(HGen, pGenData, pResults);
            retcode = inchi_max(retcode , retcode1);


            len_mess1 = strlen(pinfo);
            if (len_mess1 > len_mess)
            {
                mshift = len_mess?1:0;
                e_my_fprintf(log_file, "*** %-s [Serialization] %-s\n", pStrLogId, pinfo+len_mess+mshift);
                was_print = 1;
            }

        }

/*
        if (!was_print)
            e_my_fprintf(log_file, "*** %-s        \r", pStrLogId);
*/
        

        /*^^^ Output err/warn */
        if ( pResults->szMessage && pResults->szMessage[0] )    { p1 = "; "; p2 = pResults->szMessage; } 
        else                                            p1 = p2 = "";


        switch (retcode) 
        {
        case inchi_Ret_UNKNOWN:
        case inchi_Ret_FATAL: /* fatal processing error -- typically, memory allocation error */
            num_inp ++;
            num_err ++;
            e_my_fprintf( log_file, "Fatal Error (No INChI%s%s) %s\n", p1, p2, pStrLogId );
            e_my_fprintf( log_file, "Log start:---------------------\n%s\nLog end--------------------\n", pResults->szLog? pResults->szLog : "Log is missing" );
            /*^^^ Free InChI library memories */
            INCHIGEN_Reset(HGen, pGenData, pResults);
            goto exit_function;
        case inchi_Ret_EOF: /* typically, no input structure provided or help requested */
            /* output previous structure number and message */
            e_my_fprintf( log_file, "End of file detected after structure %d\n", num_inp );
            goto exit_function;
        case inchi_Ret_ERROR:
            num_inp ++;
            num_err ++;
            e_my_fprintf( log_file, "Error (No INChI%s%s) %s\n", p1, p2, pStrLogId );
            /*^^^ Free InChI library memories */
            INCHIGEN_Reset(HGen, pGenData, pResults);
            continue;
        case inchi_Ret_SKIP:
            num_inp ++;
            e_my_fprintf( log_file, "Skipped %s\n", pStrLogId );
            goto exit_function;
        case inchi_Ret_OKAY:
            break;
        case inchi_Ret_WARNING:
            /*^^^ Suppress warnings, we display them step by steps */
            /*^^^
            if ( p2 && p2[0] ) 
                e_my_fprintf( log_file, "Warning (%s) %s\n", p2, pStrLogId );
            */
            break; /* ok */
        }

        num_inp ++;
        tot_len = 0;
        if ( pResults->szInChI && pResults->szInChI[0] ) 
        {
            if (ip->bINChIOutputOptions & INCHI_OUT_SDFILE_ONLY ) 
            {
                /*^^^ output SDfile */
                char *start;
                unsigned len;
                int bAddLabel = 0;
                /*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                output a SDfile. pResults->szInChI contains Molfile ending with "$$$$\n" line.  
                Replace the 1st line with the structure number                              
                Replace the last line with the SDfile header, label, and new "$$$$\n" line  
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/


                start = pResults->szInChI;
                
                /*^^^ 2. SDfile header and data: write zero to the 1st byte of
                         the last line "$$$$\n" to remove this line with purpose to relpace it */
                if ( ip->pSdfLabel && ip->pSdfLabel[0] && ip->pSdfValue && ip->pSdfValue[0] &&
                     (len = strlen(start)) && len > 5 && '$' == start[len-5] && '\n' == start[len-6] ) {
                    start[len-5] = '\0';
                    bAddLabel = 1;
                }

                /*^^^ 3. Output the whole Molfile */
                e_inchi_print( output_file, "%s", start );
                if ( bAddLabel ) 
                {
                    e_inchi_print( output_file, ">  <%s>\n%s\n\n$$$$\n", ip->pSdfLabel, ip->pSdfValue );
                }

            } /* if (ip->bINChIOutputOptions & INCHI_OUT_SDFILE_ONLY ) */

            else 
            
            {
                /*^^^ Print InChI */
                int bTabbed  = 0 != ( ip->bINChIOutputOptions & INCHI_OUT_TABBED_OUTPUT );
                int bAuxInfo = !( ip->bINChIOutputOptions & INCHI_OUT_ONLY_AUX_INFO ) &&
                               pResults->szAuxInfo && pResults->szAuxInfo[0];
                const char *pLF  = "\n";
                const char *pTAB = bTabbed? "\t" : pLF;
                if ( !ip->bNoStructLabels ) 
                {
                    /* Print a previously created label string */
                    e_inchi_print(output_file, "%s%s", pStrInchiId, pTAB);
                }

                /*^^^ Print INChI Identifier */

                e_inchi_print(output_file, "%s%s", pResults->szInChI, bAuxInfo? pTAB : pLF);
                /*^^^ Print INChI Aux Info */
                if ( bAuxInfo ) 
                    e_inchi_print(output_file, "%s\n",pResults->szAuxInfo);
            }

        } /* if ( pResults->szInChI && pResults->szInChI[0] )  */


        /*^^^ Calculate InChIKey */
        if ( ip->bCalcInChIKey == 1 )
        {
            ik_ret = GetINCHIKeyFromINCHI(pResults->szInChI, ik_string);                     
        
            if (ik_ret==INCHIKEY_OK)    
                e_inchi_print(output_file, "InChIKey=%-s\n",ik_string);
            else    
            {
                e_my_fprintf(log_file, "Warning: could not compute InChIKey for #%-d ", 
                                         num_inp);
                switch(ik_ret)
                {
                case INCHIKEY_UNKNOWN_ERROR:
                        e_my_fprintf(log_file, "(invalid key length requested)\n");
                        break;
                case INCHIKEY_EMPTY_INPUT:
                        e_my_fprintf(log_file, "(got an empty string)\n");
                        break;
                case INCHIKEY_NOT_INCHI_INPUT:
                        e_my_fprintf(log_file, "(got non-InChI string)\n");
                        break;
                case INCHIKEY_NOT_ENOUGH_MEMORY:
                        e_my_fprintf(log_file, "(not enough memory to treat the string)\n");
                        break;
                case INCHIKEY_ERROR_IN_FLAG_CHAR:
                        e_my_fprintf(log_file, "(detected error in flag character)\n");
                        break;
                default:e_my_fprintf(log_file, "(internal program error)\n");
                        break;
                }
            }

        }



        /*^^^ Free InChI library memories */
        INCHIGEN_Reset(HGen, pGenData, pResults);

    } /* while ( !e_bInterrupted ) */




    if (e_bInterrupted) 
    {
        e_my_fprintf( log_file, "\nStructure %d could not be processed: User Quit.\n", num_inp+1 );
        num_err ++;
        goto exit_function;
    }



/*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
exit_function:
    
    e_my_fprintf( log_file, "\nProcessed %ld structure%s, %ld error%s.\n",
                 num_inp, (num_inp==1)?"":"s", num_err, (num_err==1)?"":"s" );
    
    elapsed-= time(NULL); 
    e_my_fprintf( log_file,"\nElapsed time: %ld\"\n", -elapsed);
        

    
    /*^^^ Freeing/closing */
    e_FreeInchi_Input( pInp );

    INCHIGEN_Destroy(HGen);

#if( ADD_CMLPP == 1 )
        /* BILLY 8/6/04 */
        /* free CML memory */
        FreeCml ();
        FreeCmlDoc( 1 );
#endif
    for (i = 0; i<MAX_NUM_PATHS; i++) 
    {
        if ( ip->path[i] ) 
        {
            e_inchi_free( (char*) ip->path[i] ); /*  cast deliberately discards 'const' qualifier */
            ip->path[i] = NULL;
        }
    }
    if (inp_file && inp_file != stdin)      fclose (inp_file);
    if (prb_file)                           fclose (prb_file);
    if (output_file&&output_file!= stdout)  fclose(output_file);
    if (log_file && log_file != stderr)     fclose(log_file);    

    return 0;
}




/*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Local helper.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
int e_MakeOutputHeader( char *pSdfLabel, char *pSdfValue, long lSdfId, long num_inp, char *pStr1, char *pStr2  )
{
    int tot_len1 = 0, tot_len2 = 0;
    pStr1[0] = '\0';
    if ( !(pSdfLabel && pSdfLabel[0]) && !(pSdfValue && pSdfValue[0]) ) 
    {
        tot_len1 = sprintf( pStr1, "Structure: %ld", num_inp );
        tot_len2 = sprintf( pStr2, "structure #%ld", num_inp );
    } 
    else 
    {
        tot_len1 = sprintf( pStr1, "Structure: %ld.%s%s%s%s",
            num_inp, SDF_LBL_VAL(pSdfLabel, pSdfValue) );

        tot_len2 = sprintf( pStr2, "structure #%ld.%s%s%s%s",
            num_inp, SDF_LBL_VAL(pSdfLabel, pSdfValue) );
        if (lSdfId) 
        {
            tot_len1 += sprintf( pStr1 + tot_len1, ":%ld", lSdfId );
            tot_len2 += sprintf( pStr2 + tot_len2, ":%ld", lSdfId );
        }
    }
    return tot_len1;
}
/*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Local helper.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
char *e_GetChiralFlagString( int bChiralFlagOn )
{
    static char szChiralFlag[64];
    szChiralFlag[0] = ' ';
    szChiralFlag[1] = INCHI_OPTION_PREFX;
    sprintf( szChiralFlag+2, "ChiralFlag%s", bChiralFlagOn? "On":"Off" );
    return szChiralFlag;
}


/*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Case insensitive strstr().
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
static char *e_stristr ( const char * string1, const char * string2 )
{
    const char *str_target = string1;
    const char *cur_string1_ptr, *cur_string2_ptr;
    if ( !*string2 ) {
        return (char *)string1;
    }
    while ( *str_target ) {
        for ( cur_string1_ptr = str_target, cur_string2_ptr = string2;
                  *cur_string1_ptr && *cur_string2_ptr &&
                   toupper(UCINT *cur_string1_ptr) == toupper(UCINT *cur_string2_ptr);
                        cur_string1_ptr++, cur_string2_ptr++ )
            ;
        if ( !*cur_string2_ptr ) {
            return (char *)str_target;
        }
        str_target++;
    }
    return NULL;
}


#endif /* CREATE_INCHI_STEP_BY_STEP */

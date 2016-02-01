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


#include "mode.h"

#ifndef INCHI_ANSI_ONLY
#ifndef INCHI_LIB
#include <windows.h>
#endif
#endif

#include <stdio.h>
#include <stdlib.h>

#ifndef INCHI_ANSI_ONLY
#include <conio.h>
#endif

#include <string.h>
#include <ctype.h>
#include <stdarg.h>
#include <errno.h>
#include <limits.h>
#include <float.h>

#include "ichitime.h"
#include "inpdef.h"
#include "ichi.h"
#include "strutil.h"
#include "util.h"
#include "ichidrp.h"
#include "ichierr.h"
#include "ichimain.h"

#include "ichicomp.h"

#if( ADD_CMLPP == 1 )
#include "readcml.hpp"
#endif

/*^^^ */
#ifdef BUILD_CINCHI_WITH_INCHIKEY
#include "inchi_api.h"
#define FLUSH_OUT do{if (pout->pStr){if (pout->nUsedLength>0)fprintf(output_file,"%-s",pout->pStr); inchi_free(pout->pStr );memset(pout,0, sizeof(*pout));}}while (0)
#define FLUSH_LOG do{if (plog->pStr){if (plog->nUsedLength>0)my_fileprintf(log_file,"%-s",plog->pStr); inchi_free(plog->pStr );memset(plog,0, sizeof(*plog));}}while (0)
void extract_inchi_substring(char ** buf, char *str, size_t slen);
#endif
/*^^^ */

/*  console-specific */
#ifndef INCHI_ANSI_ONLY
/********************************************************************/
int user_quit( const char *msg, unsigned long ulMaxTime )
{
#ifdef INCHI_LIB
    return 0;
#endif
#if( defined(_WIN32) && !defined(INCHI_LIB) )
    int quit, enter, ret;
    printf(msg);
    if ( ulMaxTime ) {
        inchiTime  ulEndTime;
        InchiTimeGet( &ulEndTime );
        InchiTimeAddMsec( &ulEndTime, ulMaxTime );
        while ( !_kbhit() ) {
            if ( bInchiTimeIsOver( &ulEndTime ) ) {
                printf("\n");
                return 0;
            }
            MySleep( 100 );
        }
    }
    while( 1 ) {
        quit  = ( 'q' == (ret = _getch()) || 'Q'==ret || /*Esc*/ 27==ret );
        enter = ( '\r' == ret );
        if ( ret == 0xE0 )
            ret = _getch();
        else {
            _putch(ret); /* echo */
        }
        if ( quit || enter )
            break;
        printf( "\r" );
        printf( msg );
    }

    _putch('\n');
    return quit;
#else
    return 0;
#endif
}
/*****************************************************************/
void eat_keyboard_input( void )
{
#ifndef INCHI_LIB
    while ( _kbhit() ) {
        if ( 0xE0 == _getch() )
            _getch();
    }
#endif
}
#endif /* ifndef INCHI_ANSI_ONLY */

#ifdef INCHI_ANSI_ONLY
/*****************************************************************/
int user_quit( const char *msg, unsigned long ulMaxTime )
{
    return 0;
}
/*****************************************************************/
void eat_keyboard_input( void )
{
}
#endif


/*****************************************************************/
#ifndef INCHI_LIB

int bInterrupted = 0;
#if( defined( _WIN32 ) && defined( _CONSOLE ) )

#ifndef INCHI_ANSI_ONLY
BOOL WINAPI MyHandlerRoutine(
  DWORD dwCtrlType   /*   control signal type */
  ) {
    if ( dwCtrlType == CTRL_C_EVENT     ||
         dwCtrlType == CTRL_BREAK_EVENT ||
         dwCtrlType == CTRL_CLOSE_EVENT ||
         dwCtrlType == CTRL_LOGOFF_EVENT ) {
        bInterrupted = 1;
        return TRUE;
    }
    return FALSE;
}
int WasInterrupted(void) {
#ifdef _DEBUG            
    if ( bInterrupted ) {
        int stop=1;  /*  for debug only <BRKPT> */
    }
#endif
    return bInterrupted;
}
#endif

#endif

#define REPEAT_ALL  0
/*#define TEST_FPTRS*/ /* uncomment for INCHI_LIB testing only */
/********************************************************************/
int main( int argc, char *argv[ ] )
{

    STRUCT_DATA struct_data;
    STRUCT_DATA *sd = &struct_data;
    FILE *inp_file = NULL;

/*^^^ */
#ifdef BUILD_CINCHI_WITH_INCHIKEY
    INCHI_OUTPUT outputstr, logstr;
    INCHI_OUTPUT *pout=&outputstr, *plog = &logstr;
    char ik_string[256];    /*^^^ Resulting InChIKey string */
    int ik_ret=0;           /*^^^ InChIKey-calc result code */

#endif
    FILE *output_file = NULL, *log_file = NULL, *prb_file = NULL;

    char szTitle[MAX_SDF_HEADER+MAX_SDF_VALUE+256];
    /* long rcPict[4] = {0,0,0,0}; */

    int   i;
    long  num_err, num_output;
    long num_inp;
    char      szSdfDataValue[MAX_SDF_VALUE+1];

    PINChI2     *pINChI[INCHI_NUM];
    PINChI_Aux2 *pINChI_Aux[INCHI_NUM];

    unsigned long  ulDisplTime = 0;    /*  infinite, milliseconds */
    unsigned long  ulTotalProcessingTime = 0;
    /*long     fPtrStart=0L, fPtrEnd=0L;*/
    INPUT_PARMS inp_parms;
    INPUT_PARMS *ip = &inp_parms;

    ORIG_ATOM_DATA OrigAtData; /* 0=> disconnected, 1=> original */
    ORIG_ATOM_DATA *orig_inp_data = &OrigAtData;
    ORIG_ATOM_DATA PrepAtData[2]; /* 0=> disconnected, 1=> original */
    ORIG_ATOM_DATA *prep_inp_data = PrepAtData;
    int             bReleaseVersion = bRELEASE_VERSION;
    const int nStrLen = INCHI_SEGM_BUFLEN;
    char *pStr = NULL;
    int   nRet = 0, nRet1;

#ifndef TEST_FPTRS
    STRUCT_FPTRS *pStructPtrs = NULL;
#else
    STRUCT_FPTRS struct_fptrs, *pStructPtrs =&struct_fptrs; /* INCHI_LIB debug only */
#endif

#if ( defined(REPEAT_ALL) && REPEAT_ALL > 0 )
    int  num_repeat = REPEAT_ALL;
#endif


#if( TRACE_MEMORY_LEAKS == 1 )
    _CrtSetDbgFlag(_CRTDBG_CHECK_ALWAYS_DF | _CRTDBG_LEAK_CHECK_DF | _CRTDBG_ALLOC_MEM_DF);
/* for execution outside the VC++ debugger uncomment one of the following two */
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
    /*
    inp_norm_data[0] = &InpNormAtData;
    inp_norm_data[1] = &InpNormTautData;
    inp_norm_data[2] = &InpNormAtDataR;
    inp_norm_data[3] = &InpNormTautDataR;
    */
#if ( defined(REPEAT_ALL) && REPEAT_ALL > 0 )
repeat:
    inp_file = output_file = log_file = prb_file = NULL;
    pStr = NULL;
#endif

    num_inp    = 0;
    num_err    = 0;
    num_output = 0;
    sd->bUserQuit  = 0;

#ifdef BUILD_CINCHI_WITH_INCHIKEY
    memset( pout, 0, sizeof(*pout) );
    memset( plog, 0, sizeof(*plog) );
#endif

#if( defined( _WIN32 ) && defined( _CONSOLE ) && !defined( INCHI_ANSI_ONLY ) )
    if ( SetConsoleCtrlHandler( MyHandlerRoutine, 1 ) ) {
        ConsoleQuit = WasInterrupted;
    }
#endif


    if ( argc == 1 || argc==2 && ( argv[1][0]==INCHI_OPTION_PREFX ) &&
        (!strcmp(argv[1]+1, "?") || !stricmp(argv[1]+1, "help") ) ) {

#ifndef BUILD_CINCHI_WITH_INCHIKEY
        HelpCommandLineParms(stdout);
#else
        HelpCommandLineParms(plog); 
        if (plog->pStr)
        {
            if (plog->nUsedLength>0)
                { fprintf(stdout,"%-s",plog->pStr); inchi_free(plog->pStr ); memset(plog,0, sizeof(*plog)); }
        }      
#endif
        return 0;
    }
    /*  original input structure */
    memset( orig_inp_data     , 0,   sizeof( *orig_inp_data  ) );
    memset( prep_inp_data     , 0, 2*sizeof( *prep_inp_data  ) );
    memset( pINChI,     0, sizeof(pINChI    ) );
    memset( pINChI_Aux, 0, sizeof(pINChI_Aux) );

    /*
    memset( inp_cur_data      , 0, sizeof( *inp_cur_data     ) );
    memset( inp_norm_data[0]  , 0, sizeof( *inp_norm_data[0] ) );
    memset( inp_norm_data[1]  , 0, sizeof( *inp_norm_data[0] ) );
    */
    memset( szSdfDataValue    , 0, sizeof( szSdfDataValue    ) );

    /* explicitly cast to (const char **) to avoid a warning about "incompatible pointer type":*/
    
#ifndef BUILD_CINCHI_WITH_INCHIKEY
    if ( 0 > ReadCommandLineParms( argc, (const char **)argv, ip, szSdfDataValue, &ulDisplTime, bReleaseVersion, stderr ) ) {
#else
    if ( 0 > ReadCommandLineParms( argc, (const char **)argv, ip, szSdfDataValue, &ulDisplTime, bReleaseVersion, plog) ) {
#endif
        goto exit_function;
    }
    if ( !OpenFiles( &inp_file, &output_file, &log_file, &prb_file, ip ) ) {
        goto exit_function;
    }
    if ( ip->bNoStructLabels ) {
        ip->pSdfLabel = NULL;
        ip->pSdfValue = NULL;
    } else
    if ( ip->nInputType == INPUT_INCHI_XML || ip->nInputType == INPUT_INCHI_PLAIN  ||
         ip->nInputType == INPUT_CMLFILE   || ip->nInputType == INPUT_INCHI  ) {
        /* the input may contain both the header and the label of the structure */
        if ( !ip->pSdfLabel ) 
            ip->pSdfLabel  = ip->szSdfDataHeader;
        if ( !ip->pSdfValue )
            ip->pSdfValue  = szSdfDataValue;
    }

#ifndef BUILD_CINCHI_WITH_INCHIKEY
    PrintInputParms( log_file, ip );
#else
    PrintInputParms( plog, ip ); FLUSH_LOG;
#endif

    if ( !(pStr = (char*)inchi_malloc(nStrLen))) {
#ifndef BUILD_CINCHI_WITH_INCHIKEY
        my_fprintf( log_file, "Cannot allocate output buffer. Terminating\n");
#else
        my_fprintf( plog, "Cannot allocate output buffer. Terminating\n"); FLUSH_LOG;
#endif
        goto exit_function;
    }
    pStr[0] = '\0';

#if( READ_INCHI_STRING == 1 )
    if ( ip->nInputType == INPUT_INCHI ) {
        memset( sd, 0, sizeof(*sd) );
#ifndef BUILD_CINCHI_WITH_INCHIKEY
        ReadWriteInChI( inp_file, output_file, log_file, ip,  sd, NULL, NULL, NULL, 0, NULL);
#else
        ReadWriteInChI( inp_file, output_file, log_file, pout, plog, ip,  sd, NULL, NULL, NULL, 0, NULL);
        FLUSH_LOG;
#endif
        ulTotalProcessingTime = sd->ulStructTime;
        num_inp               = sd->fPtrStart;
        num_err               = sd->fPtrEnd;
        goto exit_function;
    }
#endif
    /**********************************************************************************************/
    /*  Main cycle */
    /*  read input structures and create their INChI */
    ulTotalProcessingTime = 0;

    if ( pStructPtrs ) {
        memset ( pStructPtrs, 0, sizeof(pStructPtrs[0]) );
        /* debug: set CML reading sequence
        pStructPtrs->fptr = (INCHI_FPTR *)inchi_calloc(16, sizeof(INCHI_FPTR));
        for ( i = 0; i < 15; i ++ )
            pStructPtrs->fptr[i] = 15-i;
        pStructPtrs->cur_fptr = 7;
        pStructPtrs->len_fptr = 16;
        pStructPtrs->max_fptr = 14;
        */
    }

    while ( !sd->bUserQuit && !bInterrupted ) {
        if ( ip->last_struct_number && num_inp >= ip->last_struct_number ) {
            nRet = _IS_EOF; /*  simulate end of file */
            goto exit_function;
        }

        /*  read one structure from input and display optionally it */

#ifndef BUILD_CINCHI_WITH_INCHIKEY
        nRet = GetOneStructure( sd, ip, szTitle, inp_file, log_file, output_file, prb_file,
                                orig_inp_data, &num_inp, pStr, nStrLen, pStructPtrs );
#else
        nRet = GetOneStructure( sd, ip, szTitle, inp_file, plog, pout, prb_file,
                                orig_inp_data, &num_inp, pStr, nStrLen, pStructPtrs );
        FLUSH_LOG; 
#endif

        if ( pStructPtrs ) {
            pStructPtrs->cur_fptr ++;
        }

        if ( sd->bUserQuit ) {
            break;
        }
        switch ( nRet ) {
        case _IS_FATAL:
            num_err ++;
        case _IS_EOF:
            goto exit_function;
        case _IS_ERROR:
            num_err ++;
        case _IS_SKIP:
            continue;
        }

        /* create INChI for each connected component of the structure and optionally display them */
        /* output INChI for the whole structure */
        
#ifndef BUILD_CINCHI_WITH_INCHIKEY
        nRet1 = ProcessOneStructure( sd, ip, szTitle, pINChI, pINChI_Aux,
                                     inp_file, log_file, output_file, prb_file,
                                     orig_inp_data, prep_inp_data,
                                     num_inp, pStr, nStrLen ); 
#else
        nRet1 = ProcessOneStructure( sd, ip, szTitle, pINChI, pINChI_Aux,
                                     inp_file, plog, pout, prb_file,
                                     orig_inp_data, prep_inp_data,
                                     num_inp, pStr, nStrLen );        

        FLUSH_LOG;

#endif

        /*  free INChI memory */
        FreeAllINChIArrays( pINChI, pINChI_Aux, sd->num_components );
        /* free structure data */
        FreeOrigAtData( orig_inp_data );
        FreeOrigAtData( prep_inp_data );
        FreeOrigAtData( prep_inp_data+1 );

        ulTotalProcessingTime += sd->ulStructTime;
        nRet = inchi_max(nRet, nRet1);
        switch ( nRet ) {
        case _IS_FATAL:
            num_err ++;
            goto exit_function;
        case _IS_ERROR:
            num_err ++;
            continue;
        }

#ifdef BUILD_CINCHI_WITH_INCHIKEY
        if (ip->bCalcInChIKey)
        {
            char *buf = NULL;

            size_t slen = pout->nUsedLength;
            extract_inchi_substring(&buf, pout->pStr, slen);
            if (NULL!=buf)
            {
                ik_ret = GetINCHIKeyFromINCHI(buf, ik_string);                     
                inchi_free(buf);
            }
            else
                ik_ret = INCHIKEY_NOT_INCHI_INPUT;                     
        
            if (ik_ret==INCHIKEY_OK)   
            {
                inchi_print(pout, "InChIKey=%-s\n",ik_string);
            }
            else    
            {
                inchi_print(plog, "Warning (Could not compute InChIKey: ", num_inp);
                switch(ik_ret)
                {
                case INCHIKEY_UNKNOWN_ERROR:
                        inchi_print(plog, "unresolved error)");
                        break;
                case INCHIKEY_EMPTY_INPUT:
                        inchi_print(plog,  "got an empty string)");
                        break;
                case INCHIKEY_NOT_INCHI_INPUT:
                        inchi_print(plog, "got non-InChI string)");
                        break;
                case INCHIKEY_NOT_ENOUGH_MEMORY:
                        inchi_print(plog, "not enough memory to treat the string)");
                        break;
                case INCHIKEY_ERROR_IN_FLAG_CHAR:
                        inchi_print(plog, "detected error in flag character)");
                        break;
                default:inchi_print(plog, "internal program error)");
                        break;
                }
                inchi_print(plog, " structure #%-lu.\n", num_inp);
            }
            FLUSH_OUT;
            FLUSH_LOG;
        }
        else
        {
            FLUSH_OUT;
        }
#endif

   /*   --- debug only ---
        if ( pStructPtrs->cur_fptr > 5 ) {
            pStructPtrs->cur_fptr = 5;
        }
   */


            
    }

exit_function:
    if ( (ip->bINChIOutputOptions & INCHI_OUT_XML) && sd->bXmlStructStarted > 0 ) {

#ifndef BUILD_CINCHI_WITH_INCHIKEY
            if ( !OutputINChIXmlStructEndTag( output_file, pStr, nStrLen, 1 ) ) {
                my_fprintf( log_file, "Cannot create end xml tag for structure #%ld.%s%s%s%s Terminating.\n", num_inp, SDF_LBL_VAL(ip->pSdfLabel,ip->pSdfValue) );
#else
            if ( !OutputINChIXmlStructEndTag( pout,  pStr, nStrLen, 1 ) ) {
                my_fprintf( plog, "Cannot create end xml tag for structure #%ld.%s%s%s%s Terminating.\n", num_inp, SDF_LBL_VAL(ip->pSdfLabel,ip->pSdfValue) );
                FLUSH_LOG;
#endif
            sd->bXmlStructStarted = -1; /*  do not repeat same message */
        }
    }


    if ( (ip->bINChIOutputOptions & INCHI_OUT_XML) && ip->bXmlStarted ) {
#ifndef BUILD_CINCHI_WITH_INCHIKEY
        OutputINChIXmlRootEndTag( output_file );
#else
        OutputINChIXmlRootEndTag( pout ); FLUSH_OUT;
#endif
        ip->bXmlStarted = 0;
    }

    
    /* avoid memory leaks in case of fatal error */
    if ( pStructPtrs && pStructPtrs->fptr ) {
        inchi_free( pStructPtrs->fptr );
    }

    /*  free INChI memory */
    FreeAllINChIArrays( pINChI, pINChI_Aux, sd->num_components );
    /* free structure data */
    FreeOrigAtData( orig_inp_data );
    FreeOrigAtData( prep_inp_data );
    FreeOrigAtData( prep_inp_data+1 );

#if( ADD_CMLPP == 1 )
        /* BILLY 8/6/04 */
        /* free CML memory */
        FreeCml ();
        FreeCmlDoc( 1 );
#endif

    if ( inp_file && inp_file != stdin) {
        fclose ( inp_file );
    }
    if ( prb_file ) {
        fclose ( prb_file );
    }
    if ( output_file && output_file != stdout ) {
        fclose( output_file );
    }
    
    if ( log_file )
    {
        int hours, minutes, seconds, mseconds;
        SplitTime( ulTotalProcessingTime, &hours, &minutes, &seconds, &mseconds );
#ifndef BUILD_CINCHI_WITH_INCHIKEY
        my_fprintf( log_file, "Finished processing %ld structure%s: %ld error%s, processing time %d:%02d:%02d.%02d\n",
                                num_inp, num_inp==1?"":"s",
                                num_err, num_err==1?"":"s",
                                hours, minutes, seconds,mseconds/10); 
#else
        my_fprintf( plog, "Finished processing %ld structure%s: %ld error%s, processing time %d:%02d:%02d.%02d\n",
                                num_inp, num_inp==1?"":"s",
                                num_err, num_err==1?"":"s",
                                hours, minutes, seconds,mseconds/10);
        FLUSH_LOG;
#endif
    }
    if ( log_file && log_file != stderr ) {
        fclose( log_file );
    }
    if ( pStr ) {
        inchi_free( pStr );
    }
    for ( i = 0; i < MAX_NUM_PATHS; i ++ ) {
        if ( ip->path[i] ) {
            inchi_free( (void*) ip->path[i] ); /*  cast deliberately discards 'const' qualifier */
            ip->path[i] = NULL;
        }
    }
    SetBitFree( );

#if ( defined(REPEAT_ALL) && REPEAT_ALL > 0 )
    if ( num_repeat-- > 0 ) {
        goto repeat;
    }
#endif

#if( bRELEASE_VERSION != 1 && defined(_DEBUG) )
    if ( inp_file && inp_file != stdin ) {
        user_quit("Press Enter to exit ?", ulDisplTime);
    }
#endif

#ifdef BUILD_CINCHI_WITH_INCHIKEY
    if ( pout->pStr )    
        inchi_free( pout->pStr ); 
    if ( plog->pStr )    
        inchi_free( plog->pStr ); 
#endif
    
    return 0;
}



void extract_inchi_substring(char ** buf, char *str, size_t slen)
{
size_t n;
char *p, *pp;
   
    *buf = NULL;

    p = strstr(str, "InChI=");
    if (NULL==p)
        return;
    
    pp = strchr( p, '\n' );
    if (NULL==pp)
    {
        pp = strchr( p, '\0' );
    }
    if (NULL==pp)
        return;

    n = (pp-p)/sizeof(char);

    
    *buf = inchi_calloc(n+1, sizeof(char));
    memcpy(*buf, p, n);
    (*buf)[n] = '\0';

    return;
}

#endif  /* ifndef INCHI_LIB */



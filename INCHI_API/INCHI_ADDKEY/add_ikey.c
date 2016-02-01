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

    Demo program for InChIKey API
    
    Copies the file to output file adding InChIKey string as a separate line after 
    each found line containing a single InChI string (LF-terminated)
    All input strings themselves are copied untouched (optionally, not copied).

    Example:

    INCHI_ADDKEY.exe -n InChIes.txt InChIKeyed.txt InChIKeyed.log

    NB: the string is assumed to be InChI string if it meets the following requirements:
        - starts with "InChI=1/"
        - then contains at least one a..Z0..9 or '/'
    Everything between "InChI=1/" and the end of line is considered an InChI string.

    !This program is only for demo purpose!
    

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/

#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "inchi_api.h"


#ifndef _MAX_PATH 
#define _MAX_PATH 260
#endif


#define INCHI_STRING_PREFIX "InChI="
#define LEN_INCHI_STRING_PREFIX 6




enum { PRINT_COUNT = 5000L };   



void print_help(void);
char *rbgetline(FILE * f, char ** buf, size_t * maxbuf, int * ierr);






/*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
int main(int argc, char *argv[])
{
int k, ik_ret;
int pcount=0;
long int nlines = 0L, nadded = 0L, nfailed = 0L;
int nocopy =  0;
char ik_string[255];    /*^^^ Resulting InChIkey string */
int ierr=0;
int verbose=1;
char* str;
char *buf    = NULL; 
size_t  maxbuf;

char        *inname = NULL;
char        outname[_MAX_PATH]; 
char        logname[_MAX_PATH]; 
FILE*       f=NULL;     
FILE*       fw=NULL;    
FILE*       fl=NULL;    

time_t elapsed;




    if (argc<2) 
    {
        print_help();
        exit(0);
    }

    for(k=1;k<argc;k++)
    {
        if(argv[k][0] != '-') break;
        k++;
        switch(argv[k-1][1])
        {
            case 'n':
                nocopy = 1;
                k--;
                break;

            default:
                printf("Error: unknown key '%c'\n", argv[k-1][1]);
                k--;
                print_help();
                exit(0);
                break;
        }

    }


    inname = argv[k];
    if (inname)
        f = fopen(inname,"rb");
    if (NULL==f)
    {
            printf("* Error: could not open input file!\n");
            exit (2);
    }

    if (argc>=k+2) 
        strcpy(outname, argv[k+1]);
    else
    {
        printf("* Warning: got no output file name, using 'InChIKeys.txt'.\n");
        strcpy(outname, "InChIKeys.txt");
    }

    if (NULL!=outname)
        fw = fopen(outname,"wt");
    if (NULL==fw)
    {
        printf("* Error: could not open output file!\n");
        exit (3);
    }
    
    logname[0] = '\0';
    if (argc>=k+3) 
        strcpy(logname, argv[k+2]);
    if (logname[0])
    {
        fl = fopen(logname,"wt");
        if (NULL==fl)
        {
            printf("* Error: could not open log file!\n");
            exit (4);
        }
    }
    else
        fl = stderr;
    
        



        
    if (verbose>0)
        fprintf(fl, "Processing '%-s'...\n", inname);

    elapsed = time(NULL); 
    pcount = 0;
    
    while ( NULL != (str = rbgetline(f, &buf, &maxbuf, &ierr)) )     
    {
        nlines++;   
        
        
        if (!nocopy)
            fprintf(fw, "%-s\n",str);


        if (str[0]=='I') if (str[1]=='n') if (str[2]=='C') 
        {
            /* Possibly, InChI; additional (minor) checks will be
               done by key calc function (see description in ikey_dll.c ) */


            ik_ret = GetINCHIKeyFromINCHI(str, ik_string);                     
        

            if (ik_ret==INCHIKEY_OK)    
            {
                fprintf(fw, "InChIKey=%-s\n",ik_string);
                nadded++;
            }
            else    
            {
                nfailed++;
                if ( (ik_ret!=INCHIKEY_EMPTY_INPUT) && (ik_ret!=INCHIKEY_NOT_INCHI_INPUT) ) /*^^^ quietly ignore these two */
                {
                        fprintf(fl, "Warning: could not compute InChIKey for the line #%-d ", nlines);
                        switch(ik_ret)
                        {
                        case INCHIKEY_NOT_ENOUGH_MEMORY:
                                fprintf(fl, "(not enough memory to treat the string)\n");
                                break;
                        case INCHIKEY_ERROR_IN_FLAG_CHAR:
                                fprintf(fl, "(detected error in flag character)\n");
                                break;
                        case INCHIKEY_UNKNOWN_ERROR:
                        default:fprintf(fl, "(unresolved program error)\n");
                                break;
                    }
                }
            }

        
        } /* if (str[0]=='I' ... */

        pcount++;
        if (verbose>0)
            if (pcount==PRINT_COUNT)
                { printf("%-ld        \r", nlines); pcount = 0; }

    
    } /* while */





    if (ierr)
        printf("\n* Error: could not process line %-ld (too long).", nlines + 1); 
    if (verbose>0)
    {
        printf("\nCompleted processing of %-ld lines.", nlines); 
        printf("\nInChIKey: added %-ld, failed %-ld.\n", nadded, nfailed);
        elapsed-= time(NULL); 
        printf("\nElapsed time: %ld\n", -elapsed);
    }

    if (f)  fclose(f);
    if (fw) fclose(fw);
    if (fl) fclose(fl);
    if (buf) free(buf);

    return 0;

}









/*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
void print_help(void)
{
    printf("Demo program illustrating usage of InChIKey API.\n");
    printf("Copies the file to output file adding InChIKey string as a separate line after\n");
    printf("each found line containing a single InChI string (LF-terminated)\n");
    printf("\nUsage: add_ikey [switches] input file name [output file name [log file name] ]");
    printf("\n       switches:");
    printf("\n       -n      do not copy source to output, just print keys.");
    printf("\n\n");
    printf("!This program is only for demo purposes!\nIt only weakly checks if the input is valid InChI string.\n");
}



/*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
rbgetline - reads line using resizing buffer
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
char *rbgetline(FILE * f, char ** buf, size_t * maxbuf, int * ierr)
{   
size_t i; 
int c, eol;
char *newl;

    *ierr = 0;

    if (NULL==*buf) 
    {
        *maxbuf  = 4096;
        *buf = (char *) malloc(*maxbuf);
        if (NULL==*buf) 
        {
            *ierr = 1;
            return NULL;
        }
    }

    for (i=0; (c=getc(f))!=EOF ; i++) 
    {
        
        eol = (c=='\r' || c=='\n');
        if (c == '\r') 
        {
            c = getc(f);
            if (c != '\n' && c != EOF)
            ungetc(c, f);
        }
        if (eol)
            break;

        if (i >=  *maxbuf-1) 
        {
            if (*maxbuf > ( ((size_t)-1)/2) )
            {
                *ierr = 1;
                return NULL;
            }

            *maxbuf *= 2;       
            newl = (char *) realloc(*buf, *maxbuf);
            if (NULL == newl )
            {
                *ierr = 1;
                return NULL;
            }
            *buf = newl;
        }
        (*buf)[i] = c;
    }
    (*buf)[i] = '\0';

    return (c == EOF && i == 0) ? NULL : *buf;
}


/*
 * International Chemical Identifier (InChI)
 * Version 1
 * Software version 1.02
 * January 10, 2009
 * Developed at NIST
 *
 * The InChI library and programs are free software developed under the
 * auspices of the International Union of Pure and Applied Chemistry (IUPAC);
 * you can redistribute this software and/or modify it under the terms of 
 * the GNU Lesser General Public License as published by the Free Software 
 * Foundation:
 * http://www.opensource.org/licenses/lgpl-license.php
 */

*****
This is the release of the IUPAC standard International Chemical
Identifier with InChIKey, version 1, software version 1.02.
(http://www.iupac.org/projects/2000/2000-025-1-800.html
http://www.iupac.org/inchi).

The release conforms to standard InChI and standard InChIKey definitions
(see UserGuide) as established by IUPAC InChI Subcommittee on the meeting of 
September 15, 2008.
*****


STDINCHI_API folder 
contains code, VC++ 6.0 projects and gcc makefiles of
InChI generation library with API Win32 dll (libstdinchi) and testing 
executable stdinchi_main.exe that calls libstdinchi.dll.

The library produces only standard InChI/standard InChIKey. 
All the other InChI API entry points described in inchi_api.h
are currently disabled.
				
Besides the InChI software library software itself (located in INCHI_DLL 
folder) which contains InChI generating code (libstdinchi.so or libstdinchi.dll 
library source code), this package contains examples of using previously 
available and newly added InChI software library functionality.


INCHI_MAIN sub-directory 
contains ANSI-C testing application source
to call standard InChI library libstdinchi.dll under Microsoft Windows or 
libstdinchi.so under Linux or Unix. 

Defining CREATE_INCHI_STEP_BY_STEP in e_mode.h makes program use the new (1.02)
modularized interface to InChI generation process. Modularized interface is used
by default; commenting out the line containing the #define makes the program use software 
version 1.01 ("classic") interface to InChI generation process. However, both 
options provide examples of using the new, software version 1.02, interface to 
the standard InChIKey part of the library.

If the testing application is compiled with CREATE_INCHI_STEP_BY_STEP option, 
an additional defining of OUTPUT_NORMALIZATION_DATA in e_mode.h makes the 
program output the intermediate (normalization) data into the log file. 
The related data structures are described in header files inchi_api.h; 
their use is exemplified in e_ichimain_a.c file. 
Note that including the output of the intermediate (normalization) data may 
produce a very long log file.

Please notice that /D "INCHI_LINK_AS_DLL" Visual C ++ compiler option is 
necessary to create and link the dll and the testing executable with 
Microsoft Visual C++ 6.0 or .NET under Win32.


vc6_INCHI_DLL folder 
contains a MS Visual C++ 6.0 project to build dynamically 
linked library libstdinchi.dll under Windows. 


vc6_INCHI_MAIN folder
contains a MS Visual C++ 6.0 project to build both dynamically 
linked library libstdinchi.dll and the testing application stdinchi_main.exe 
under MS Windows (both library and executable are placed into subfolders 
Release or Debug of vc6_INCHI_DLL folder).


gcc_so_makefile folder 
contains a gcc makefile for INCHI_MAIN + INCHI_DLL code 
to create a standard InChI library as a shared object (Linux)  or dll (Windows) 
dynamically linked to the main program. 


RunInChI_Py folder 
contains Python testing application calling standard InChI 
library functions.


Executable locations:


-- InChI dll + C testing application (Win32)

vc6_INCHI_DLL/Release/stdinchi_main.exe -- testing application
                                        (standard InChI/InChIKey generation)
vc6_INCHI_DLL/Release/libstdinchi.dll   -- standard INCHI dll with API



-- libstdinchi.so.1.02.00 and stdinchi_main (i386 Linux)
gcc_so_makefile/result/libstdinchi.so.1.02.00.gz - shared object
gcc_so_makefile/result/stdinchi_main.gz          - testing application

The InChI library does not provide any support for graphic
user interface (GUI). It is not designed to work in
a multithreaded environment and should be called from
only one thread at a time.

Under other than Windows operation systems or other than Microsoft
compilers the options should be preceded by "-" instead of "/".

All source code and makefiles have MS-DOS type line separators,
CarriageReturn/Linefeed, or 0x0D 0x0A.



InChI discussion group
=======================
https://lists.sourceforge.net/lists/listinfo/inchi-discuss

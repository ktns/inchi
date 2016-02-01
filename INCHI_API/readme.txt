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


InChI software - Library with API and test applications
v. 1.02-beta

INCHI_API     contains code, VC++ 6.0 projects and gcc makefiles of
=========     InChI generation library with API Win32 dll
              (inchilib.dll) and testing executable INCHI_MAIN.exe
              that calls inchilib.dll.
              InChI API consists of all entry points described
              in inchi_api.h.
				
              Besides the InChI software library software itself 
              (located in INCHI_API/INCHI_DLL folder) which contains InChI 
              generating code (libinchi.so or libinchi.dll library source 
              code), this package contains examples of using previously 
              available and newly added InChI software library functionality.

INCHI_API/INCHI_MAIN    contains ANSI-C testing application source
                        to call InChI library libinchi.dll under Microsoft 
              Windows or libinchi.so under Linux or Unix. 

              Defining CREATE_INCHI_STEP_BY_STEP in e_mode.h makes program 
              use the new (1.02) interface to InChI generation process. 
              This is the default option. Commenting out the line containing 
              this #define makes the program use software version 1.01 
              interface to InChI generation process. However, both options 
              provide examples of using the new, software version 1.02, 
              interface to the InChIKey part of the library.

              If the testing application is compiled with 
              CREATE_INCHI_STEP_BY_STEP option, an additional defining 
              of OUTPUT_NORMALIZATION_DATA in e_mode.h makes the program 
              output the intermediate (normalization) data into the log file. 
              The related data structures are described in header files 
              inchi_api.h; their use is exemplified in e_ichimain_a.c file. 
              Note that including the output of the intermediate 
              (normalization) data may produce a very long log file.

              Please notice that /D "INCHI_LINK_AS_DLL" Visual C ++
              compiler option is necessary to create and link the dll
              and the testing executable with Microsoft Visual C++ 6.0
              or .NET under Win32.

INCHI_API/vc6_INCHI_DLL folder contains a MS Visual C++ 6.0 project to build 
                        dynamically linked library libinchi.dll under Windows. 


INCHI_API/vc6_INCHI_MAIN contains a MS Visual C++ 6.0 project to build 
                         both dynamically linked library libinchi.dll and the 
              testing application InChI_MAIN.exe under Windows (both library 
              and executable are placed into subfolders Release or Debug 
              of vc6_INCHI_DLL folder).


INCHI_API/gcc_so_makefile contains a gcc makefile for INCHI_MAIN + INCHI_DLL 
                          code to create a InChI library as a shared object 
              (Linux)  or dll (Windows) dynamically linked to the main program. 


INCHI_API/gcc_makefile  contains a gcc makefile for INCHI_MAIN + INCHI_DLL 
                        code to create a single statically linked executable 
              under Win32 or Linux, or other operating systems.


INCHI_API/INCHI_ADDKEY  contains ANSI C application source code that calls 
                        InChIKey part of the library libinchi (to execute 
              INCHI_ADDKEY.exe the libinchi.dll is needed.)

              The program copies the input file to the output file inserting 
              InChIKey string as a separate line after each line containing 
              a single InChI string. All input strings are copied to the output 
              file unchanged  (or, optionally, not copied).

              Note: a line is assumed to contain an InChI string 
              if it meets the following requirements:
              	the line starts with "InChI=1/" string;
              	this string is followed by at least one of 
                a..zA..Z0..9 or '/' characters.
              Everything between "InChI=1/" and the end of line is considered 
              an InChI string. Note: this program is provided only for 
              demo purpose.


INCHI_API/ vc6_INCHI_ADDKEY contains a MS Visual C++ 6.0 project to 
                            build INCHI_ADDKEY.exe executable (Windows). 

INCHI_API/gcc_makefile_inchi_addkey contains a gcc makefile for inchi_addkey 
                                    (Linux) or inchi_addkey.exe (Windows) 
                                    executable. 


INCHI_API/RunInChI_Py contains a a sample program illustrating how the InChI 
                      library (DLL) functions may be called from within Python.
              It has a simple Mol/SDfile reader and produces InChI strings and,
              optionally, generate InChIKey codes.


Executable locations:


-- InChI dll + C testing application (Win32)

INCHI_API/vc6_INCHI_DLL/Release/INCHI_MAIN.exe -- testing application
                                                  (InChI generation)
INCHI_API/vc6_INCHI_DLL/Release/INCHI_ADDKEY.exe -- testing application
                                                        (add InChIKey to 
                                                        existing InChI strings)
INCHI_API/vc6_INCHI_DLL/Release/inchilib.dll   -- INCHI dll with API



-- InChI dll + C testing applications (i386 Linux) --

INCHI_API/gcc_makefile/cInChI-1.gz -- gzipped statically linked to the InChI 
                                      library testing application 
                                      (InChI generation)
INCHI_API/gcc_makefile_inchi_addkey/inchi_addkey.gz  -- gzipped statically 
                                                        linked to the InChI 
                                                        library test application 
                                                        (add InChIKey to 
                                                        existing InChI strings)

-- libinchi.so.1.02.00 and main_inchi (i386 Linux)
INCHI_API/gcc_so_makefile/result/libinchi.so.1.02.00.gz - shared object
INCHI_API/gcc_so_makefile/result/main_inchi.gz          - testing
                                                          application

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

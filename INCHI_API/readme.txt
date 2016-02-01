/*
 * International Union of Pure and Applied Chemistry (IUPAC)
 * International Chemical Identifier (InChI)
 * Version 1
 * Software version 1.01
 * July 21, 2006
 * Developed at NIST
 */


InChI Library with API and test applications

INCHI_API     contains code, VC++ 6.0 projects and gcc makefile of
=========     InChI generation library with API Win32 dll
              (inchilib.dll) and testing executable INCHI_MAIN.exe
              that calls inchilib.dll.
              InChI API consists of all entry points described
              in inchi_api.h
              The Win32 __cdecl entry point prototypes are described
              in comments because they formally have same names in the
              source code as __stdcall entry points.

INCHI_API/INCHI_DLL     contains InChI generating code (libinchi.so
                        or libinchi.dll library source code)

INCHI_API/INCHI_MAIN    contains ANSI-C testing application source
                        code to call InChI library libinchi.
              It can read Mol/SDfiles and InChI output.
              It produces either 0D or 2D/3D stereochemical input
              for the InChI generating code library depending on
              whether CREATE_0D_PARITIES is defined in e_ichimain.c.
                Defining MAKE_INCHI_FROM_AUXINFO in e_ichimain.c makes it
              feed InChI library with Aux_Info produced by InChI library,
              convert it into InChI library input format, produce new
              InChI, and compare it to the InChI created from the
              original structure.
                Please notice that /D "INCHI_LINK_AS_DLL" Visual C ++
              compiler option is necessary to create and link the dll
              and the testing executable with Microsoft Visual C++ 6.0
              or .NET under Win32.
              In case of /Inchi2inchi or /Inchi2struct command line
              option the following conversions would be performed:
              /Inchi2inchi:
              Structure->InChI->InChI using other options
              /Inchi2struct:
              Structure->InChI->Structure->InChI
                
INCHI_API/gcc_so_makefile contains a gcc makefile for
                          INCHI_MAIN + INCHI_DLL code to create
              InChI library as a shared object or dll dynamically
              linked to the main program
              The makefile is designed to be run by make from this
              directory. The i386 Linux executables produced by
              this makefile, libinchi.so.1.00.00.gz and main_inchi.gz,
              are located in the directory INCHI_API/gcc_so_makefile/result
              This directory must exist at the time the makefile is run.
              Under Linux use command line "make ISLINUX=1" instead of
              just "make".

INCHI_API/gcc_makefile  contains a gcc makefile for
                        INCHI_MAIN + INCHI_DLL code to create
              a single  statically linked executable under Win32,
              Linux, or other operating systems.
              It is designed to be run by make from this directory.
              The purpose of this is so/dll troubleshooting only.

Executable locations:

-- InChI dll + C testing application (Win32)
INCHI_API/vc6_INCHI_DLL/Release/INCHI_MAIN.exe -- testing application
INCHI_API/vc6_INCHI_DLL/Release/inchilib.dll   -- INCHI dll with API

-- libinchi.so.1.01.00 and main_inchi (i386 Linux)
INCHI_API/gcc_so_makefile/result/libinchi.so.1.01.00.gz - shared object
INCHI_API/gcc_so_makefile/result/main_inchi.gz          - testing
                                                          application

The InChI API description is located in inchi_api.h header file.
The InChI library does not provide any support for graphic
user interface (GUI). It is not designed to work in
a multithreaded environment and should be called from
only one thread at a time.

Under other than Windows operation systems or other than Microsoft
compilers the options should be preceded by "-" instead of "/".

All source code and makefiles have MS-DOS type line separators,
CarriageReturn/Linefeed, or 0x0D 0x0A.

=======================================
New Features in software version 1.01
=======================================

- InChI -> 0D Structure converter (better than 99.9% rate of exact conversion)
- InChI -> InChI        converter for verification purposes and layer removal

Notes
=====
Ordinal numbers of __stdcall entry points exported from Win32
inchilib.dll with __declspec(dllexport) have changed.
Ordinal numbers of __cdecl entry points
(see file InChI-1-API\INCHI_API\vc6_INCHI_DLL\vc6_libinchi.def )
remain unchanged. New entry points have been added. See inchi_api.h
for details.

The current e_ichimain.c does not support InChI->Structure convertion
simply becaure it does not have a method to read InChI strings from a file.

However, InChI Library has a new method to convert InChI string into a
chemical structure with 0D stereo parities.
See newly added function GetStructFromINCHI(...).
To deallocate the structure and accompanying it text info
use FreeStructFromINCHI(...)

Code in e_ichimain.c upon uncommenting line

/* #define INCHI_TO_STRUCTURE */

provides a possibility to follow
Structure->InChI->Structure->InChI conversion.

GetStructFromINCHI(...) provides four bitmaps
that show differences between the input InChI and
InChI calculated from the reconstructed structure, if any.

In case of metal-organic compounds only the /r layer, if available,
is used to reconstruct the structure. Therefore, the success rate
for metal-organic compounds should be expected lower than 99.9% because
details about bonds to metal atoms and formal charges on the metal and
surrounding atoms cannot be recovered.


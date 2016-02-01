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


This makefile was tested with
gcc version 3.4.2 (mingw-special)
under WinXP Pro SP2
and gcc version 4.1.2 20070502 (Red Hat 4.1.2-12)
under Fedora Core 7

Linux note:
=============
How to run make under Linux:

make ISLINUX=1

This would resrict a list of exported entry points to those described
in inchi_api.h (see file inchi.map), add CWD to the main_inchi shared
object search path, and, most importantly, eliminate refusal to load
the shared library which otherewise would produce this message:

"error while loading shared libraries: libinchi.so.1:
 cannot restore segment prot after reloc: Permission denied"

under SELinux default settings.

Note: it may be necessary to copy symlink  libinchi.so.1 to /usr/lib.

General
=========
This makefile creates InChI library and a dynamically linked
to it test application, main_inchi. The binaries consist of:

1) The main program -- a Molfile/InChI Aux Info reader
that creates a chemical structure representation suitable for
the InChI library API, feeds it into the InChI library and
outputs the results.
The code is located in the INCHI_MAIN directory.

2) The InChI library that creates the InChI identifier,
Auxiliary information, and error/warning messages.
The code is located in the INCHI_DLL directory

The makefile should be placed into a directory
that has a common parent with INCHI_MAIN and
INCHI_DLL as it is in the zip file containing
the source code and this makefile.

The two *.def files in case of Win32 should be placed in the makefile 
directory as it is in the zip file containing
the source code and this makefile.

The "result" subdirectory of the makefile containing directory
must be created before running this makefile.


Under Win32 the makefile creates:
=================================
o main_inchi.exe            - the main program and
o libinchi.dll + libinchi.a - InChI library dynamically linked to it.

in the "result" subdirectory of this makefile directory out of source
code located in "INCHI_DLL" and "INCHI_MAIN" directories.

If you are using MinGW gcc then uncommenting makefile line
#   ADD_PASCAL_INCHI_CALLS = 1
will add to the libnchi.dll pascal/stdcall entry points needed to call
it from MS Visual Basic 6.0 and InChI_MAIN.exe example compiled/linked under
MS VC++ 6.0.

Under Linux the makefile creates:
=================================
 main_inchi           -- the main program (InChI software library testing
                         application) and
 libinchi.so.1.02.00  -- the shared object and a link libinchi.so.1 to it
 libinchi.so.1        -- a symbolic link to libinchi.so.1.01.00

in the "result" subdirectory of this makefile directory out of source
code located in "INCHI_DLL" and "INCHI_MAIN" directories.

Files result/libinchi.so.1.02.00.gz and result/main_inchi.gz
contain Linux 1386 binaries created with the included makefile.

The InChI software library testing application, main_inchi, needs
libinchi.so.1, a symbolic link to libinchi.so.1.02.00.

Under Fedora Core 5 the shared object libinchi.so.1.02.00 created
without ISLINUX=1 may not load unless you do the following if you
have not already done so:

Go to "System" > "Administration" > "Security Level and Firewall".
Enter your root password and click "ok".
On the "SELinux" tab click on "Modify SELinux Policy", click on "Compatibility"
to open it and tick the check box next to
"Allow the use of shared libraries with Text Relocation". Click "ok"

To use function times() instead of clock()
for detecting timeout remove -ansi compiler
option and add option -DINCHI_USETIMES

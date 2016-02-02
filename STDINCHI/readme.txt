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

This directory contains stdinchi-1 source code and executables
(command-line executables produce standard InChI/InChIKey as introduced 
in this software release, v. 1.02; see UserGuide about the standard 
InChI and standard InChIKey).

common        - part of the source code common with InChI library
main          - the rest of the source code
gcc_makefile  - gcc makefile to create stdinchi-1 executable and a i386
                Linux executable (stdinchi-1.gz)
vc6_project   - Microsoft Visual C++ 6.0 project to create stdinchi-1.exe

The stdinchi-1.exe (Win32 executable) without CML input support is located
                 in vc6_project/Release directory

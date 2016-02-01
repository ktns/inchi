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

It creates a statically linked to the InChI
library test application that copies the input file 
to output file adding InChIKey string as a separate line after 
each found line containing a single InChI string (LF-terminated)
All input strings themselves are copied untouched (optionally, not copied).

Example:

INCHI_ADDKEY.exe -n InChIes.txt InChIKeyed.txt InChIKeyed.log

NB: the string is assumed to be InChI string if it meets the following requirements:
	- starts with "InChI=1/"
        - then contains at least one a..Z0..9 or '/'
Everything between "InChI=1/" and the end of line is considered an InChI string.

This program is provided only for demo purposes.


The makefile should be placed into a directory
that has a common parent with INCHI_ADDKEY and
INCHI_DLL.

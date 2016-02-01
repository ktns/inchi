/*
 * International Union of Pure and Applied Chemistry (IUPAC)
 * International Chemical Identifier (InChI)
 * Version 1
 * Software version 1.01
 * July 21, 2006
 * Developed at NIST
 */

This makefile was tested with
gcc version 3.4.2 (mingw-special)
under Win2k SP4
and gcc version 4.1.0 20060304 (Red Hat 4.1.0-3)
under Fedora Core 5

Under Win32 it creates cInChI-1.exe console application
out of source code located in "main" and "common"
directories. Under Linux it creates cInChI-1 binary (in cInChI-1.gz).

The makefile should be placed into a directory
that has a common parent with "main" and "common"
directories as it is in the zip file containing
the source code and this makefile.

To use function times() instead of clock()
for detecting timeout remove -ansi compiler
option and add option -DINCHI_USETIMES

File cInChI-1 was created with
gcc version 4.1.0 20060304 (Red Hat 4.1.0-3) under Fedora Core 5
with glibc-2.4-4 and glibc-kernheaders-3.0-5.2

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

It creates a statically linked to the InChI
library test application consisting of:

1) A Molfile/InChI Aux Info reader that creates
a chemical structure representation suitable for
the InChI library API, feeds it into the InChI
library and outputs the results.
The code is located in the INCHI_MAIN directory.

2) The InChI library that creates the InChI identifier,
Auxiliary information, and an error/warning message.
The code is located in the INCHI_DLL directory

The makefile should be placed into a directory
that has a common parent with INCHI_MAIN and
INCHI_DLL as it is in the zip file containing
the source code and this makefile.

To use function times() instead of clock()
for detecting timeout remove -ansi compiler
option and add option -DINCHI_USETIMES

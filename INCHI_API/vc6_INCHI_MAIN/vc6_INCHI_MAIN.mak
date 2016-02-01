# Microsoft Developer Studio Generated NMAKE File, Based on vc6_INCHI_MAIN.dsp
!IF "$(CFG)" == ""
CFG=vc6_INCHI_MAIN - Win32 Debug
!MESSAGE No configuration specified. Defaulting to vc6_INCHI_MAIN - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "vc6_INCHI_MAIN - Win32 Release" && "$(CFG)" != "vc6_INCHI_MAIN - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "vc6_INCHI_MAIN.mak" CFG="vc6_INCHI_MAIN - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "vc6_INCHI_MAIN - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "vc6_INCHI_MAIN - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release

!IF "$(RECURSE)" == "0" 

ALL : "..\vc6_INCHI_DLL\Release\InChI_MAIN.exe"

!ELSE 

ALL : "vc6_INCHI_DLL - Win32 Release" "..\vc6_INCHI_DLL\Release\InChI_MAIN.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"vc6_INCHI_DLL - Win32 ReleaseCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\e_0dstereo.obj"
	-@erase "$(INTDIR)\e_ichi_io.obj"
	-@erase "$(INTDIR)\e_ichi_parms.obj"
	-@erase "$(INTDIR)\e_ichimain.obj"
	-@erase "$(INTDIR)\e_inchi_atom.obj"
	-@erase "$(INTDIR)\e_mol2atom.obj"
	-@erase "$(INTDIR)\e_readinch.obj"
	-@erase "$(INTDIR)\e_readmol.obj"
	-@erase "$(INTDIR)\e_readstru.obj"
	-@erase "$(INTDIR)\e_util.obj"
	-@erase "$(INTDIR)\INCHI_MAIN.res"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(OUTDIR)\InChI_MAIN.map"
	-@erase "..\vc6_INCHI_DLL\Release\InChI_MAIN.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "INCHI_LINK_AS_DLL" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

.c{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

RSC=rc.exe
RSC_PROJ=/l 0x409 /fo"$(INTDIR)\INCHI_MAIN.res" /d "NDEBUG" 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\INCHI_MAIN.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no /pdb:"$(OUTDIR)\InChI_MAIN.pdb" /map:"$(INTDIR)\InChI_MAIN.map" /machine:I386 /out:"../vc6_INCHI_DLL/Release/InChI_MAIN.exe" 
LINK32_OBJS= \
	"$(INTDIR)\e_0dstereo.obj" \
	"$(INTDIR)\e_ichi_io.obj" \
	"$(INTDIR)\e_ichi_parms.obj" \
	"$(INTDIR)\e_ichimain.obj" \
	"$(INTDIR)\e_inchi_atom.obj" \
	"$(INTDIR)\e_mol2atom.obj" \
	"$(INTDIR)\e_readinch.obj" \
	"$(INTDIR)\e_readmol.obj" \
	"$(INTDIR)\e_readstru.obj" \
	"$(INTDIR)\e_util.obj" \
	"$(INTDIR)\INCHI_MAIN.res" \
	"..\vc6_INCHI_DLL\Release\libinchi.lib"

"..\vc6_INCHI_DLL\Release\InChI_MAIN.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "..\vc6_INCHI_DLL\Debug\InChI_MAIN.exe" "$(OUTDIR)\INCHI_MAIN.bsc"

!ELSE 

ALL : "vc6_INCHI_DLL - Win32 Debug" "..\vc6_INCHI_DLL\Debug\InChI_MAIN.exe" "$(OUTDIR)\INCHI_MAIN.bsc"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"vc6_INCHI_DLL - Win32 DebugCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\e_0dstereo.obj"
	-@erase "$(INTDIR)\e_0dstereo.sbr"
	-@erase "$(INTDIR)\e_ichi_io.obj"
	-@erase "$(INTDIR)\e_ichi_io.sbr"
	-@erase "$(INTDIR)\e_ichi_parms.obj"
	-@erase "$(INTDIR)\e_ichi_parms.sbr"
	-@erase "$(INTDIR)\e_ichimain.obj"
	-@erase "$(INTDIR)\e_ichimain.sbr"
	-@erase "$(INTDIR)\e_inchi_atom.obj"
	-@erase "$(INTDIR)\e_inchi_atom.sbr"
	-@erase "$(INTDIR)\e_mol2atom.obj"
	-@erase "$(INTDIR)\e_mol2atom.sbr"
	-@erase "$(INTDIR)\e_readinch.obj"
	-@erase "$(INTDIR)\e_readinch.sbr"
	-@erase "$(INTDIR)\e_readmol.obj"
	-@erase "$(INTDIR)\e_readmol.sbr"
	-@erase "$(INTDIR)\e_readstru.obj"
	-@erase "$(INTDIR)\e_readstru.sbr"
	-@erase "$(INTDIR)\e_util.obj"
	-@erase "$(INTDIR)\e_util.sbr"
	-@erase "$(INTDIR)\INCHI_MAIN.res"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(OUTDIR)\INCHI_MAIN.bsc"
	-@erase "$(OUTDIR)\InChI_MAIN.map"
	-@erase "$(OUTDIR)\InChI_MAIN.pdb"
	-@erase "..\vc6_INCHI_DLL\Debug\InChI_MAIN.exe"
	-@erase "..\vc6_INCHI_DLL\Debug\InChI_MAIN.ilk"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /MLd /W3 /Gm /GX /ZI /Od /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "INCHI_LINK_AS_DLL" /Fr"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

.c{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

RSC=rc.exe
RSC_PROJ=/l 0x409 /fo"$(INTDIR)\INCHI_MAIN.res" /d "_DEBUG" 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\INCHI_MAIN.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\e_0dstereo.sbr" \
	"$(INTDIR)\e_ichi_io.sbr" \
	"$(INTDIR)\e_ichi_parms.sbr" \
	"$(INTDIR)\e_ichimain.sbr" \
	"$(INTDIR)\e_inchi_atom.sbr" \
	"$(INTDIR)\e_mol2atom.sbr" \
	"$(INTDIR)\e_readinch.sbr" \
	"$(INTDIR)\e_readmol.sbr" \
	"$(INTDIR)\e_readstru.sbr" \
	"$(INTDIR)\e_util.sbr"

"$(OUTDIR)\INCHI_MAIN.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:yes /pdb:"$(OUTDIR)\InChI_MAIN.pdb" /map:"$(INTDIR)\InChI_MAIN.map" /debug /machine:I386 /out:"../vc6_INCHI_DLL/Debug/InChI_MAIN.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\e_0dstereo.obj" \
	"$(INTDIR)\e_ichi_io.obj" \
	"$(INTDIR)\e_ichi_parms.obj" \
	"$(INTDIR)\e_ichimain.obj" \
	"$(INTDIR)\e_inchi_atom.obj" \
	"$(INTDIR)\e_mol2atom.obj" \
	"$(INTDIR)\e_readinch.obj" \
	"$(INTDIR)\e_readmol.obj" \
	"$(INTDIR)\e_readstru.obj" \
	"$(INTDIR)\e_util.obj" \
	"$(INTDIR)\INCHI_MAIN.res" \
	"..\vc6_INCHI_DLL\Debug\libinchi.lib"

"..\vc6_INCHI_DLL\Debug\InChI_MAIN.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("vc6_INCHI_MAIN.dep")
!INCLUDE "vc6_INCHI_MAIN.dep"
!ELSE 
!MESSAGE Warning: cannot find "vc6_INCHI_MAIN.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "vc6_INCHI_MAIN - Win32 Release" || "$(CFG)" == "vc6_INCHI_MAIN - Win32 Debug"
SOURCE=..\INCHI_MAIN\e_0dstereo.c

!IF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Release"


"$(INTDIR)\e_0dstereo.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Debug"


"$(INTDIR)\e_0dstereo.obj"	"$(INTDIR)\e_0dstereo.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\INCHI_MAIN\e_ichi_io.c

!IF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Release"


"$(INTDIR)\e_ichi_io.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Debug"


"$(INTDIR)\e_ichi_io.obj"	"$(INTDIR)\e_ichi_io.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\INCHI_MAIN\e_ichi_parms.c

!IF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Release"


"$(INTDIR)\e_ichi_parms.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Debug"


"$(INTDIR)\e_ichi_parms.obj"	"$(INTDIR)\e_ichi_parms.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\INCHI_MAIN\e_ichimain.c

!IF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Release"

CPP_SWITCHES=/nologo /ML /Ze /W3 /GX /O2 /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "INCHI_LINK_AS_DLL" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\e_ichimain.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Debug"

CPP_SWITCHES=/nologo /MLd /Ze /W3 /Gm /GX /ZI /Od /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "INCHI_LINK_AS_DLL" /Fr"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\e_ichimain.obj"	"$(INTDIR)\e_ichimain.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\INCHI_MAIN\e_inchi_atom.c

!IF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Release"


"$(INTDIR)\e_inchi_atom.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Debug"


"$(INTDIR)\e_inchi_atom.obj"	"$(INTDIR)\e_inchi_atom.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\INCHI_MAIN\e_mol2atom.c

!IF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Release"


"$(INTDIR)\e_mol2atom.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Debug"


"$(INTDIR)\e_mol2atom.obj"	"$(INTDIR)\e_mol2atom.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\INCHI_MAIN\e_readinch.c

!IF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Release"


"$(INTDIR)\e_readinch.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Debug"


"$(INTDIR)\e_readinch.obj"	"$(INTDIR)\e_readinch.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\INCHI_MAIN\e_readmol.c

!IF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Release"


"$(INTDIR)\e_readmol.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Debug"


"$(INTDIR)\e_readmol.obj"	"$(INTDIR)\e_readmol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\INCHI_MAIN\e_readstru.c

!IF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Release"


"$(INTDIR)\e_readstru.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Debug"


"$(INTDIR)\e_readstru.obj"	"$(INTDIR)\e_readstru.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\INCHI_MAIN\e_util.c

!IF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Release"


"$(INTDIR)\e_util.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Debug"


"$(INTDIR)\e_util.obj"	"$(INTDIR)\e_util.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=.\INCHI_MAIN.rc

"$(INTDIR)\INCHI_MAIN.res" : $(SOURCE) "$(INTDIR)"
	$(RSC) $(RSC_PROJ) $(SOURCE)


!IF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Release"

"vc6_INCHI_DLL - Win32 Release" : 
   cd "\#_InChI_101_Released_i386_build\InChI-1-API\INCHI_API\vc6_INCHI_DLL"
   $(MAKE) /$(MAKEFLAGS) /F ".\vc6_INCHI_DLL.mak" CFG="vc6_INCHI_DLL - Win32 Release" 
   cd "..\vc6_INCHI_MAIN"

"vc6_INCHI_DLL - Win32 ReleaseCLEAN" : 
   cd "\#_InChI_101_Released_i386_build\InChI-1-API\INCHI_API\vc6_INCHI_DLL"
   $(MAKE) /$(MAKEFLAGS) /F ".\vc6_INCHI_DLL.mak" CFG="vc6_INCHI_DLL - Win32 Release" RECURSE=1 CLEAN 
   cd "..\vc6_INCHI_MAIN"

!ELSEIF  "$(CFG)" == "vc6_INCHI_MAIN - Win32 Debug"

"vc6_INCHI_DLL - Win32 Debug" : 
   cd "\#_InChI_101_Released_i386_build\InChI-1-API\INCHI_API\vc6_INCHI_DLL"
   $(MAKE) /$(MAKEFLAGS) /F ".\vc6_INCHI_DLL.mak" CFG="vc6_INCHI_DLL - Win32 Debug" 
   cd "..\vc6_INCHI_MAIN"

"vc6_INCHI_DLL - Win32 DebugCLEAN" : 
   cd "\#_InChI_101_Released_i386_build\InChI-1-API\INCHI_API\vc6_INCHI_DLL"
   $(MAKE) /$(MAKEFLAGS) /F ".\vc6_INCHI_DLL.mak" CFG="vc6_INCHI_DLL - Win32 Debug" RECURSE=1 CLEAN 
   cd "..\vc6_INCHI_MAIN"

!ENDIF 


!ENDIF 


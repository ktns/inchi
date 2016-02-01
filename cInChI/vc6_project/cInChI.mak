# Microsoft Developer Studio Generated NMAKE File, Based on cInChI.dsp
!IF "$(CFG)" == ""
CFG=cInChI - Win32 Debug
!MESSAGE No configuration specified. Defaulting to cInChI - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "cInChI - Win32 Release" && "$(CFG)" != "cInChI - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "cInChI.mak" CFG="cInChI - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "cInChI - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "cInChI - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "cInChI - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

ALL : "$(OUTDIR)\cInChI-1.exe"


CLEAN :
	-@erase "$(INTDIR)\cINChI.res"
	-@erase "$(INTDIR)\dispstru.obj"
	-@erase "$(INTDIR)\ichi_bns.obj"
	-@erase "$(INTDIR)\ichican2.obj"
	-@erase "$(INTDIR)\ichicano.obj"
	-@erase "$(INTDIR)\ichicans.obj"
	-@erase "$(INTDIR)\ichiisot.obj"
	-@erase "$(INTDIR)\ichimain.obj"
	-@erase "$(INTDIR)\ichimak2.obj"
	-@erase "$(INTDIR)\ichimake.obj"
	-@erase "$(INTDIR)\ichimap1.obj"
	-@erase "$(INTDIR)\ichimap2.obj"
	-@erase "$(INTDIR)\ichimap4.obj"
	-@erase "$(INTDIR)\ichinorm.obj"
	-@erase "$(INTDIR)\ichiparm.obj"
	-@erase "$(INTDIR)\ichiprt1.obj"
	-@erase "$(INTDIR)\ichiprt2.obj"
	-@erase "$(INTDIR)\ichiprt3.obj"
	-@erase "$(INTDIR)\ichiqueu.obj"
	-@erase "$(INTDIR)\ichiread.obj"
	-@erase "$(INTDIR)\ichiring.obj"
	-@erase "$(INTDIR)\ichirvr1.obj"
	-@erase "$(INTDIR)\ichirvr2.obj"
	-@erase "$(INTDIR)\ichirvr3.obj"
	-@erase "$(INTDIR)\ichirvr4.obj"
	-@erase "$(INTDIR)\ichirvr5.obj"
	-@erase "$(INTDIR)\ichirvr6.obj"
	-@erase "$(INTDIR)\ichirvr7.obj"
	-@erase "$(INTDIR)\ichisort.obj"
	-@erase "$(INTDIR)\ichister.obj"
	-@erase "$(INTDIR)\ichitaut.obj"
	-@erase "$(INTDIR)\mol2atom.obj"
	-@erase "$(INTDIR)\readinch.obj"
	-@erase "$(INTDIR)\readmol.obj"
	-@erase "$(INTDIR)\runichi.obj"
	-@erase "$(INTDIR)\strutil.obj"
	-@erase "$(INTDIR)\util.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(OUTDIR)\cInChI-1.exe"
	-@erase "$(OUTDIR)\cInChI-1.map"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /ML /W3 /GX /O2 /I "../common" /I "../main" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

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
RSC_PROJ=/l 0x409 /fo"$(INTDIR)\cINChI.res" /d "NDEBUG" 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\cInChI.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no /pdb:"$(OUTDIR)\cInChI-1.pdb" /map:"$(INTDIR)\cInChI-1.map" /machine:I386 /out:"$(OUTDIR)\cInChI-1.exe" 
LINK32_OBJS= \
	"$(INTDIR)\dispstru.obj" \
	"$(INTDIR)\ichi_bns.obj" \
	"$(INTDIR)\ichican2.obj" \
	"$(INTDIR)\ichicano.obj" \
	"$(INTDIR)\ichicans.obj" \
	"$(INTDIR)\ichiisot.obj" \
	"$(INTDIR)\ichimain.obj" \
	"$(INTDIR)\ichimak2.obj" \
	"$(INTDIR)\ichimake.obj" \
	"$(INTDIR)\ichimap1.obj" \
	"$(INTDIR)\ichimap2.obj" \
	"$(INTDIR)\ichimap4.obj" \
	"$(INTDIR)\ichinorm.obj" \
	"$(INTDIR)\ichiparm.obj" \
	"$(INTDIR)\ichiprt1.obj" \
	"$(INTDIR)\ichiprt2.obj" \
	"$(INTDIR)\ichiprt3.obj" \
	"$(INTDIR)\ichiqueu.obj" \
	"$(INTDIR)\ichiread.obj" \
	"$(INTDIR)\ichiring.obj" \
	"$(INTDIR)\ichirvr1.obj" \
	"$(INTDIR)\ichirvr2.obj" \
	"$(INTDIR)\ichirvr3.obj" \
	"$(INTDIR)\ichirvr4.obj" \
	"$(INTDIR)\ichirvr5.obj" \
	"$(INTDIR)\ichirvr6.obj" \
	"$(INTDIR)\ichirvr7.obj" \
	"$(INTDIR)\ichisort.obj" \
	"$(INTDIR)\ichister.obj" \
	"$(INTDIR)\ichitaut.obj" \
	"$(INTDIR)\mol2atom.obj" \
	"$(INTDIR)\readinch.obj" \
	"$(INTDIR)\readmol.obj" \
	"$(INTDIR)\runichi.obj" \
	"$(INTDIR)\strutil.obj" \
	"$(INTDIR)\util.obj" \
	"$(INTDIR)\cINChI.res"

"$(OUTDIR)\cInChI-1.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

ALL : "$(OUTDIR)\cInChI-1.exe" "$(OUTDIR)\cInChI.bsc"


CLEAN :
	-@erase "$(INTDIR)\cINChI.res"
	-@erase "$(INTDIR)\dispstru.obj"
	-@erase "$(INTDIR)\dispstru.sbr"
	-@erase "$(INTDIR)\ichi_bns.obj"
	-@erase "$(INTDIR)\ichi_bns.sbr"
	-@erase "$(INTDIR)\ichican2.obj"
	-@erase "$(INTDIR)\ichican2.sbr"
	-@erase "$(INTDIR)\ichicano.obj"
	-@erase "$(INTDIR)\ichicano.sbr"
	-@erase "$(INTDIR)\ichicans.obj"
	-@erase "$(INTDIR)\ichicans.sbr"
	-@erase "$(INTDIR)\ichiisot.obj"
	-@erase "$(INTDIR)\ichiisot.sbr"
	-@erase "$(INTDIR)\ichimain.obj"
	-@erase "$(INTDIR)\ichimain.sbr"
	-@erase "$(INTDIR)\ichimak2.obj"
	-@erase "$(INTDIR)\ichimak2.sbr"
	-@erase "$(INTDIR)\ichimake.obj"
	-@erase "$(INTDIR)\ichimake.sbr"
	-@erase "$(INTDIR)\ichimap1.obj"
	-@erase "$(INTDIR)\ichimap1.sbr"
	-@erase "$(INTDIR)\ichimap2.obj"
	-@erase "$(INTDIR)\ichimap2.sbr"
	-@erase "$(INTDIR)\ichimap4.obj"
	-@erase "$(INTDIR)\ichimap4.sbr"
	-@erase "$(INTDIR)\ichinorm.obj"
	-@erase "$(INTDIR)\ichinorm.sbr"
	-@erase "$(INTDIR)\ichiparm.obj"
	-@erase "$(INTDIR)\ichiparm.sbr"
	-@erase "$(INTDIR)\ichiprt1.obj"
	-@erase "$(INTDIR)\ichiprt1.sbr"
	-@erase "$(INTDIR)\ichiprt2.obj"
	-@erase "$(INTDIR)\ichiprt2.sbr"
	-@erase "$(INTDIR)\ichiprt3.obj"
	-@erase "$(INTDIR)\ichiprt3.sbr"
	-@erase "$(INTDIR)\ichiqueu.obj"
	-@erase "$(INTDIR)\ichiqueu.sbr"
	-@erase "$(INTDIR)\ichiread.obj"
	-@erase "$(INTDIR)\ichiread.sbr"
	-@erase "$(INTDIR)\ichiring.obj"
	-@erase "$(INTDIR)\ichiring.sbr"
	-@erase "$(INTDIR)\ichirvr1.obj"
	-@erase "$(INTDIR)\ichirvr1.sbr"
	-@erase "$(INTDIR)\ichirvr2.obj"
	-@erase "$(INTDIR)\ichirvr2.sbr"
	-@erase "$(INTDIR)\ichirvr3.obj"
	-@erase "$(INTDIR)\ichirvr3.sbr"
	-@erase "$(INTDIR)\ichirvr4.obj"
	-@erase "$(INTDIR)\ichirvr4.sbr"
	-@erase "$(INTDIR)\ichirvr5.obj"
	-@erase "$(INTDIR)\ichirvr5.sbr"
	-@erase "$(INTDIR)\ichirvr6.obj"
	-@erase "$(INTDIR)\ichirvr6.sbr"
	-@erase "$(INTDIR)\ichirvr7.obj"
	-@erase "$(INTDIR)\ichirvr7.sbr"
	-@erase "$(INTDIR)\ichisort.obj"
	-@erase "$(INTDIR)\ichisort.sbr"
	-@erase "$(INTDIR)\ichister.obj"
	-@erase "$(INTDIR)\ichister.sbr"
	-@erase "$(INTDIR)\ichitaut.obj"
	-@erase "$(INTDIR)\ichitaut.sbr"
	-@erase "$(INTDIR)\mol2atom.obj"
	-@erase "$(INTDIR)\mol2atom.sbr"
	-@erase "$(INTDIR)\readinch.obj"
	-@erase "$(INTDIR)\readinch.sbr"
	-@erase "$(INTDIR)\readmol.obj"
	-@erase "$(INTDIR)\readmol.sbr"
	-@erase "$(INTDIR)\runichi.obj"
	-@erase "$(INTDIR)\runichi.sbr"
	-@erase "$(INTDIR)\strutil.obj"
	-@erase "$(INTDIR)\strutil.sbr"
	-@erase "$(INTDIR)\util.obj"
	-@erase "$(INTDIR)\util.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(OUTDIR)\cInChI-1.exe"
	-@erase "$(OUTDIR)\cInChI-1.ilk"
	-@erase "$(OUTDIR)\cInChI-1.pdb"
	-@erase "$(OUTDIR)\cInChI.bsc"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /MLd /W3 /Gm /GX /ZI /Od /I "../common" /I "../main" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

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
RSC_PROJ=/l 0x409 /fo"$(INTDIR)\cINChI.res" /d "_DEBUG" 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\cInChI.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\dispstru.sbr" \
	"$(INTDIR)\ichi_bns.sbr" \
	"$(INTDIR)\ichican2.sbr" \
	"$(INTDIR)\ichicano.sbr" \
	"$(INTDIR)\ichicans.sbr" \
	"$(INTDIR)\ichiisot.sbr" \
	"$(INTDIR)\ichimain.sbr" \
	"$(INTDIR)\ichimak2.sbr" \
	"$(INTDIR)\ichimake.sbr" \
	"$(INTDIR)\ichimap1.sbr" \
	"$(INTDIR)\ichimap2.sbr" \
	"$(INTDIR)\ichimap4.sbr" \
	"$(INTDIR)\ichinorm.sbr" \
	"$(INTDIR)\ichiparm.sbr" \
	"$(INTDIR)\ichiprt1.sbr" \
	"$(INTDIR)\ichiprt2.sbr" \
	"$(INTDIR)\ichiprt3.sbr" \
	"$(INTDIR)\ichiqueu.sbr" \
	"$(INTDIR)\ichiread.sbr" \
	"$(INTDIR)\ichiring.sbr" \
	"$(INTDIR)\ichirvr1.sbr" \
	"$(INTDIR)\ichirvr2.sbr" \
	"$(INTDIR)\ichirvr3.sbr" \
	"$(INTDIR)\ichirvr4.sbr" \
	"$(INTDIR)\ichirvr5.sbr" \
	"$(INTDIR)\ichirvr6.sbr" \
	"$(INTDIR)\ichirvr7.sbr" \
	"$(INTDIR)\ichisort.sbr" \
	"$(INTDIR)\ichister.sbr" \
	"$(INTDIR)\ichitaut.sbr" \
	"$(INTDIR)\mol2atom.sbr" \
	"$(INTDIR)\readinch.sbr" \
	"$(INTDIR)\readmol.sbr" \
	"$(INTDIR)\runichi.sbr" \
	"$(INTDIR)\strutil.sbr" \
	"$(INTDIR)\util.sbr"

"$(OUTDIR)\cInChI.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:yes /pdb:"$(OUTDIR)\cInChI-1.pdb" /debug /machine:I386 /out:"$(OUTDIR)\cInChI-1.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\dispstru.obj" \
	"$(INTDIR)\ichi_bns.obj" \
	"$(INTDIR)\ichican2.obj" \
	"$(INTDIR)\ichicano.obj" \
	"$(INTDIR)\ichicans.obj" \
	"$(INTDIR)\ichiisot.obj" \
	"$(INTDIR)\ichimain.obj" \
	"$(INTDIR)\ichimak2.obj" \
	"$(INTDIR)\ichimake.obj" \
	"$(INTDIR)\ichimap1.obj" \
	"$(INTDIR)\ichimap2.obj" \
	"$(INTDIR)\ichimap4.obj" \
	"$(INTDIR)\ichinorm.obj" \
	"$(INTDIR)\ichiparm.obj" \
	"$(INTDIR)\ichiprt1.obj" \
	"$(INTDIR)\ichiprt2.obj" \
	"$(INTDIR)\ichiprt3.obj" \
	"$(INTDIR)\ichiqueu.obj" \
	"$(INTDIR)\ichiread.obj" \
	"$(INTDIR)\ichiring.obj" \
	"$(INTDIR)\ichirvr1.obj" \
	"$(INTDIR)\ichirvr2.obj" \
	"$(INTDIR)\ichirvr3.obj" \
	"$(INTDIR)\ichirvr4.obj" \
	"$(INTDIR)\ichirvr5.obj" \
	"$(INTDIR)\ichirvr6.obj" \
	"$(INTDIR)\ichirvr7.obj" \
	"$(INTDIR)\ichisort.obj" \
	"$(INTDIR)\ichister.obj" \
	"$(INTDIR)\ichitaut.obj" \
	"$(INTDIR)\mol2atom.obj" \
	"$(INTDIR)\readinch.obj" \
	"$(INTDIR)\readmol.obj" \
	"$(INTDIR)\runichi.obj" \
	"$(INTDIR)\strutil.obj" \
	"$(INTDIR)\util.obj" \
	"$(INTDIR)\cINChI.res"

"$(OUTDIR)\cInChI-1.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("cInChI.dep")
!INCLUDE "cInChI.dep"
!ELSE 
!MESSAGE Warning: cannot find "cInChI.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "cInChI - Win32 Release" || "$(CFG)" == "cInChI - Win32 Debug"
SOURCE=..\main\dispstru.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\dispstru.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\dispstru.obj"	"$(INTDIR)\dispstru.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichi_bns.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichi_bns.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichi_bns.obj"	"$(INTDIR)\ichi_bns.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichican2.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichican2.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichican2.obj"	"$(INTDIR)\ichican2.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichicano.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichicano.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichicano.obj"	"$(INTDIR)\ichicano.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichicans.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichicans.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichicans.obj"	"$(INTDIR)\ichicans.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichiisot.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichiisot.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichiisot.obj"	"$(INTDIR)\ichiisot.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\main\ichimain.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichimain.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichimain.obj"	"$(INTDIR)\ichimain.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichimak2.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichimak2.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichimak2.obj"	"$(INTDIR)\ichimak2.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichimake.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichimake.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichimake.obj"	"$(INTDIR)\ichimake.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichimap1.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichimap1.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichimap1.obj"	"$(INTDIR)\ichimap1.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichimap2.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichimap2.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichimap2.obj"	"$(INTDIR)\ichimap2.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichimap4.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichimap4.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichimap4.obj"	"$(INTDIR)\ichimap4.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichinorm.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichinorm.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichinorm.obj"	"$(INTDIR)\ichinorm.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichiparm.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichiparm.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichiparm.obj"	"$(INTDIR)\ichiparm.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichiprt1.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichiprt1.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichiprt1.obj"	"$(INTDIR)\ichiprt1.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichiprt2.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichiprt2.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichiprt2.obj"	"$(INTDIR)\ichiprt2.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichiprt3.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichiprt3.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichiprt3.obj"	"$(INTDIR)\ichiprt3.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichiqueu.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichiqueu.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichiqueu.obj"	"$(INTDIR)\ichiqueu.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichiread.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichiread.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichiread.obj"	"$(INTDIR)\ichiread.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichiring.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichiring.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichiring.obj"	"$(INTDIR)\ichiring.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichirvr1.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichirvr1.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichirvr1.obj"	"$(INTDIR)\ichirvr1.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichirvr2.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichirvr2.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichirvr2.obj"	"$(INTDIR)\ichirvr2.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichirvr3.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichirvr3.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichirvr3.obj"	"$(INTDIR)\ichirvr3.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichirvr4.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichirvr4.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichirvr4.obj"	"$(INTDIR)\ichirvr4.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichirvr5.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichirvr5.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichirvr5.obj"	"$(INTDIR)\ichirvr5.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichirvr6.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichirvr6.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichirvr6.obj"	"$(INTDIR)\ichirvr6.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichirvr7.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichirvr7.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichirvr7.obj"	"$(INTDIR)\ichirvr7.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichisort.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichisort.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichisort.obj"	"$(INTDIR)\ichisort.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichister.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichister.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichister.obj"	"$(INTDIR)\ichister.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\ichitaut.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\ichitaut.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\ichitaut.obj"	"$(INTDIR)\ichitaut.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\main\mol2atom.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\mol2atom.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\mol2atom.obj"	"$(INTDIR)\mol2atom.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\main\readinch.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\readinch.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\readinch.obj"	"$(INTDIR)\readinch.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\main\readmol.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\readmol.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\readmol.obj"	"$(INTDIR)\readmol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\runichi.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\runichi.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\runichi.obj"	"$(INTDIR)\runichi.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\strutil.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\strutil.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\strutil.obj"	"$(INTDIR)\strutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\common\util.c

!IF  "$(CFG)" == "cInChI - Win32 Release"


"$(INTDIR)\util.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "cInChI - Win32 Debug"


"$(INTDIR)\util.obj"	"$(INTDIR)\util.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=.\cINChI.rc

"$(INTDIR)\cINChI.res" : $(SOURCE) "$(INTDIR)"
	$(RSC) $(RSC_PROJ) $(SOURCE)



!ENDIF 


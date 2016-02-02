# Microsoft Developer Studio Project File - Name="stdinchi" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=stdinchi - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "stdinchi.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "stdinchi.mak" CFG="stdinchi - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "stdinchi - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "stdinchi - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "stdinchi - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /W3 /GX /Ox /I "../common" /I "../main" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FD /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /map /machine:I386 /out:"Release/stdinchi-1.exe"

!ELSEIF  "$(CFG)" == "stdinchi - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /W3 /Gm /GX /ZI /Od /I "../common" /I "../main" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FR /FD /GZ /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /out:"Debug/stdinchi-1.exe" /pdbtype:sept

!ENDIF 

# Begin Target

# Name "stdinchi - Win32 Release"
# Name "stdinchi - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\main\dispstru.c
# End Source File
# Begin Source File

SOURCE=..\common\ichi_bns.c
# End Source File
# Begin Source File

SOURCE=..\common\ichi_io.c
# End Source File
# Begin Source File

SOURCE=..\common\ichican2.c
# End Source File
# Begin Source File

SOURCE=..\common\ichicano.c
# End Source File
# Begin Source File

SOURCE=..\common\ichicans.c
# End Source File
# Begin Source File

SOURCE=..\common\ichiisot.c
# End Source File
# Begin Source File

SOURCE=..\main\ichimain.c
# End Source File
# Begin Source File

SOURCE=..\common\ichimak2.c
# End Source File
# Begin Source File

SOURCE=..\common\ichimake.c
# End Source File
# Begin Source File

SOURCE=..\common\ichimap1.c
# End Source File
# Begin Source File

SOURCE=..\common\ichimap2.c
# End Source File
# Begin Source File

SOURCE=..\common\ichimap4.c
# End Source File
# Begin Source File

SOURCE=..\common\ichinorm.c
# End Source File
# Begin Source File

SOURCE=..\common\ichiparm.c
# End Source File
# Begin Source File

SOURCE=..\common\ichiprt1.c
# End Source File
# Begin Source File

SOURCE=..\common\ichiprt2.c
# End Source File
# Begin Source File

SOURCE=..\common\ichiprt3.c
# End Source File
# Begin Source File

SOURCE=..\common\ichiqueu.c
# End Source File
# Begin Source File

SOURCE=..\common\ichiread.c
# End Source File
# Begin Source File

SOURCE=..\common\ichiring.c
# End Source File
# Begin Source File

SOURCE=..\common\ichirvr1.c
# End Source File
# Begin Source File

SOURCE=..\common\ichirvr2.c
# End Source File
# Begin Source File

SOURCE=..\common\ichirvr3.c
# End Source File
# Begin Source File

SOURCE=..\common\ichirvr4.c
# End Source File
# Begin Source File

SOURCE=..\common\ichirvr5.c
# End Source File
# Begin Source File

SOURCE=..\common\ichirvr6.c
# End Source File
# Begin Source File

SOURCE=..\common\ichirvr7.c
# End Source File
# Begin Source File

SOURCE=..\common\ichisort.c
# End Source File
# Begin Source File

SOURCE=..\common\ichister.c
# End Source File
# Begin Source File

SOURCE=..\common\ichitaut.c
# End Source File
# Begin Source File

SOURCE=..\common\ikey_base26.c
# End Source File
# Begin Source File

SOURCE=..\common\ikey_dll.c
# End Source File
# Begin Source File

SOURCE=..\main\mol2atom.c
# End Source File
# Begin Source File

SOURCE=..\main\readinch.c
# End Source File
# Begin Source File

SOURCE=..\main\readmol.c
# End Source File
# Begin Source File

SOURCE=..\common\runichi.c
# End Source File
# Begin Source File

SOURCE=..\common\sha2.c
# End Source File
# Begin Source File

SOURCE=..\common\strutil.c
# End Source File
# Begin Source File

SOURCE=..\common\util.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\common\aux2atom.h
# End Source File
# Begin Source File

SOURCE=..\main\dispstru.h
# End Source File
# Begin Source File

SOURCE=..\common\extr_ct.h
# End Source File
# Begin Source File

SOURCE=..\common\ichi.h
# End Source File
# Begin Source File

SOURCE=..\common\ichi_bns.h
# End Source File
# Begin Source File

SOURCE=..\common\ichi_io.h
# End Source File
# Begin Source File

SOURCE=..\common\ichicano.h
# End Source File
# Begin Source File

SOURCE=..\common\ichicant.h
# End Source File
# Begin Source File

SOURCE=..\common\ichicomn.h
# End Source File
# Begin Source File

SOURCE=..\common\ichicomp.h
# End Source File
# Begin Source File

SOURCE=..\common\ichidrp.h
# End Source File
# Begin Source File

SOURCE=..\common\ichierr.h
# End Source File
# Begin Source File

SOURCE=..\common\ichimain.h
# End Source File
# Begin Source File

SOURCE=..\common\ichimake.h
# End Source File
# Begin Source File

SOURCE=..\common\ichinorm.h
# End Source File
# Begin Source File

SOURCE=..\common\ichiparm.h
# End Source File
# Begin Source File

SOURCE=..\common\ichiring.h
# End Source File
# Begin Source File

SOURCE=..\common\ichisize.h
# End Source File
# Begin Source File

SOURCE=..\common\ichister.h
# End Source File
# Begin Source File

SOURCE=..\common\ichitaut.h
# End Source File
# Begin Source File

SOURCE=..\common\ikey_base26.h
# End Source File
# Begin Source File

SOURCE=..\common\inchi_api.h
# End Source File
# Begin Source File

SOURCE=..\common\incomdef.h
# End Source File
# Begin Source File

SOURCE=..\common\inpdef.h
# End Source File
# Begin Source File

SOURCE=..\common\lreadmol.h
# End Source File
# Begin Source File

SOURCE=..\main\mode.h
# End Source File
# Begin Source File

SOURCE=..\main\mol2atom.h
# End Source File
# Begin Source File

SOURCE=..\main\readmol.h
# End Source File
# Begin Source File

SOURCE=..\common\sha2.h
# End Source File
# Begin Source File

SOURCE=..\common\strutil.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\stdinchi.rc
# End Source File
# End Group
# End Target
# End Project

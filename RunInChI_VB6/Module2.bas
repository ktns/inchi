Attribute VB_Name = "Module2"
Option Explicit
Option Base 0

'***************************************************
'***************************************************
'****                                           ****
'****           InChI DLL API                   ****
'****                                           ****
'***************************************************
'***************************************************

' constants for inchi_Atom user-defined type
Public Const MAXVAL = 20
Public Const ATOM_EL_LEN = 6
Public Const NUM_H_ISOTOPES = 3
'this flag means isotopic shift relative to avg. atw, not abs. isotopic mass
Public Const ISOTOPIC_SHIFT_FLAG As Integer = 10000

'*********************** inchi_Atom **********************************
' The order and sizes of the inchi_Atom members exactly fit the InChI
' input C-language datastructure described in inchi_api.h header file
'*********************************************************************
Type inchi_Atom
    '/* atom coordinates */
    x As Double
    y As Double
    z As Double
    '/* connectivity */
    neighbor(MAXVAL - 1) As Integer  '/* adjacency list: ordering numbers of the adjacent atoms, >= 0 */
    bond_type(MAXVAL - 1) As Byte    '/* inchi_BondType */
    '/* 2D stereo */
    bond_stereo(MAXVAL - 1) As Byte  '/* inchi_BondStereo2D; negative if the sharp end points to another atom */
    '/* other atom properties */
    elname(ATOM_EL_LEN - 1) As Byte '/* zero-terminated chemical element name: "H", "Si", etc. */
    num_bonds As Integer          '/* number of neighbors, bond types and bond stereo in the adjacency list */
    num_iso_H(NUM_H_ISOTOPES) As Byte '/* implicit hydrogen atoms */
                                  '/* [0]: number of implicit non-isotopic H
                                  '     (exception: num_iso_H[0]=-1 means INCHI adds implicit H automatically),
                                  '   [1]: number of implicit isotopic 1H (protium),
                                  '   [2]: number of implicit 2H (deuterium),
                                  '   [3]: number of implicit 3H (tritium) */
    isotopic_mass As Integer      '/* 0 => non-isotopic; isotopic mass or 10000 + mass - (average atomic mass) */
    radical As Byte               '/* inchi_Radical */
    charge As Byte                '/* positive or negative; 0 => no charge */
End Type


    
'*********************** inchi_Stereo0D **********************************
' The order and sizes of the inchi_Stereo0D members exactly fit the InChI
' input C-language datastructure described in inchi_api.h header file
' The inchi_Stereo0D datastructure is not used in this VB6 example
'*************************************************************************
Type inchi_Stereo0D
    neighbor(3) As Integer    '/* 4 atoms always */
    central_atom As Integer   '/* central tetrahedral atom or cenral atom of allene; otherwise NO_ATOM */
    type As Byte              '/* inchi_StereoType0D */
    parity As Byte            '/* inchi_StereoParity0D: may be a commbination of two parities: */
                              '/* ParityOfConnected | (ParityOfDisconnected << 3), see Note above */
End Type
    
'*********************** inchi_Input **********************************
' The order and sizes of the inchi_Input members exactly fit the InChI
' input C-language datastructure described in inchi_api.h header file
'*************************************************************************
Type inchi_Input
    '/* the caller is responsible for the data allocation and deallocation */
    ptr2inchi_Atom  As Long       ' /* array of num_atoms length */
    ptr2inchi_Stereo0D As Long    ' /* array of num_stereo0D 0D stereo elements or NULL */
    prt2ByteStr_szOptions As Long ' /* InChI options: space-delimited; each is preceded by '/' or '-' */
    num_atoms As Integer          ' /* number of atoms in the compound < 1024 */
    num_stereo0D As Integer       ' /* number of 0D stereo elements */
End Type

'*********************** inchi_Output **********************************
' The order and sizes of the inchi_Output members exactly fit the InChI
' input C-language datastructure described in inchi_api.h header file
'*************************************************************************
Type inchi_Output
    '/* zero-terminated C-strings allocated by InChI */
    ptr2ByteStr_szInChI As Long      ' /* InChI string */
    ptr2ByteStr_szAuxInfo As Long    ' /* Aux info string */
    ptr2ByteStr_szMessage As Long    ' /* Error/warning message */
    ptr2ByteStr_szLog  As Long       ' /* log-file string */
End Type

'====== InChI DLL functions declarations ===========
Declare Function GetINCHI Lib "libinchi.dll" Alias "_GetINCHI@8" (ByRef inp As inchi_Input, ByRef out As inchi_Output) As Long
Declare Sub FreeINCHI Lib "libinchi.dll" Alias "_FreeINCHI@4" (out As inchi_Output)
' an alternative to Win32 API function lstrlen()
Declare Function GetStringLength Lib "libinchi.dll" Alias "_GetStringLength@4" (ByVal ptr As Long) As Long

'***************************************************
'***************************************************
'****                                           ****
'****     End of InChI DLL API                  ****
'****                                           ****
'***************************************************
'***************************************************

'*********************************************************
' VB6 representation of InChI options, used to fill out
' InChI options string from the "InChI Options" dialog
'*********************************************************
Type bOptionsType
    bFixedH As Integer
    nStereoMode As Integer
    bNarrowEowPoints2SC As Integer
    bIncBondsToMetal As Integer
    bDisableAggrDeprot As Integer
    bDisplayInchi As Integer
    sOtherOpt As String
    sHeader As String                'for finding in SDfile
    sInputFile As String
End Type


'====== useful external Win32 API functions declarations ====
Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Declare Sub ZeroMemory Lib "kernel32" Alias "RtlZeroMemory" (dest As Any, ByVal numBytes As Long)
Declare Sub FillMemory Lib "kernel32" Alias "RtlFillMemory" (dest As Any, ByVal numBytes As Long, ByVal byteFill As Byte)
Declare Function lstrlen Lib "kernel32" Alias "lstrlenA" (prt2Cstring As Any) As Long
' Win32 API Message Functions
Declare Function TranslateMessage Lib "user32" (lpMsg As MSG) As Long
Declare Function DispatchMessage Lib "user32" Alias "DispatchMessageA" (lpMsg As MSG) As Long
Declare Function PeekMessage Lib "user32" Alias "PeekMessageA" (lpMsg As MSG, ByVal hwnd As Long, ByVal wMsgFilterMin As Long, ByVal wMsgFilterMax As Long, ByVal wRemoveMsg As Long) As Long
Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
' PeekMessage() Options
Const PM_NOREMOVE = &H0
Const PM_REMOVE = &H1
Const PM_NOYIELD = &H2
' Win32 Message datastructure
Type POINTAPI
        x As Long
        y As Long
End Type
Type MSG
    hwnd As Long
    Message As Long
    wParam As Long
    lParam As Long
    time As Long
    pt As POINTAPI
End Type
Dim Message As MSG

'Message to close the application; used when InChI is running
Public Const WM_CLOSE = &H10

'==========================================================================
' VB6 interface to dll functions useful details
' s   As String => char *ps :  ByVal s {VB6 autoconersion Unicode->C-string when calling dll}
' b() As Byte   => char *pb : VarPtr(b(0)) {pointer to the first byte of the Byte array}
' D   As UserType => UserType *pD : ByRef D as UserType {pointer to the user-defined structure as an argument to a dll function}
'                              pD = VarPtr(D) {another way of getting same pointer}
'
' C-pointer to VB Function f():  *pf = AddressOf f
'
' Useful functions and operations
' -- concatenate strings keeping zero (Chr$(0)) characters: &
' -- IsEmpty(s): IsEmpty returns True if the variable is uninitialized, or
'                is explicitly set to Empty; otherwise, it returns False
' -- InStr, InStrRev: strstr() type search
' -- ReDim: dynamic allocation
' -- Erase: dynamic deallocation
'============================================================================

'=== Globals ========
'stereo type radio button indexes = InChI stereo types:
Public Const inchi_StereoNon = 0
Public Const inchi_StereoAbs = 1
Public Const inchi_StereoRel = 2
Public Const inchi_StereoRac = 3
Public Const inchi_StereoUCF = 4 'Use Chiral Flag
Public Const inchi_StereoLast = 4 'the last radio button index

Public bOptions As bOptionsType ' InChI options
Public bRunInChI As Boolean     ' True when InChI dll is running
Public bCloseApp As Boolean     ' True if the user requested Close App when InChI is running

'output text window sepatator between unchanged text and InChI output
Public Const OutputDelimiter As String = "InChI Messages:" & vbCrLf
'max length of the text in the output window
Const MaxTextLen = 5000
'file numbers
Const InpFile = 1
Const OutFile = 2
Const LogFile = 3

Sub PumpInchiMessages(hwnd As Long)
    Dim mymsg As MSG
    Do While 0 <> PeekMessage(mymsg, 0, 0, 0, PM_REMOVE)
        'TranslateMessage mymsg 'Needed in dialogs only?
        DispatchMessage mymsg
    Loop
End Sub


' Default InChI options
Public Sub SetDefaultOptions()
    bOptions.bFixedH = False
    bOptions.nStereoMode = inchi_StereoAbs
    bOptions.bNarrowEowPoints2SC = 0
    bOptions.bIncBondsToMetal = 0
    bOptions.bDisableAggrDeprot = 0
    bOptions.sOtherOpt = "/W60"
    bOptions.sInputFile = ""
    bOptions.sHeader = ""
End Sub
' Create InChI options string from the user-entered options
Sub CreateOptionsString(ByRef sAllOptions As String)
    sAllOptions = ""
    
    If bOptions.bFixedH Then
        sAllOptions = sAllOptions & " /FixedH"
    End If
    
    Select Case bOptions.nStereoMode
    Case inchi_StereoNon
        sAllOptions = sAllOptions & " /SNon"
    Case inchi_StereoAbs
        sAllOptions = sAllOptions & " /SAbs"
    Case inchi_StereoRel
        sAllOptions = sAllOptions & " /SRel"
    Case inchi_StereoRac
        sAllOptions = sAllOptions & " /SRac"
    Case inchi_StereoUCF
        sAllOptions = sAllOptions & " /SUCF" 'use stereo flag
    End Select
    
    If bOptions.nStereoMode <> inchi_StereoNon And bOptions.bNarrowEowPoints2SC > 0 Then
        sAllOptions = sAllOptions & " /newps"
    End If
    
    If bOptions.bIncBondsToMetal Then
        sAllOptions = sAllOptions & " /RecMet"
    End If
    
    If bOptions.bDisableAggrDeprot Then
        sAllOptions = sAllOptions & " /NoADP"
    End If
    If bOptions.sOtherOpt <> "" Then
        sAllOptions = sAllOptions + " " + bOptions.sOtherOpt
    End If
End Sub
' convert ASCII contents of Byte array to VB6 String
' replace end of line characters Lf (C feature) with CrLf (needed by VB)
Function CopyCStringPtrToString(ByRef s As String, ptr As Long, bCutOffLastErrWarn As Long)
    Dim lgt As Long, nLfPos1 As Long, nLfPos2 As Long
    Dim b() As Byte
    Dim sParsedString
    
    If ptr <> 0 Then
        lgt = lstrlen(ByVal ptr)    ' find length of the zero-terminated C-string
        'lgt = GetStringLength(ptr) '<-- alternative to Win32 API function lstrlen
    Else
        lgt = 0
    End If
    
    If lgt > 0 Then
        
        ' allocate new byte array
        ReDim b(lgt - 1)
        ' fill it with ASCII string
        Call CopyMemory(b(0), ByVal ptr, lgt)
        ' convert to VB String
        s = StrConv(b, vbUnicode)
        ' free memory
        Erase b
        
        'replace "Lf" with "CrLf": Win32 C-string specific necessary for TextBox display
        ' 1. Special case: Lf is the first character
        If Left(s, 1) = vbLf Then
            'special case: string s starts with LF
            nLfPos1 = 2
            nLfPos2 = 2
            sParsedString = vbCrLf
        Else
            nLfPos1 = 1
            nLfPos2 = 1
            sParsedString = ""
        End If
        ' 2. All other Lf locations
        Do
            nLfPos2 = InStr(nLfPos2, s, vbLf)
            If nLfPos2 > nLfPos1 Then
                If Mid(s, nLfPos2 - 1, 1) <> vbCr Then
                    sParsedString = sParsedString + Mid(s, nLfPos1, nLfPos2 - nLfPos1) + vbCrLf
                    nLfPos2 = nLfPos2 + 1
                    nLfPos1 = nLfPos2
                Else
                    nLfPos2 = nLfPos2 + 1
                End If
            End If
        Loop While nLfPos2 > 0
        ' If the last line is not Lf-terminated:
        If sParsedString <> "" Then
            If nLfPos1 < Len(s) Then
                'InChI Log text specific: remove last error/warning line
                'Because it will be extracted from InChI message and
                ' displayed separately and independently of this Log text
                If bCutOffLastErrWarn <> 0 And _
                   (nLfPos1 = InStr(nLfPos1, s, "Warning", vbTextCompare) Or _
                    nLfPos1 = InStr(nLfPos1, s, "Error", vbTextCompare) Or _
                    nLfPos1 = InStr(nLfPos1, s, "Fatal", vbTextCompare)) Then
                    'do not add the last line containing warning or error
                Else
                    sParsedString = sParsedString + Mid(s, nLfPos1)
                End If
            End If
            s = sParsedString
        End If
        'remove trailing CrLf if present
        If s = vbCrLf Then
            s = ""
        ElseIf Len(s) > 2 Then
            If Right(s, 2) = vbCrLf Then
                s = Left(s, Len(s) - 2)
            End If
        End If
        'return length of the string
        CopyCStringPtrToString = Len(s)
    Else
        s = ""
        CopyCStringPtrToString = 0
    End If
End Function
' supplement InChI message with information about return code and the chemical structure number
Sub MakeInchiLogfileString(ByRef sMessage As String, nRet As Long, nNumStruct As Long, sHeader As String, sLabel As String)
    'add return code info
    If sMessage <> "" Then
        If 0 <= nRet And nRet <= 1 Then
            sMessage = "Warning (" & sMessage & ")"
        ElseIf nRet = 2 Then
            sMessage = "Error (No InChI; " & sMessage & ")"
        ElseIf nRet > 2 Then
            sMessage = "Fatal Error (No InChI; " & sMessage & ")"
        Else
            sMessage = "Unknown Error (No InChI; " & sMessage & ")"
        End If
    Else
        If 0 = nRet Then
            sMessage = ""
        ElseIf nRet = 1 Then
            sMessage = "Unknown Warning"
        ElseIf nRet = 2 Then
            sMessage = "Error (No InChI)"
        ElseIf nRet > 2 Then
            sMessage = "Fatal Error (No InChI)"
        Else
            sMessage = "Unknown Error (No InChI)"
        End If
    End If
    'add structure info
    Call AddInchiTitleString(sMessage, nNumStruct, sHeader, sLabel)
End Sub
'add structure info
Sub AddInchiTitleString(ByRef sMessage As String, nNumStruct As Long, sHeader As String, sLabel As String)
    If sMessage <> "" Then sMessage = sMessage & " "
    sMessage = sMessage + "Structure:" + Str(nNumStruct) + "."
    If sHeader <> "" And sLabel <> "" Then
        sMessage = sMessage + " " + sHeader + "=" + sLabel
    End If
End Sub
'output one or more lines to the text window (multiline edit control)
Sub AddLineToTextWindow(tbText As TextBox, s As String)
    Dim lgt As Long, start As Long, pos As Long, pos2 As Long, len2remove As Long
    Dim sTxt As String  'text window text: TextBox text does not support Mid(), Left(), etc.
            
    lgt = Len(tbText.Text)
    If lgt > MaxTextLen Then
        'the contents of the text window exceed the limit
        'remove lines starting from the first beloe the last fixed line
        'to reduce the text length
        sTxt = tbText.Text
        'find the last line to be left unchanged
        start = InStr(sTxt, OutputDelimiter)
        If start > 0 Then
            start = start + Len(OutputDelimiter) - 1 'the 1st char after the fixed part
        Else
            start = 1 'fixed part not found; proceed anyway
        End If
        len2remove = 0
        pos = start
        Do While lgt - len2remove > MaxTextLen
            pos2 = InStr(pos, sTxt, vbCrLf)
            If pos2 > pos Then
                pos2 = pos2 + Len(vbCrLf)
                len2remove = pos2 - start
                pos = pos2
            Else
                Exit Do
            End If
        Loop
        tbText.Text = Left(sTxt, start) + Mid(sTxt, pos) + s
    Else
        tbText.Text = tbText.Text + s
    End If
End Sub
'check file name and display it on the status line
Public Function DisplayInpFileName(frm As Form) As Boolean
    If IsEmpty(bOptions.sInputFile) Or bOptions.sInputFile = "" Or _
       0 < InStr(bOptions.sInputFile, "*") Or 0 < InStr(bOptions.sInputFile, "?") Or _
       Dir(bOptions.sInputFile, vbReadOnly) <= " " Then
        SetMyStatusLine frm.sMyStatusText, 0, "Input file not specified"
        DisplayInpFileName = False
    Else
        SetMyStatusLine frm.sMyStatusText, 0, "Input file: " + q(bOptions.sInputFile)
        DisplayInpFileName = True
    End If
End Function
' output string to 'status' line
Public Sub SetMyStatusLine(tbStatus As TextBox, n As Long, s As String)
    If n <> 0 Then
        tbStatus.Text = "Structure" + Str(n)
    Else
        tbStatus.Text = s
    End If
End Sub
' output a number and a plural or single noun
Public Function w(n As Long, s As String) As String
    If n = 1 Then
        w = Str(n) + " " + s
    Else
        w = Str(n) + " " + s + "s"
    End If
End Function
' output a quoted string
Public Function q(s As String) As String
    q = Chr(34) + s + Chr(34)
End Function

'******************************************************
'* The main Sub: Run InChI dll and output the results
'******************************************************
Public Sub Struct2InChI(ByRef frm As frmMain)

    
    'InChI dll GetInChI() input
    Dim inAtom() As inchi_Atom  'from Molfile, member of inInp
    Dim numAtoms As Integer     'from Molfile, member of inInp
    Dim byteOptions() As Byte   'InChI options as Byte array
    Dim inInp As inchi_Input    'GetInChI() input datastructure
    'InChI dll GetInChI() output
    Dim inOut As inchi_Output   'GetInChI() output datastructure
    Dim nRet As Long            'InChI return value
    Dim nRet2 As Long           'InChI return value or warning flag
    Dim sMessage As String      'InChI message as String
    Dim sInChI As String        'InChI Identifier as String
    Dim sAuxInfo As String      'InChI Auxiliary Information as String
    Dim sFirstLogInfo As String 'InChI options list as recognized by InChI
    Dim sLogfileString As String 'InChI message for log file
    
    Dim sInchiHdr As String     'A hand-made header for InChI output onto output file
    Dim lgt As Long             'length of a string returned by GetInChI()
    Dim bFirstStructure As Boolean 'Indicator of the 1st processed by InChI structure
    Dim bError As Boolean       'Error flag
    
    Dim sLabel As String        'SDfile label (data) cooresponding to bOptions.sHeader
    Dim nErr As Long            'Number of erroneous structures
    Dim nNumStruct As Long      'Total number of structures
    
    Dim sAllOptions As String    'InChI options as String (input)
    Dim sAllCurOptions As String 'InChI options for the current structure
    Dim bChiral As Integer       'Structure Chiral flag
        
    nErr = 0
    sFirstLogInfo = ""
    bFirstStructure = True
    
    ' check input file
    If Not DisplayInpFileName(frm) Then
        AddLineToTextWindow frm.sOutputWindowText, _
                            "Error: Input file " + _
                            q(bOptions.sInputFile) + _
                            " not found" + vbCrLf
        Exit Sub
    End If
    
    'combine InChI options into one string
    Call CreateOptionsString(sAllOptions)
    
    Open bOptions.sInputFile For Input As InpFile 'input structure file
    AddLineToTextWindow frm.sOutputWindowText, "Opened file " + q(bOptions.sInputFile) + " for structure input" + vbCrLf
    Open bOptions.sInputFile + ".txt" For Output As OutFile 'output InChI file
    AddLineToTextWindow frm.sOutputWindowText, "Opened Output file " + q(bOptions.sInputFile + ".txt") + vbCrLf
    Open bOptions.sInputFile + ".log" For Output As LogFile
    AddLineToTextWindow frm.sOutputWindowText, "Opened Log file " + q(bOptions.sInputFile + ".log") + vbCrLf
    
    Print #OutFile, "* Input_File: " + q(bOptions.sInputFile)  'output input file name
    Print #OutFile,
    nNumStruct = 0
    Call ZeroMemory(inOut, Len(inOut)) 'fill with zeroes
    Call ZeroMemory(inInp, Len(inInp)) 'fill with zeroes
    
    '''''''''''''''''''''''''''''''''''''''
    ' Main Cycle: read structure
    '             create InChI
    '             output InChI
    '''''''''''''''''''''''''''''''''''''''
    
    Do
    
        numAtoms = ReadStructure(inAtom, bOptions.sHeader, sLabel, bChiral, InpFile)
        If numAtoms >= 0 Then
            nNumStruct = nNumStruct + 1
            SetMyStatusLine frm.sMyStatusText, nNumStruct, ""
        End If
        sAllCurOptions = sAllOptions
        If numAtoms > 0 Then
            If bChiral Then
                sAllCurOptions = sAllCurOptions + " /ChiralFlagON"
            Else
                sAllCurOptions = sAllCurOptions + " /ChiralFlagOFF"
            End If
            '--- prepare options string
            ReDim byteOptions(Len(sAllCurOptions) + 1)
            Call CopyMemory(byteOptions(0), ByVal sAllCurOptions, Len(sAllCurOptions)) 'unicode to ASCII
            byteOptions(Len(sAllCurOptions)) = 0  'zero termination
            '--- prepare inInp data structure
            Call ZeroMemory(inInp, Len(inInp))       ' clear
            inInp.num_atoms = numAtoms               ' set number of atoms
            inInp.ptr2inchi_Atom = VarPtr(inAtom(0)) ' pointer to atoms
            inInp.num_stereo0D = 0                   ' no 0D data
            inInp.ptr2inchi_Stereo0D = 0
            inInp.prt2ByteStr_szOptions = VarPtr(byteOptions(0)) 'pointer to options
            
            '****************************
            '******** Get InChI *********
            '****************************
            nRet = GetINCHI(inInp, inOut) 'nRet: 0 = okay, 1 => warning, 2=>error, 3=>fatal
            
            Erase inAtom  ' free memory allocated for the input structure
            inInp.ptr2inchi_Atom = 0
            inInp.num_atoms = 0
            
            If Not IsEmpty(byteOptions) Then
                Erase byteOptions 'free options
                inInp.prt2ByteStr_szOptions = 0
            End If
            
            'initialize InChI output strings
            sMessage = ""
            sInChI = ""
            sAuxInfo = ""
            ' initialize other output strings
            sInchiHdr = ""
            sLogfileString = ""
            
            '*****************************************************
            '***** extract information from InChI dll output *****
            '*****************************************************
            
            bError = (nRet <> 0 And nRet <> 1)

            '-- get InChI options from the logfile string only once per run
            If sFirstLogInfo = "" Then
                ' convert InChI C-string to VB String sFirstLogInfo
                lgt = CopyCStringPtrToString(sFirstLogInfo, inOut.ptr2ByteStr_szLog, 1)
            End If
            
            ' InChI current structure-specific message
            ' convert InChI C-string to VB String sMessage
            lgt = CopyCStringPtrToString(sMessage, inOut.ptr2ByteStr_szMessage, 0)
            'make sure the message is displayed
            If lgt > 0 And nRet = 0 Then
                nRet2 = 1 'set warning flag if InChI message is not accompanied by Warn ret code
            Else
                nRet2 = nRet
            End If
            
            '==== extract InChI =====
            If Not bError Then
                ' InChI Identifier
                ' convert InChI C-string to VB String sInChI
                lgt = CopyCStringPtrToString(sInChI, inOut.ptr2ByteStr_szInChI, 0)
                If lgt > 0 Then
                    ' InChI Auxiliary Information
                    ' convert InChI AuxInfo C-string to VB String sAuxInfo
                    lgt = CopyCStringPtrToString(sAuxInfo, inOut.ptr2ByteStr_szAuxInfo, 0)
                Else
                    bError = True
                End If
            Else
                bError = True
            End If
            '***********************************************************
            '******** Release memory allocated by InChI dll ************
            '***********************************************************
            Call FreeINCHI(inOut)
        Else
            bError = True
            nRet2 = 2
        End If
        
        '****************************
        '*******   output   *********
        '****************************
        
        If sFirstLogInfo <> "" And bFirstStructure Then
            '----- Options recognized by InChI => log file, text window
            AddLineToTextWindow frm.sOutputWindowText, vbCrLf + sFirstLogInfo + vbCrLf + vbCrLf
            Print #LogFile, sFirstLogInfo
            Print #LogFile,
            bFirstStructure = False
        End If
        
        
        If bError Then
            '------ Error message, no InChI
            If numAtoms = 0 Then
                sLogfileString = "Empty structure"
                Call MakeInchiLogfileString(sLogfileString, 2, nNumStruct, bOptions.sHeader, sLabel)
                'Call AddInchiTitleString(sLogfileString, nNumStruct, bOptions.sHeader, sLabel)
                Print #LogFile, sLogfileString
                AddLineToTextWindow frm.sOutputWindowText, sLogfileString + vbCrLf
                nErr = nErr + 1
                ' empty input structure
            ElseIf numAtoms = -1 Then
                AddLineToTextWindow frm.sOutputWindowText, "End of file detected after structure" + Str(nNumStruct) + vbCrLf
                Exit Do
                ' end of input file
            ElseIf numAtoms < 0 Then
                AddLineToTextWindow frm.sOutputWindowText, "Error reading structure" + Str(nNumStruct) + vbCrLf
                nErr = nErr + 1 'structure read error
            Else
                sInchiHdr = sMessage
                Call MakeInchiLogfileString(sInchiHdr, nRet2, nNumStruct, bOptions.sHeader, sLabel)
                'Call AddInchiTitleString(sInchiHdr, nNumStruct, bOptions.sHeader, sLabel)
                AddLineToTextWindow frm.sOutputWindowText, sInchiHdr + vbCrLf
                Print #LogFile, sInchiHdr
                nErr = nErr + 1 'InChI dll returned error
            End If
            If bOptions.bDisplayInchi Then
                AddLineToTextWindow frm.sOutputWindowText, vbCrLf
            End If
        Else
            '----- Success: output InChI
            '----- InChI header, InChI Identifier, InChI Aux info => output file
            sInchiHdr = ""
            'Call MakeInchiLogfileString(sInchiHdr, nRet, nNumStruct, bOptions.sHeader, sLabel)
            Call AddInchiTitleString(sInchiHdr, nNumStruct, bOptions.sHeader, sLabel)
            Print #OutFile, sInchiHdr  'line #1: header
            Print #OutFile, sInChI     'line #2: INChi
            If sAuxInfo <> "" Then
                Print #OutFile, sAuxInfo 'line #3: AuxInfo (if present)
            End If
            Print #OutFile, 'line #4: blank line for reading
            
            '----- InChI message => log file, text window
            If sMessage <> "" Then
                sLogfileString = sMessage
                Call MakeInchiLogfileString(sLogfileString, nRet2, nNumStruct, bOptions.sHeader, sLabel)
                'Call AddInchiTitleString(sLogfileString, nNumStruct, bOptions.sHeader, sLabel)
                Print #LogFile, sLogfileString
                If Not bOptions.bDisplayInchi Then
                    AddLineToTextWindow frm.sOutputWindowText, sLogfileString + vbCrLf
                End If
            End If
            
            '---- Display InChI if requested
            If bOptions.bDisplayInchi Then
                'display header if there was no InChI message
                If sMessage = "" Then
                    sInchiHdr = ""
                    Call AddInchiTitleString(sInchiHdr, nNumStruct, bOptions.sHeader, sLabel)
                    AddLineToTextWindow frm.sOutputWindowText, sInchiHdr + vbCrLf
                End If
                'Identifier
                AddLineToTextWindow frm.sOutputWindowText, sInChI + vbCrLf
                'Aux Info
                If sAuxInfo <> "" Then
                    AddLineToTextWindow frm.sOutputWindowText, sAuxInfo + vbCrLf
                End If
                AddLineToTextWindow frm.sOutputWindowText, vbCrLf
            End If
        End If
       
        'frm.Refresh ' this does not let the menu messages be processed
        PumpInchiMessages frm.hwnd 'Update window AND process menu messages

    Loop While 0 <= nRet And nRet < 3 And bRunInChI
    
    '''''''''''''''''''''''''''''''
    '
    '  The Main cycle ends here
    '
    '''''''''''''''''''''''''''''''
        
    If Not bRunInChI And Not EOF(InpFile) Then
        AddLineToTextWindow frm.sOutputWindowText, vbCrLf + "==== Aborted by user ====" + vbCrLf + vbCrLf
        Print #LogFile,
        Print #LogFile, "==== Aborted by user ===="
        Print #LogFile,
    End If
        
    Print #LogFile, "Processed" + w(nNumStruct, "structure") + "," + w(nErr, "error")
    
    Close #InpFile
    Close #OutFile
    Close #LogFile
    
    '---- final output to the text window ---
    AddLineToTextWindow frm.sOutputWindowText, vbCrLf + "Processed" + w(nNumStruct, "structure") + "," + w(nErr, "error") + vbCrLf + vbCrLf
    AddLineToTextWindow frm.sOutputWindowText, "Closed Input file: " + q(bOptions.sInputFile) + vbCrLf
    AddLineToTextWindow frm.sOutputWindowText, "Closed Output file: " + q(bOptions.sInputFile + ".txt") + vbCrLf
    AddLineToTextWindow frm.sOutputWindowText, "Closed Log file: " + q(bOptions.sInputFile + ".log") + vbCrLf
    '---- status line output --------
    SetMyStatusLine frm.sMyStatusText, 0, "Processed" + w(nNumStruct, "structure") + "," + w(nErr, "error")

    Erase inAtom
    If Not IsEmpty(byteOptions) Then
        Erase byteOptions
    End If
    
    bRunInChI = False
    
End Sub

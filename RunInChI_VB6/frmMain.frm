VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Begin VB.Form frmMain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "RunINCHI"
   ClientHeight    =   7125
   ClientLeft      =   150
   ClientTop       =   720
   ClientWidth     =   7350
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   29.688
   ScaleMode       =   4  'Character
   ScaleWidth      =   61.25
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox sMyStatusText 
      BackColor       =   &H8000000F&
      Height          =   285
      Left            =   120
      Locked          =   -1  'True
      TabIndex        =   1
      Text            =   "Input file not specified"
      Top             =   6720
      Width           =   6852
   End
   Begin VB.TextBox sOutputWindowText 
      Height          =   6732
      Left            =   120
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      Text            =   "frmMain.frx":0442
      Top             =   0
      Width           =   7092
   End
   Begin MSComDlg.CommonDialog dlgCommonDialog 
      Left            =   9600
      Top             =   120
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuFileOpen 
         Caption         =   "&Open..."
      End
      Begin VB.Menu mnuSep 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFileMRUItem 
         Caption         =   "1"
         Index           =   1
         Visible         =   0   'False
      End
      Begin VB.Menu mnuFileMRUItem 
         Caption         =   "2"
         Index           =   2
         Visible         =   0   'False
      End
      Begin VB.Menu mnuFileMRUItem 
         Caption         =   "3"
         Index           =   3
         Visible         =   0   'False
      End
      Begin VB.Menu mnuFileMRUItem 
         Caption         =   "4"
         Index           =   4
         Visible         =   0   'False
      End
      Begin VB.Menu mnuFileMRUItem 
         Caption         =   "5"
         Index           =   5
         Visible         =   0   'False
      End
      Begin VB.Menu mnuFileMRUItem 
         Caption         =   "6"
         Index           =   6
         Visible         =   0   'False
      End
      Begin VB.Menu mnuFileMRUItem 
         Caption         =   "7"
         Index           =   7
         Visible         =   0   'False
      End
      Begin VB.Menu mnuFileMRUItem 
         Caption         =   "8"
         Index           =   8
         Visible         =   0   'False
      End
      Begin VB.Menu mnuFileMRUItem 
         Caption         =   "9"
         Index           =   9
         Visible         =   0   'False
      End
      Begin VB.Menu mnuFileMRUSep 
         Caption         =   "-"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuFileExit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuOptions 
      Caption         =   "&Options"
   End
   Begin VB.Menu mnuRun 
      Caption         =   "&Run"
   End
   Begin VB.Menu mnuStop 
      Caption         =   "&Stop"
   End
   Begin VB.Menu mnuAbout 
      Caption         =   "&About"
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'============ The MRU list ===========================
' from http://www.vb-helper.com/vbcl_sample_text.html
'=====================================================
Private MRUName As Collection
Private MRUTitle As Collection
Private Const MaxMRU = 9
' load the form
Private Sub Form_Load()
    Me.Left = GetSetting(App.Title, "Settings", "MainLeft", 100)
    Me.Top = GetSetting(App.Title, "Settings", "MainTop", 100)
    Me.Width = GetSetting(App.Title, "Settings", "MainWidth", 7416)
    Me.Height = GetSetting(App.Title, "Settings", "MainHeight", 7704)
    Me.sOutputWindowText.Text = Me.sOutputWindowText.Text + OutputDelimiter
    LoadMRUList
    Me.mnuStop.Enabled = False
End Sub
' Defer exit from the app if InChI is running
Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    If bRunInChI Then
        bRunInChI = False  'Request stop calling InChI dll
        Cancel = 1         'Prevent immediate application closing
        bCloseApp = True   'Request app termination after InChI has stopped
    End If
End Sub
' unload the form
Private Sub Form_Unload(Cancel As Integer)
    Dim i As Integer
    'close all sub forms
    For i = Forms.Count - 1 To 1 Step -1
        Unload Forms(i)
    Next
    If Me.WindowState <> vbMinimized Then
        SaveSetting App.Title, "Settings", "MainLeft", Me.Left
        SaveSetting App.Title, "Settings", "MainTop", Me.Top
        SaveSetting App.Title, "Settings", "MainWidth", Me.Width
        SaveSetting App.Title, "Settings", "MainHeight", Me.Height
    End If
End Sub
Private Sub mnuAbout_Click()
    frmAbout.Show vbModal, Me
End Sub
Private Sub mnuFileExit_Click()
    'unload the form
     Unload Me
End Sub
'Get file name from MRU list
Private Sub mnuFileMRUItem_Click(Index As Integer)
    If 1 <= Index And Index <= MRUName.Count Then
        bOptions.sInputFile = MRUName(Index)
        If DisplayInpFileName(Me) Then
            SaveFileName bOptions.sInputFile, Dir(bOptions.sInputFile, vbReadOnly)
        End If
    End If
End Sub
Private Sub mnuFileOpen_Click()
    Dim sFile As String
    With dlgCommonDialog
        .DialogTitle = "Open Input Structure File"
        .CancelError = False
        'ToDo: set the flags and attributes of the common dialog control
        .Filter = "Structure Files (*.mol;*.sdf)|*.mol;*.sdf"
        .ShowOpen
        If Len(.FileName) = 0 Then
            Exit Sub
        End If
        sFile = .FileName
    End With
    ' save file name
    bOptions.sInputFile = sFile
    If DisplayInpFileName(Me) Then
        SaveFileName bOptions.sInputFile, Dir(bOptions.sInputFile, vbReadOnly)
    End If
End Sub
Private Sub EnableMenu(bEnable As Boolean)
    Me.mnuFile.Enabled = bEnable
    Me.mnuOptions = bEnable
    Me.mnuRun.Enabled = bEnable
    Me.mnuAbout.Enabled = bEnable
    '--- opposite value ----
    Me.mnuStop.Enabled = Not bEnable
End Sub
Private Sub mnuRun_Click()
    EnableMenu False 'disable all menu items, enable Stop
    bRunInChI = True
    Call Struct2InChI(Me)
    EnableMenu True  'enble all menu items, disable Stop
    If bCloseApp Then
        'initiate closing the application
        PostMessage Me.hwnd, WM_CLOSE, 0, 0
    End If
End Sub
Private Sub mnuOptions_Click()
    DisplayInpFileName Me
    dlgOptions.Show vbModal, Me
End Sub
'============ The MRU list ===========================
' from http://www.vb-helper.com/vbcl_sample_text.html
'=====================================================
' Load the MRU list.
Private Sub LoadMRUList()
    Dim i As Integer
    Dim file_title As String
    Dim file_name As String
    ' Load the saved entries.
    Set MRUName = New Collection
    Set MRUTitle = New Collection
    For i = 1 To MaxMRU
        file_name = GetSetting(App.Title, "MRUList", "Name" & Format$(i), "")
        If Len(file_name) > 0 Then
            file_title = GetSetting(App.Title, "MRUList", "Title" & Format$(i), "")
            MRUTitle.Add file_title
            MRUName.Add file_name
        End If
    Next i
    ' Display the MRU items.
    DisplayMRUList
End Sub
' Display the MRU list.
Private Sub DisplayMRUList()
    Dim i As Integer
    ' Load the used entries.
    For i = 1 To MaxMRU
        If i > MRUName.Count Then Exit For
        mnuFileMRUItem(i).Caption = "&" & Format$(i) & " " & MRUTitle(i)
        mnuFileMRUItem(i).Visible = True
    Next i
    ' Hide unneeded entries.
    For i = MRUName.Count + 1 To MaxMRU
        mnuFileMRUItem(i).Visible = False
    Next i
    ' Show the separator if necessary.
    mnuFileMRUSep.Visible = (MRUName.Count > 0)
End Sub
' Save the file name and title. Update the MRU list.
Private Sub SaveFileName(ByVal fname As String, ByVal ftitle As String)
Dim i As Integer
    'FileTitle = ftitle
    'FileName = fname
    ' See if the file is already in the MRU list.
    For i = 1 To MaxMRU
        If i > MRUName.Count Then Exit For
        If LCase$(MRUName(i)) = LCase$(fname) Then
            ' It is here. Remove it.
            MRUName.Remove i
            MRUTitle.Remove i
            Exit For
        End If
    Next i
    ' Add the file at the top of the list.
    If MRUName.Count > 0 Then
        MRUName.Add fname, , 1
        MRUTitle.Add ftitle, , 1
    Else
        MRUName.Add fname
        MRUTitle.Add ftitle
    End If
    ' If there are more than 4 files in the
    ' collections, remove the last one.
    If MRUName.Count > MaxMRU Then
        MRUName.Remove MaxMRU + 1
        MRUTitle.Remove MaxMRU + 1
    End If
    ' Save the modified MRU list.
    For i = 1 To MaxMRU
        If i > MRUName.Count Then
            fname = ""
            ftitle = ""
        Else
            fname = MRUName(i)
            ftitle = MRUTitle(i)
        End If
        SaveSetting App.Title, "MRUList", "Name" & Format$(i), fname
        SaveSetting App.Title, "MRUList", "Title" & Format$(i), ftitle
    Next i
    ' Redisplay the MRU items.
    DisplayMRUList
End Sub
Private Sub mnuStop_Click()
    bRunInChI = False
End Sub


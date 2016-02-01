VERSION 5.00
Begin VB.Form dlgOptions 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "InChI Options"
   ClientHeight    =   6030
   ClientLeft      =   4680
   ClientTop       =   4740
   ClientWidth     =   6015
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6030
   ScaleWidth      =   6015
   ShowInTaskbar   =   0   'False
   Begin VB.CheckBox chkDisplayINChI 
      Caption         =   "Display InChI"
      Height          =   855
      Left            =   4560
      TabIndex        =   17
      Top             =   4920
      Width           =   1335
   End
   Begin VB.CheckBox chkNoAggrDeprot 
      Caption         =   "Disable Aggressive (De)protonation"
      Height          =   255
      Left            =   360
      TabIndex        =   16
      Top             =   3600
      Width           =   3255
   End
   Begin VB.CheckBox chkBonds2Metal 
      Caption         =   "Include bonds to Metal"
      Height          =   255
      Left            =   360
      TabIndex        =   15
      Top             =   2640
      Width           =   2655
   End
   Begin VB.Frame fraSample1 
      Caption         =   "Stereo"
      Height          =   1785
      Left            =   240
      TabIndex        =   9
      Tag             =   "Sample 1"
      Top             =   720
      Width           =   3960
      Begin VB.OptionButton rbStereoType 
         Caption         =   "Use Molfile Chiral Flag"
         Height          =   375
         Index           =   4
         Left            =   120
         TabIndex        =   18
         Top             =   960
         Width           =   2055
      End
      Begin VB.OptionButton rbStereoType 
         Caption         =   "Absolute"
         Height          =   375
         Index           =   1
         Left            =   120
         TabIndex        =   14
         Top             =   240
         Width           =   1095
      End
      Begin VB.OptionButton rbStereoType 
         Caption         =   "Relative"
         Height          =   375
         Index           =   2
         Left            =   120
         TabIndex        =   13
         Top             =   600
         Width           =   1095
      End
      Begin VB.OptionButton rbStereoType 
         Caption         =   "Racemic"
         Height          =   375
         Index           =   3
         Left            =   1320
         TabIndex        =   12
         Top             =   240
         Width           =   1095
      End
      Begin VB.OptionButton rbStereoType 
         Caption         =   "None"
         Height          =   255
         Index           =   0
         Left            =   1320
         TabIndex        =   11
         Top             =   600
         Width           =   975
      End
      Begin VB.CheckBox chkNarrowEnd2SC 
         Caption         =   "Narrow end of wedge points to stereoicenter"
         Height          =   255
         Left            =   120
         TabIndex        =   10
         Top             =   1440
         Width           =   3735
      End
   End
   Begin VB.CheckBox chkMobileH 
      Caption         =   "Mobile H Perception"
      Height          =   375
      Left            =   360
      TabIndex        =   8
      Top             =   360
      Width           =   1935
   End
   Begin VB.Frame Frame2 
      Caption         =   "Normalization Testing Only"
      Height          =   855
      Left            =   120
      TabIndex        =   7
      Top             =   3240
      Width           =   4335
   End
   Begin VB.Frame Frame1 
      Caption         =   "Structure Options"
      Height          =   2895
      Left            =   120
      TabIndex        =   6
      Top             =   120
      Width           =   4335
   End
   Begin VB.Frame Frame3 
      Caption         =   "Other Options"
      Height          =   735
      Left            =   120
      TabIndex        =   4
      Top             =   5040
      Width           =   4335
      Begin VB.TextBox sOtherOptions 
         Height          =   375
         Left            =   120
         MaxLength       =   256
         TabIndex        =   5
         Top             =   240
         Width           =   3975
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "SDfile Header"
      Height          =   735
      Left            =   120
      TabIndex        =   2
      Top             =   4200
      Width           =   4335
      Begin VB.TextBox sSDfileHeader 
         Height          =   375
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   3975
      End
   End
   Begin VB.CommandButton CancelButton 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   375
      Left            =   4680
      TabIndex        =   1
      Top             =   600
      Width           =   1215
   End
   Begin VB.CommandButton OKButton 
      Caption         =   "OK"
      Height          =   375
      Left            =   4680
      TabIndex        =   0
      Top             =   120
      Width           =   1215
   End
End
Attribute VB_Name = "dlgOptions"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Sub CancelButton_Click()
    Unload Me
End Sub


Private Sub Form_Load()
    SetOptionsControls
End Sub

Private Sub OKButton_Click()
    SaveSelectedOptions
    Unload Me
End Sub
Private Sub SetOptionsControls()
    Dim i As Integer, j As Integer
    If bOptions.bFixedH = 1 Then chkMobileH.Value = 0 Else chkMobileH.Value = 1
    chkNarrowEnd2SC.Value = bOptions.bNarrowEowPoints2SC
    chkBonds2Metal.Value = bOptions.bIncBondsToMetal
    chkNoAggrDeprot.Value = bOptions.bDisableAggrDeprot
    sOtherOptions.Text = bOptions.sOtherOpt
    sSDfileHeader.Text = bOptions.sHeader
    chkDisplayINChI = bOptions.bDisplayInchi
        '--- Stereo ---
    i = bOptions.nStereoMode
    For j = 0 To inchi_StereoLast
        If rbStereoType.Item(i).Index = i Then
            rbStereoType.Item(i).Value = True
        Else
            rbStereoType.Item(i).Value = False
        End If
    Next
End Sub

Private Sub SaveSelectedOptions()
    Dim i As Integer
    bOptions.sOtherOpt = sOtherOptions.Text
    bOptions.sHeader = sSDfileHeader.Text
    If chkMobileH.Value = 1 Then bOptions.bFixedH = 0 Else bOptions.bFixedH = 1
    bOptions.bNarrowEowPoints2SC = chkNarrowEnd2SC.Value
    bOptions.bDisableAggrDeprot = chkNoAggrDeprot.Value
    bOptions.bIncBondsToMetal = chkBonds2Metal.Value
    bOptions.bDisplayInchi = chkDisplayINChI
    For i = 0 To inchi_StereoLast
        If rbStereoType.Item(i).Value = True Then
            bOptions.nStereoMode = rbStereoType.Item(i).Index
        End If
    Next i
    
End Sub


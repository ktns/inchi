VERSION 5.00
Begin VB.Form frmAbout 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "About RunInChI"
   ClientHeight    =   3624
   ClientLeft      =   4512
   ClientTop       =   4908
   ClientWidth     =   5868
   ClipControls    =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3624
   ScaleWidth      =   5868
   ShowInTaskbar   =   0   'False
   Tag             =   "About RunINChI"
   Begin VB.PictureBox picIcon 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      ClipControls    =   0   'False
      Height          =   432
      Left            =   120
      Picture         =   "frmAbout.frx":0000
      ScaleHeight     =   374.634
      ScaleMode       =   0  'User
      ScaleWidth      =   374.634
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   120
      Width           =   432
   End
   Begin VB.CommandButton cmdOK 
      Cancel          =   -1  'True
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   345
      Left            =   4245
      TabIndex        =   0
      Tag             =   "OK"
      Top             =   2625
      Width           =   1467
   End
   Begin VB.Label lblTitle 
      Caption         =   "MS Visual Basic 6.0 Example of using InChI API in InChI  DLL"
      ForeColor       =   &H00000000&
      Height          =   480
      Left            =   810
      TabIndex        =   4
      Tag             =   "Application Title"
      Top             =   240
      Width           =   4815
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00808080&
      BorderStyle     =   6  'Inside Solid
      Index           =   1
      X1              =   240
      X2              =   5672
      Y1              =   1680
      Y2              =   1680
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   0
      X1              =   240
      X2              =   5657
      Y1              =   1680
      Y2              =   1680
   End
   Begin VB.Label lblVersion 
      Caption         =   "Includes InChI Version 1 libinchi.DLL"
      Height          =   225
      Left            =   720
      TabIndex        =   3
      Tag             =   "Version"
      Top             =   840
      Width           =   4095
   End
   Begin VB.Label lblDisclaimer 
      Caption         =   $"frmAbout.frx":0442
      ForeColor       =   &H00000000&
      Height          =   1305
      Left            =   255
      TabIndex        =   2
      Tag             =   "Warning: ..."
      Top             =   2025
      Width           =   3630
   End
End
Attribute VB_Name = "frmAbout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    'lblVersion.Caption = "Version " & App.Major & "." & App.Minor & "." & App.Revision
    'lblTitle.Caption = App.Title
End Sub

Private Sub cmdOK_Click()
        Unload Me
End Sub


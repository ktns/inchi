Attribute VB_Name = "Module1"
Public fMainForm As frmMain


Sub Main()
    SetDefaultOptions
    Set fMainForm = New frmMain
    bRunInChI = False
    bCloseApp = False
    fMainForm.Show
End Sub

Attribute VB_Name = "Module3"
Option Explicit
Option Base 0

' save VB String to byte array
Function StrToByteArray(ByRef b() As Byte, blen As Long, s As String) As Long
    Dim n As Long, i As Long
    StrToByteArray = 0
    n = Len(s)
    If n >= blen Then
        n = blen - 1 'max number of bytes to transfer
        StrToByteArray = (StrToByteArray Or 1) 'too long string
    End If
    If n > 0 Then
        Call CopyMemory(b(0), ByVal s, n) 'autoconvert Unicode->ASCII & copy
        Call ZeroMemory(b(n), blen - n) 'add zero termination
    Else
        StrToByteArray = (StrToByteArray Or 2) 'empty string flag
        If blen > 0 Then
            Call ZeroMemory(b(0), blen) 'zero termination
        End If
    End If
End Function

Function nIntVal(sValue As String, start As Long, lgth As Long) As Integer
    Dim i As Integer, ls As Integer, first As Integer, last As Integer
    ls = Len(sValue)
    If start > ls Then
        nIntVal = 0
        Exit Function
    End If
    If lgth > ls - start + 1 Then
        last = ls
    Else
        last = start + lgth - 1
    End If
    
    first = 0
    For i = start To last
        If Mid(sValue, i, 1) = "-" Or "0" <= Mid(sValue, i, 1) And Mid(sValue, i, 1) <= "9" Then
            first = i
            Exit For
        End If
    Next i
    If first > 0 Then
        nIntVal = Val(Trim(Mid(sValue, first, last - first + 1)))
    Else
        nIntVal = 0
    End If
End Function
Function nDbleVal(s As String, start As Long, lgth As Long) As Double
    Dim i As Integer, ls As Integer, first As Integer, last As Integer
    ls = Len(s)
    If start > ls Then
        nDbleVal = 0
        Exit Function
    End If
    If lgth > ls - start + 1 Then
        last = ls
    Else
        last = start + lgth - 1
    End If
    
    first = 0
    For i = start To last
        If Mid(s, i, 1) = "-" Or "0" <= Mid(s, i, 1) And Mid(s, i, 1) <= "9" Then
            first = i
            Exit For
        End If
    Next i
    If first > 0 Then
        nDbleVal = Val(Trim(Mid(s, first, last - first + 1)))
    Else
        nDbleVal = 0
    End If
End Function
Function Int2Byte(i As Integer) As Byte
    If i >= 0 Then
        Int2Byte = i
    Else
        Int2Byte = 256 + i
    End If
End Function
Sub SetRadicals(ByRef inAtom() As inchi_Atom, ByVal num_atoms As Integer, _
                     ByVal s As String, ByRef fst_chg_rad As Integer)
    Dim i As Integer, a As Integer, r As Integer, num_data As Integer
    Dim atom(8) As Integer, radical(8) As Integer
    
    If fst_chg_rad > 0 Then
        For i = 0 To num_atoms - 1
            inAtom(i).charge = 0
            inAtom(i).radical = 0
        Next i
        fst_chg_rad = 0
    End If
    num_data = nIntVal(s, 7, 3)
    For i = 0 To num_data - 1
        atom(i) = nIntVal(s, 10 + 8 * i + 1, 3)
        radical(i) = nIntVal(s, 10 + 8 * i + 5, 3)
    Next i
    For i = 0 To num_data - 1
        a = atom(i) - 1
        r = radical(i) '1=singlet, 2=doublet, 3=triplet
        If r = 1 Then r = 3 'InChI should treat singlet (additional lone pair) as a triplet which reduces numH by 2
        inAtom(a).radical = Int2Byte(r)
    Next i
End Sub
Sub SetCharges(ByRef inAtom() As inchi_Atom, ByVal num_atoms As Integer, _
                     ByVal s As String, ByRef fst_chg_rad As Integer)
    Dim i As Integer, a As Integer, c As Integer, num_data As Integer
    Dim atom(8) As Integer, charge(8) As Integer
    
    If fst_chg_rad > 0 Then
        For i = 0 To num_atoms - 1
            inAtom(i).charge = 0
            inAtom(i).radical = 0
        Next i
        fst_chg_rad = 0
    End If
    num_data = nIntVal(s, 7, 3)
    For i = 0 To num_data - 1
        atom(i) = nIntVal(s, 10 + 8 * i + 1, 3)
        charge(i) = nIntVal(s, 10 + 8 * i + 5, 3)
    Next i
    For i = 0 To num_data - 1
        a = atom(i) - 1
        c = charge(i)
        inAtom(a).charge = Int2Byte(c)
    Next i
End Sub
Sub SetIsotopes(ByRef inAtom() As inchi_Atom, ByVal num_atoms As Integer, _
                     ByVal s As String, ByRef fst_iso As Integer)
    Dim i As Integer, a As Integer, c As Integer, num_data As Integer
    Dim atom(8) As Integer, iso(8) As Integer
    
    If fst_iso > 0 Then
        For i = 0 To num_atoms - 1
            inAtom(i).isotopic_mass = 0
        Next i
        fst_iso = 0
    End If
    num_data = nIntVal(s, 7, 3)
    For i = 0 To num_data - 1
        atom(i) = nIntVal(s, 10 + 8 * i + 1, 3)
        iso(i) = nIntVal(s, 10 + 8 * i + 5, 3)
    Next i
    For i = 0 To num_data - 1
        a = atom(i) - 1
        c = iso(i)
        inAtom(a).isotopic_mass = c
    Next i
End Sub
Function ReadStructure(ByRef inAtom() As inchi_Atom, strHeader As String, _
                       ByRef strLabel As String, ByRef bChiral As Integer, f As Integer) As Integer
    Dim stage As Integer, i As Integer
    Dim nNumAtomsInStruct As Integer, nNumBondsInStruct As Integer, nNumBondsInAtom As Integer
    Dim nNumStext As Integer, nNumPropertyLines As Integer
    Dim a1 As Integer, a2 As Integer, nBondType As Integer, nBondStereo As Integer
    Dim bFirstChargeOrRadical As Integer, bFirstIsotopic As Integer, numH As Integer
    Dim bHeaderFound As Integer
    Dim nRet As Long
    Dim charge As Integer, nBondsValence As Integer, nNumAltBonds As Integer
    Dim sCurHeader As String, sCurLabel As String
        
    Dim s As String, el As String
    Dim Valence() As Integer
    
    If EOF(f) Then
        ReadStructure = -1
        Exit Function
    End If
    
    stage = 1
    nNumAtomsInStruct = 0
    nNumBondsInStruct = 0
    nNumStext = 0
    nNumPropertyLines = 0
    bFirstChargeOrRadical = 1
    bFirstIsotopic = 1
    bHeaderFound = 0
    strLabel = ""
    bChiral = 0
    '==== main cycle ======
    Do While Not EOF(f)
        
        Line Input #f, s
        If RTrim$(s) = "$$$$" Then
            Exit Do
        End If
        
        Select Case stage
        Case 1 'read Molfile first line
            stage = 2 'ignore Name
        Case 2 'read Molfile 2nd line
            stage = 3 'ignore 2nd line
        Case 3
            stage = 4 'ignore Comment
        Case 4 'read counts line
            nNumAtomsInStruct = nIntVal(s, 1, 3)
            nNumBondsInStruct = nIntVal(s, 4, 3)
            bChiral = nIntVal(s, 13, 3)
            nNumStext = nIntVal(s, 16, 3)
            nNumPropertyLines = nIntVal(s, 31, 3)
            If nNumAtomsInStruct > 0 Then
                ReDim inAtom(nNumAtomsInStruct + 1)
                ReDim Valence(nNumAtomsInStruct + 1)
            End If
            i = 0
            If nNumAtomsInStruct > 0 Then
                stage = 5
                i = 0
            Else
                stage = 88 'switch to SData
            End If
        Case 5 'read atoms block
            inAtom(i).x = nDbleVal(s, 1, 10)
            inAtom(i).y = nDbleVal(s, 11, 20)
            inAtom(i).z = nDbleVal(s, 21, 30)
            el = Trim(Mid(s, 32, 3))
            If Len(el) = 2 Then
                If "A" <= Mid(el, 2, 1) And Mid(el, 2, 1) <= "Z" Then
                    Mid(el, 2, 1) = Chr$(Asc(Mid(el, 2, 1)) - (Asc("a") - Asc("A")))
                End If
            End If
            nRet = StrToByteArray(inAtom(i).elname, ATOM_EL_LEN, el)
            a1 = nIntVal(s, 35, 2)
            If a1 <> 0 Then
                inAtom(i).isotopic_mass = a1 + ISOTOPIC_SHIFT_FLAG
            End If
            charge = nIntVal(s, 37, 3)
            If charge = 4 Then
                inAtom(i).radical = 2 'doublet
            ElseIf charge <> 0 Then
                inAtom(i).charge = Int2Byte(4 - charge) 'charge
            End If
            Valence(i) = nIntVal(s, 49, 3)
            i = i + 1
            If i >= nNumAtomsInStruct Then
                If nNumBondsInStruct > 0 Then
                    stage = 6 'switch to reading bonds
                    i = 0
                ElseIf nNumStext > 0 Then
                    stage = 7 'switch to stext
                    i = 0
                ElseIf nNumPropertyLines > 0 Then
                    stage = 8 'switch to property lines
                    i = 0
                Else
                    stage = 88 'switch to SData
                    i = 0
                End If
            End If
        Case 6  'read bonds block
            a1 = nIntVal(s, 1, 3) - 1
            a2 = nIntVal(s, 4, 3) - 1
            If 0 <= a1 And a1 < nNumAtomsInStruct And 0 <= a2 And a2 < nNumAtomsInStruct Then
                ' in this simplified code we do not check duplicated bonds
                nBondType = nIntVal(s, 7, 3)
                nBondStereo = nIntVal(s, 10, 3)
                
                nNumBondsInAtom = inAtom(a1).num_bonds
                inAtom(a1).neighbor(nNumBondsInAtom) = a2
                inAtom(a1).bond_type(nNumBondsInAtom) = Int2Byte(nBondType)
                inAtom(a1).bond_stereo(nNumBondsInAtom) = Int2Byte(nBondStereo)
                nNumBondsInAtom = nNumBondsInAtom + 1
                inAtom(a1).num_bonds = nNumBondsInAtom
                
                If nBondStereo = 1 Or nBondStereo = 4 Or nBondStereo = 6 Then
                    nBondStereo = -nBondStereo
                End If
                
                nNumBondsInAtom = inAtom(a2).num_bonds
                inAtom(a2).neighbor(nNumBondsInAtom) = a1
                inAtom(a2).bond_type(nNumBondsInAtom) = Int2Byte(nBondType)
                inAtom(a2).bond_stereo(nNumBondsInAtom) = Int2Byte(nBondStereo)
                nNumBondsInAtom = nNumBondsInAtom + 1
                inAtom(a2).num_bonds = nNumBondsInAtom
            End If
            
            i = i + 1
            If i >= nNumBondsInStruct Then
                If nNumStext > 0 Then
                    stage = 7 'switch to stext
                    i = 0
                ElseIf nNumPropertyLines > 0 Then
                    stage = 8 'switch to property lines
                    i = 0
                Else
                    stage = 88 'switch to SData
                    i = 0
                End If
            End If
        Case 7  'read stext and ignore it
            i = i + 1
            If i >= 2 * nNumStext Then
                If nNumPropertyLines > 0 Then
                    stage = 8 'switch to property lines
                    i = 0
                Else
                    stage = 88 'switch to SData
                    i = 0
                End If
            End If
        Case 8  'read property lines
            If Len(s) > 3 And Mid(s, 2, 2) = "  " Then
                Select Case Left(s, 1)
                Case "M"
                    Select Case Trim(Mid(s, 4, 3))
                    Case "END"
                        stage = 88 'switch to SData
                    Case "CHG"
                        Call SetCharges(inAtom, nNumAtomsInStruct, s, bFirstChargeOrRadical)
                    Case "RAD"
                        Call SetRadicals(inAtom, nNumAtomsInStruct, s, bFirstChargeOrRadical)
                    Case "ISO"
                        Call SetIsotopes(inAtom, nNumAtomsInStruct, s, bFirstIsotopic)
                    Case Else
                    End Select
                Case "V" '/* ISIS/Desktop Atom Value: one-line property */
                    'ignore
                Case "G" '/* ISIS/Desktop Group abbreviation: two-line property */
                    If EOF(f) Then Exit Do
                    'bypass the 2nd line
                    Line Input #f, s
                Case "A" '/* Atom Alias [ISIS/Desktop] two-line property */
                    a1 = nIntVal(s, 3, 3) - 1
                    If EOF(f) Then Exit Do
                    Line Input #f, s
                    el = Trim(s)
                    nRet = StrToByteArray(inAtom(i).elname, ATOM_EL_LEN, el)
                Case "S"
                    If Mid(s, 3, 6) = "SKP" Then
                        a1 = nIntVal(s, 7, 3)
                        For a2 = 1 To a1
                            If EOF(f) Then Exit Do
                            Line Input #f, s
                        Next a2
                    End If
                Case Else
                End Select
            Else
            End If
        Case 88: 'Read SData
            'input: sHeader, output: sLabel
            bHeaderFound = 0
            If Left(s, 1) = ">" Then
                'look for: >  <header>
                a1 = InStr(2, s, "<", vbBinaryCompare) 'case sensitive search
                If a1 > 1 Then
                    a1 = a1 + 1
                    a2 = InStr(a1, s, ">", vbBinaryCompare) 'case sensitive search
                    If a2 > a1 Then
                        sCurHeader = Trim(Mid(s, a1, a2 - a1))
                        If Not IsEmpty(sCurHeader) And sCurHeader <> "" And _
                           Not IsEmpty(strHeader) And strHeader <> "" And _
                           0 = StrComp(strHeader, sCurHeader, vbTextCompare) Then
                            bHeaderFound = 3 'found the header we want
                        Else
                            bHeaderFound = 1 'found some other header
                        End If
                    End If
                End If
                If bHeaderFound = 0 And Len(s) > 1 Then
                    'look for: > DTnnn
                    s = LTrim$(Mid(s, 2))
                    If 1 = InStr(s, "DT", vbBinaryCompare) Then
                        bHeaderFound = 1
                    End If
                End If
                
                If bHeaderFound > 0 Then
                    'read the line(s) after the header
                    Do
                        If EOF(f) Then Exit Do
                        Line Input #f, s
                        s = Trim(s)
                        If bHeaderFound = 3 Then
                            If Len(s) > 0 Then
                                strLabel = s
                            End If
                        End If
                        bHeaderFound = 0
                    Loop While Len(s) > 0 And s <> "$$$$"
                End If
            End If
            If s = "$$$$" Then
                Exit Do
            End If
            
        Case 99:
            'looking for "$$$$" line
        Case Else
            Exit Do
        End Select
    Loop
    
    '================== the Molfile has been read ===========
    For i = 0 To nNumAtomsInStruct - 1
        'need to use valences if any to find out number of H
        If Valence(i) > 0 Then
            nBondsValence = 0
            nNumAltBonds = 0
            For a1 = 0 To inAtom(i).num_bonds - 1
                If inAtom(i).bond_type(a1) < 4 Then
                    nBondsValence = nBondsValence + inAtom(i).bond_type(a1)
                Else
                    nNumAltBonds = nNumAltBonds + 1
                End If
            Next a1
            If nNumAltBonds = 2 Then
                nBondsValence = nBondsValence + 3
            ElseIf nNumAltBonds = 3 Then
                nBondsValence = nBondsValence + 4
            ElseIf nNumAltBonds > 0 Then
                'Error: wrong number of aromatic bonds
                'In this simplified code we do not provide any diagnostics
                nBondsValence = nBondsValence + nNumAltBonds
            End If
            'number of H
            If nBondsValence = 0 And Valence(i) = 15 Then
                numH = 0
            Else
                numH = Valence(i) - nBondsValence
                If numH < 0 Then numH = 0
            End If
            inAtom(i).num_iso_H(0) = Int2Byte(numH)
        Else
            inAtom(i).num_iso_H(0) = Int2Byte(-1)
        End If
    Next i
    
    'free memory
    Erase Valence
    ReadStructure = nNumAtomsInStruct
End Function



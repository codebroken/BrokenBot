;==============================================================================================================
;===Get Char=============================================================================================
;--------------------------------------------------------------------------------------------------------------
;Finds pixel color pattern of specific X and Y values, returns char if pixel color pattern found.
;--------------------------------------------------------------------------------------------------------------

Func getChar(ByRef $x, $y)
	Local $width = 0

	;search for 'A'
	$width = 7
	Local $c1 = Hex(0xE7E7E7, 6), $c2 = Hex(0xDBDCDB, 6), $c3 = Hex(0xD5D6D5, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 8, $c1], $pixel2[3] = [$x + 5, $y + 7, $c2], $pixel3[3] = [$x + 6, $y + 8, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "A"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'a'
	$width = 5
	Local $c1 = Hex(0xACAEAC, 6), $c2 = Hex(0xC2C3C2, 6), $c3 = Hex(0xDADBDA, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 5, $y + 3, $c1], $pixel2[3] = [$x + 1, $y + 4, $c2], $pixel3[3] = [$x + 4, $y + 7, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "a"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'B'
	$width = 7
	Local $c1 = Hex(0xE2E3E2, 6), $c2 = Hex(0xFBFBFB, 6), $c3 = Hex(0xE8E9E8, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 6, $y + 1, $c1], $pixel2[3] = [$x + 1, $y + 1, $c2], $pixel3[3] = [$x + 3, $y + 4, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 2) Then
			$x += $width
			Return "B"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'b'
	$width = 6
	Local $c1 = Hex(0x8D8F8D, 6), $c2 = Hex(0xCACBCA, 6), $c3 = Hex(0xFBFBFB, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 3, $y + 4, $c1], $pixel2[3] = [$x + 4, $y + 7, $c2], $pixel3[3] = [$x + 1, $y + 1, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "b"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'C'
	$width = 6
	Local $c1 = Hex(0xE8E8E8, 6), $c2 = Hex(0xC9CAC9, 6), $c3 = Hex(0xDBDBDB, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 1, $c1], $pixel2[3] = [$x + 2, $y + 2, $c2], $pixel3[3] = [$x + 5, $y + 3, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "C"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'c'
	$width = 5
	;Local $c1 = Hex(0x818481, 6), $c2 = Hex(0x949694, 6), $c3 = Hex(0xECEDEC, 6)
	Local $c1 = Hex(0x828481, 6), $c2 = Hex(0x939693, 6), $c3 = Hex(0xEEEEEE, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 3, $y + 2, $c1], $pixel2[3] = [$x + 5, $y + 8, $c2], $pixel3[3] = [$x + 4, $y + 4, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "c"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'c'
	$width = 5
	Local $c1 = Hex(0x818481, 6), $c2 = Hex(0x949694, 6), $c3 = Hex(0xECEDEC, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 3, $y + 2, $c1], $pixel2[3] = [$x + 5, $y + 8, $c2], $pixel3[3] = [$x + 4, $y + 4, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "c"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'D'
	$width = 6
	Local $c1 = Hex(0xACAEAC, 6), $c2 = Hex(0xA0A2A0, 6), $c3 = Hex(0xB6B8B6, 6)
	For $i = 1 To 5
		Local $pixel1[3] = [$x + 3, $y + 7, $c1], $pixel2[3] = [$x + 6, $y + 1, $c2], $pixel3[3] = [$x + 2, $y + 3, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "D"
		Else
			$x += 1
		EndIf
	Next
	$x -= 5

	;search for 'd'
	$width = 6
	Local $c1 = Hex(0x8D8F8D, 6), $c2 = Hex(0xE4E5E4, 6), $c3 = Hex(0xABADAB, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 3, $y + 4, $c1], $pixel2[3] = [$x + 4, $y + 7, $c2], $pixel3[3] = [$x + 1, $y + 3, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "d"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'E'
	$width = 6
	Local $c1 = Hex(0xA5A7A5, 6), $c2 = Hex(0xC3C5C3, 6), $c3 = Hex(0x767976, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 6, $c1], $pixel2[3] = [$x + 2, $y + 2, $c2], $pixel3[3] = [$x + 3, $y + 0, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "E"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'e'
	$width = 6
	Local $c1 = Hex(0x404440, 6), $c2 = Hex(0xF5F5F5, 6), $c3 = Hex(0x7B7D7B, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 2, $c1], $pixel2[3] = [$x + 2, $y + 3, $c2], $pixel3[3] = [$x + 4, $y + 6, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "e"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'F'
	$width = 5
	Local $c1 = Hex(0x515451, 6), $c2 = Hex(0xE1E1E1, 6), $c3 = Hex(0xC6C7C6, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 3, $y + 2, $c1], $pixel2[3] = [$x + 1, $y + 8, $c2], $pixel3[3] = [$x + 5, $y + 1, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "F"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'f'
	$width = 5
	Local $c1 = Hex(0xC4C5C4, 6), $c2 = Hex(0xBFC0BF, 6), $c3 = Hex(0x535653, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 5, $y + 1, $c1], $pixel2[3] = [$x + 2, $y + 4, $c2], $pixel3[3] = [$x + 2, $y + 8, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "f"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'G'
	$width = 6
	Local $c1 = Hex(0x707370, 6), $c2 = Hex(0xC4C5C4, 6), $c3 = Hex(0xD1D2D1, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 4, $y + 4, $c1], $pixel2[3] = [$x + 3, $y + 0, $c2], $pixel3[3] = [$x + 4, $y + 5, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "G"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'g'
	$width = 5
	Local $c1 = Hex(0xD7D8D7, 6), $c2 = Hex(0xF2F2F2, 6), $c3 = Hex(0xE6E7E6, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 9, $c1], $pixel2[3] = [$x + 4, $y + 9, $c2], $pixel3[3] = [$x + 4, $y + 4, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "g"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'H'
	$width = 8
	Local $c1 = Hex(0x5F635F, 6), $c2 = Hex(0x464A46, 6), $c3 = Hex(0xFAFAFA, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 5, $y + 8, $c1], $pixel2[3] = [$x + 3, $y + 3, $c2], $pixel3[3] = [$x + 1, $y + 1, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "H"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'h'
	$width = 6
	Local $c1 = Hex(0x818481, 6), $c2 = Hex(0xD3D4D3, 6), $c3 = Hex(0x646764, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 5, $c1], $pixel2[3] = [$x + 3, $y + 4, $c2], $pixel3[3] = [$x + 5, $y + 3, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "h"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'I'
	$width = 2
	Local $c1 = Hex(0xFEFEFE, 6), $c2 = Hex(0xA3A5A3, 6), $c3 = Hex(0xE1E1E1, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 2, $c1], $pixel2[3] = [$x + 2, $y + 5, $c2], $pixel3[3] = [$x + 1, $y + 8, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "I"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'i'
	$width = 2
	Local $c1 = Hex(0xF0F1F0, 6), $c2 = Hex(0x454945, 6), $c3 = Hex(0xE1E1E1, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 1, $c1], $pixel2[3] = [$x + 1, $y + 2, $c2], $pixel3[3] = [$x + 1, $y + 8, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "i"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'J'
	$width = 6
	Local $c1 = Hex(0x8E908E, 6), $c2 = Hex(0xC4C5C4, 6), $c3 = Hex(0xFBFBFB, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 5, $c1], $pixel2[3] = [$x + 4, $y + 7, $c2], $pixel3[3] = [$x + 6, $y + 1, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "J"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'j'
	$width = 2
	Local $c1 = Hex(0xA0A2A0, 6), $c2 = Hex(0xFDFDFD, 6), $c3 = Hex(0xFEFEFE, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 0, $c1], $pixel2[3] = [$x + 1, $y + 4, $c2], $pixel3[3] = [$x + 1, $y + 9, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "j"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'K'
	$width = 7
	Local $c1 = Hex(0xC7C8C7, 6), $c2 = Hex(0x828482, 6), $c3 = Hex(0x7C7E7C, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 3, $c1], $pixel2[3] = [$x + 3, $y + 6, $c2], $pixel3[3] = [$x + 6, $y + 0, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "K"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'k'
	$width = 5
	Local $c1 = Hex(0xFBFBFB, 6), $c2 = Hex(0x646764, 6), $c3 = Hex(0xDBDCDB, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 1, $c1], $pixel2[3] = [$x + 2, $y + 1, $c2], $pixel3[3] = [$x + 4, $y + 8, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "k"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'L'
	$width = 4
	Local $c1 = Hex(0xFDFDFD, 6), $c2 = Hex(0x828482, 6), $c3 = Hex(0x646764, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 7, $c1], $pixel2[3] = [$x + 4, $y + 7, $c2], $pixel3[3] = [$x + 1, $y + 0, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "L"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'l'
	$width = 2
	Local $c1 = Hex(0xFEFEFE, 6), $c2 = Hex(0x909290, 6), $c3 = Hex(0xFEFEFE, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 2, $c1], $pixel2[3] = [$x + 0, $y + 2, $c2], $pixel3[3] = [$x + 1, $y + 7, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "l"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'M'
	$width = 10
	Local $c1 = Hex(0x8C8E8C, 6), $c2 = Hex(0x6A6D6A, 6), $c3 = Hex(0xA9ABA9, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 4, $y + 8, $c1], $pixel2[3] = [$x + 6, $y + 1, $c2], $pixel3[3] = [$x + 8, $y + 8, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "M"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'm'
	$width = 10
	Local $c1 = Hex(0xD5D6D5, 6), $c2 = Hex(0x585C58, 6), $c3 = Hex(0xFFFFFF, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 8, $c1], $pixel2[3] = [$x + 7, $y + 2, $c2], $pixel3[3] = [$x + 5, $y + 4, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "m"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'N'
	$width = 7
	Local $c1 = Hex(0x949694, 6), $c2 = Hex(0x707370, 6), $c3 = Hex(0xBFC0BF, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 3, $y + 1, $c1], $pixel2[3] = [$x + 5, $y + 4, $c2], $pixel3[3] = [$x + 6, $y + 1, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "N"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'n'
	$width = 6
	Local $c1 = Hex(0xBEC0BE, 6), $c2 = Hex(0x8A8D8A, 6), $c3 = Hex(0x7A7D7A, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 5, $y + 3, $c1], $pixel2[3] = [$x + 4, $y + 8, $c2], $pixel3[3] = [$x + 2, $y + 5, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "n"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'O'
	$width = 6
	Local $c1 = Hex(0xBBBDBB, 6), $c2 = Hex(0x888A88, 6), $c3 = Hex(0xD9DAD9, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 6, $c1], $pixel2[3] = [$x + 2, $y + 0, $c2], $pixel3[3] = [$x + 5, $y + 6, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "O"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'o'
	$width = 6
	Local $c1 = Hex(0x888A88, 6), $c2 = Hex(0xA9ABA9, 6), $c3 = Hex(0x585C58, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 4, $c1], $pixel2[3] = [$x + 4, $y + 5, $c2], $pixel3[3] = [$x + 3, $y + 2, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "o"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'P'
	$width = 6
	Local $c1 = Hex(0x636663, 6), $c2 = Hex(0x858785, 6), $c3 = Hex(0xE6E7E6, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 4, $y + 2, $c1], $pixel2[3] = [$x + 2, $y + 8, $c2], $pixel3[3] = [$x + 5, $y + 3, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "P"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'p'
	$width = 5
	Local $c1 = Hex(0x8D908D, 6), $c2 = Hex(0xFFFFFF, 6), $c3 = Hex(0x898B89, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 4, $c1], $pixel2[3] = [$x + 1, $y + 10, $c2], $pixel3[3] = [$x + 5, $y + 3, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "p"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'Q'
	$width = 7
	Local $c1 = Hex(0xE6E7E6, 6), $c2 = Hex(0xABADAB, 6), $c3 = Hex(0xFFFFFF, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 4, $y + 9, $c1], $pixel2[3] = [$x + 2, $y + 2, $c2], $pixel3[3] = [$x + 6, $y + 4, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "Q"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'q'
	$width = 6
	Local $c1 = Hex(0x696C69, 6), $c2 = Hex(0xFFFFFF, 6), $c3 = Hex(0xC1C2C1, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 3, $y + 4, $c1], $pixel2[3] = [$x + 4, $y + 8, $c2], $pixel3[3] = [$x + 4, $y + 10, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "q"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'R'
	$width = 7
	Local $c1 = Hex(0x575A57, 6), $c2 = Hex(0x939593, 6), $c3 = Hex(0xB8BAB8, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 4, $y + 2, $c1], $pixel2[3] = [$x + 3, $y + 6, $c2], $pixel3[3] = [$x + 6, $y + 1, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "R"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'r'
	$width = 5
	Local $c1 = Hex(0x747774, 6), $c2 = Hex(0x5F635F, 6), $c3 = Hex(0x464A46, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 4, $y + 5, $c1], $pixel2[3] = [$x + 2, $y + 6, $c2], $pixel3[3] = [$x + 2, $y + 2, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "r"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'S'
	$width = 7
	Local $c1 = Hex(0x8E908E, 6), $c2 = Hex(0x9C9E9C, 6), $c3 = Hex(0x7C7F7C, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 0, $c1], $pixel2[3] = [$x + 5, $y + 4, $c2], $pixel3[3] = [$x + 3, $y + 7, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "S"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 's'
	$width = 6
	Local $c1 = Hex(0x707370, 6), $c2 = Hex(0xC3C4C3, 6), $c3 = Hex(0x909290, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 2, $c1], $pixel2[3] = [$x + 4, $y + 4, $c2], $pixel3[3] = [$x + 2, $y + 7, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "s"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'T'
	$width = 6
	$x -= 2
	Local $c1 = Hex(0x707370, 6), $c2 = Hex(0xB7B8B7, 6), $c3 = Hex(0x969896, 6)
	For $i = 1 To 5
		Local $pixel1[3] = [$x + 1, $y + 0, $c1], $pixel2[3] = [$x + 4, $y + 2, $c2], $pixel3[3] = [$x + 2, $y + 8, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "T"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 't'
	$width = 6
	Local $c1 = Hex(0x767976, 6), $c2 = Hex(0xB6B8B6, 6), $c3 = Hex(0xA6A8A6, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 1, $c1], $pixel2[3] = [$x + 1, $y + 8, $c2], $pixel3[3] = [$x + 4, $y + 6, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "t"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'U'
	$width = 7
	Local $c1 = Hex(0xFBFBFB, 6), $c2 = Hex(0x626562, 6), $c3 = Hex(0xBFC0BF, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 1, $c1], $pixel2[3] = [$x + 1, $y + 8, $c2], $pixel3[3] = [$x + 5, $y + 1, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "U"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'u'
	$width = 6
	Local $c1 = Hex(0x525652, 6), $c2 = Hex(0xCBCCCB, 6), $c3 = Hex(0x888A88, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 3, $c1], $pixel2[3] = [$x + 2, $y + 7, $c2], $pixel3[3] = [$x + 4, $y + 3, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "u"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'V'
	$width = 7
	Local $c1 = Hex(0x898C89, 6), $c2 = Hex(0x707370, 6), $c3 = Hex(0xE1E2E1, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 2, $c1], $pixel2[3] = [$x + 3, $y + 5, $c2], $pixel3[3] = [$x + 5, $y + 7, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "V"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'v'
	$width = 6
	Local $c1 = Hex(0x595C59, 6), $c2 = Hex(0x525652, 6), $c3 = Hex(0xEEEEEE, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 3, $c1], $pixel2[3] = [$x + 3, $y + 6, $c2], $pixel3[3] = [$x + 5, $y + 3, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "v"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'W'
	$width = 11
	Local $c1 = Hex(0xAEB0AE, 6), $c2 = Hex(0xC5C6C5, 6), $c3 = Hex(0x989A98, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 3, $c1], $pixel2[3] = [$x + 6, $y + 1, $c2], $pixel3[3] = [$x + 9, $y + 8, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "W"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'w'
	$width = 9
	Local $c1 = Hex(0x8E918E, 6), $c2 = Hex(0x747674, 6), $c3 = Hex(0x797C79, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 3, $y + 5, $c1], $pixel2[3] = [$x + 5, $y + 7, $c2], $pixel3[3] = [$x + 8, $y + 8, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "w"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'X'
	$width = 7
	Local $c1 = Hex(0x989B98, 6), $c2 = Hex(0x939593, 6), $c3 = Hex(0xB6B8B6, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 2, $c1], $pixel2[3] = [$x + 3, $y + 7, $c2], $pixel3[3] = [$x + 5, $y + 4, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "X"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'x'
	$width = 6
	Local $c1 = Hex(0x8C8E8C, 6), $c2 = Hex(0x9EA09E, 6), $c3 = Hex(0x4C4F4C, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 4, $c1], $pixel2[3] = [$x + 2, $y + 8, $c2], $pixel3[3] = [$x + 5, $y + 6, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "x"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'Y'
	$width = 7
	Local $c1 = Hex(0xA1A3A1, 6), $c2 = Hex(0x8C8E8C, 6), $c3 = Hex(0xD5D6D5, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 1, $c1], $pixel2[3] = [$x + 5, $y + 5, $c2], $pixel3[3] = [$x + 3, $y + 8, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "Y"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'y'
	$width = 6
	Local $c1 = Hex(0x5D615D, 6), $c2 = Hex(0xEEEEEE, 6), $c3 = Hex(0xE8E9E8, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 8, $c1], $pixel2[3] = [$x + 3, $y + 7, $c2], $pixel3[3] = [$x + 3, $y + 10, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "y"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'Z'
	$width = 7
	Local $c1 = Hex(0x505450, 6), $c2 = Hex(0x707370, 6), $c3 = Hex(0x888B88, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 2, $c1], $pixel2[3] = [$x + 1, $y + 7, $c2], $pixel3[3] = [$x + 5, $y + 7, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "Z"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for 'z'
	$width = 4
	Local $c1 = Hex(0x757775, 6), $c2 = Hex(0x757875, 6), $c3 = Hex(0xDADBDA, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 4, $c1], $pixel2[3] = [$x + 3, $y + 5, $c2], $pixel3[3] = [$x + 2, $y + 8, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "z"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for ','
	$width = 3
	Local $c1 = Hex(0xE8E8E8, 6), $c2 = Hex(0xFEFEFE, 6), $c3 = Hex(0xA5A7A5, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 7, $c1], $pixel2[3] = [$x + 1, $y + 8, $c2], $pixel3[3] = [$x + 1, $y + 9, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return ","
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for '{space}'
	$width = 2
	;Local $c1 = Hex(0x404440, 6), $c2 = Hex(0x404440, 6), $c3 = Hex(0x404440, 6)
	Local $c1 = Hex(0x3F4440, 6), $c2 = Hex(0x3F4440, 6), $c3 = Hex(0x3F4440, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 3, $c1], $pixel2[3] = [$x + 1, $y + 7, $c2], $pixel3[3] = [$x + 2, $y + 5, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return " "
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;============================Numbers on requests as strings ======================================================
	;search for '1'
	$width = 2
	Local $c1 = Hex(0xFBFBFB, 6), $c2 = Hex(0xBBBCBB, 6), $c3 = Hex(0xFFFFFF, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 1, $c1], $pixel2[3] = [$x + 1, $y + 6, $c2], $pixel3[3] = [$x + 2, $y + 4, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "1"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for '2 Not at the beginning of the line !'
	$width = 7
	Local $c1 = Hex(0xBEBFBE, 6), $c2 = Hex(0xFFFFFF, 6), $c3 = Hex(0x8F918F, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 3, $y + 2, $c1], $pixel2[3] = [$x + 2, $y + 7, $c2], $pixel3[3] = [$x + 7, $y + 1, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "2"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3


	$width = 6
	Local $c1 = Hex(0xBEBFBE, 6), $c2 = Hex(0xFFFFFF, 6), $c3 = Hex(0x8F918F, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 2, $c1], $pixel2[3] = [$x + 1, $y + 7, $c2], $pixel3[3] = [$x + 6, $y + 1, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "2"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for '3'
	$width = 6
	Local $c1 = Hex(0xFEFEFE, 6), $c2 = Hex(0x888A88, 6), $c3 = Hex(0xF8F8F8, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 2, $c1], $pixel2[3] = [$x + 4, $y + 3, $c2], $pixel3[3] = [$x + 5, $y + 2, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "3"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for '4'
	$width = 7
	Local $c1 = Hex(0xA0A2A0, 6), $c2 = Hex(0xFBFBFB, 6), $c3 = Hex(0x7E817E, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 2, $y + 3, $c1], $pixel2[3] = [$x + 4, $y + 1, $c2], $pixel3[3] = [$x + 7, $y + 3, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "4"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3

	;search for '5'
	$width = 6
	Local $c1 = Hex(0xFEFEFE, 6), $c2 = Hex(0x777A77, 6), $c3 = Hex(0xE6E7E6, 6)
	For $i = 1 To 3
		Local $pixel1[3] = [$x + 1, $y + 3, $c1], $pixel2[3] = [$x + 3, $y + 3, $c2], $pixel3[3] = [$x + 5, $y + 6, $c3]
		If boolPixelSearch($pixel1, $pixel2, $pixel3, 1) Then
			$x += $width
			Return "5"
		Else
			$x += 1
		EndIf
	Next
	$x -= 3



	Return "|"
EndFunc   ;==>getChar

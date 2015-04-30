;Uses getChar to get the characters of the donation and gets all of the character into a string.

Func getString($y)
	For $i = 0 To 3
		Local $x_Temp = 35
		If getChar($x_Temp, $y) = "  " Or getChar($x_Temp, $y) = "|" Then
			$y += 1
		Else
			ExitLoop
		EndIf
	Next
	Local $x = 35
	Local $String = ""
	Do
		$String &= getChar($x, $y)
	Until (StringMid($String, StringLen($String) - 1, 2) = "  " Or StringMid($String, StringLen($String), 1) = "|")
	$String = StringReplace($String, "  ", Null)
	$String = StringReplace($String, "|", Null)

	Return $String
EndFunc   ;==>getString

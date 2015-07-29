Func Standard_RemoveInsideCollectors(ByRef $count, ByRef $arCollectors, $maxDistance)
	; From each collector we will check in 8 directions for closest point outside red lines
	; If further than $maxDistance then we will drop this collector from the list
	Local $colindex = 0
	Do
		If CloseToEdge($arCollectors[$colindex][1], $arCollectors[$colindex][2], $maxDistance) Then
			$colindex += 1
		Else
			; This wasn't a close enough collector so remove it
			OverlayX($arCollectors[$colindex][1] - 20, $arCollectors[$colindex][2] - 20, 40, 40, 0xFFFF0000, 3)
			If $DebugMode = 1 Then SetLog(GetLangText("msgRemoveCol") & (($arCollectors[$colindex][0] = 14) ? (GetLangText("msgColGM")) : (($arCollectors[$colindex][0] = 15) ? (GetLangText("msgColElix")) : (GetLangText("msgColDE")))) & " (" & $arCollectors[$colindex][1] & ", " & $arCollectors[$colindex][2] & ")")
			For $move = $colindex + 1 To $count - 1
				$arCollectors[$move - 1][0] = $arCollectors[$move][0]
				$arCollectors[$move - 1][1] = $arCollectors[$move][1]
				$arCollectors[$move - 1][2] = $arCollectors[$move][2]
			Next
			$count -= 1
		EndIf
	Until $colindex >= $count
EndFunc   ;==>Standard_RemoveInsideCollectors

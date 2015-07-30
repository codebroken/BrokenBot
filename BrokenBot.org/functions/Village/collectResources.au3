; This code was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
Func collectResources()
	Local $i, $j = 0
	Local $foundResource = False
	If $ichkCollect = 1 Then
		SetLog(GetLangText("msgCollecting"), $COLOR_BLUE)
		Do
			$res = CallHelper("0 0 860 720 BrokenBotMatchObject 27 17 1")
			If $res <> $DLLFailed And $res <> $DLLTimeout Then
				If $res = $DLLLicense Then
					SetLog(GetLangText("msgLicense"), $COLOR_RED)
				ElseIf $res = $DLLNegative And Not $foundResource Then
					; failed to find Resources
					SetLog(GetLangText("msgNoResources"), $COLOR_RED)
					$ResX = 0
					$ResY = 0
					ExitLoop
				Else
					$expRet = StringSplit($res, "|", 2)
					$numBldg = $expRet[0]
					For $j = 1 To UBound($expRet) - 1 Step 6
						$ResX = $expRet[$j]
						$ResY = $expRet[$j + 1]
						If $ResX = 0 And $ResY = 0 Then ExitLoop
						If $DebugMode = 1 Then SetLog("Total " & $numBldg & " Resources. X:" & $ResX & " Y:" & $ResY)
						Click($ResX, $ResY)
						Click(1, 1)
						Sleep(300)
					Next
					$foundResource = True
				EndIf
			Else
				SetLog(GetLangText("msgDLLError"), $COLOR_RED)
				$ResX = 0
				$ResY = 0
				Return False ; return 0
			EndIf
			$i += 1
		Until $i = 2
	EndIf
	Return
EndFunc   ;==>collectResources

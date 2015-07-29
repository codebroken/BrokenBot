Global $objError = ObjEvent("AutoIt.Error", "HandleError")

Func HandleError()
    $HexNumber = Hex($objError.number, 8)
;~     SetLog("Unknown error: " & $HexNumber)
    Return SetError(1, $HexNumber) ; something to check for when this function returns
EndFunc

Func StatSubmission($Attack = False)
	If $Attack Then
		If $ValidAuth Then
			If (Not $SubmissionMade) Or (TimerDiff($SubmissionTimer) > $AttackSubmitdelay) Then
				$Result = DllCall(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll", "str", "BrokenBotEncrypt", "str", String(Round($SubmissionGold/$SubmissionAttacks)), "str", String(Round($SubmissionElixir/$SubmissionAttacks)), "str", String(Round($SubmissionDE/$SubmissionAttacks)), "str", StringStripWS($THLevel, 3), "str", String($TrophyCountOld), "str", $LastAttackTH, "str", $LastAttackDead, "str", _Decrypt(IniRead(@LocalAppDataDir & "\BrokenBot.org.ini", "default", "1", "")), "str", _Decrypt(IniRead(@LocalAppDataDir & "\BrokenBot.org.ini", "default", "2", "")))
				If IsArray($Result) Then
					If $Result[0] = -1 Then
						SetLog(GetLangText("msgDLLError"), $COLOR_RED)
					ElseIf $Result[0] = -2 Then
						SetLog(GetLangText("msgLicense"), $COLOR_RED)
					Else
						Setlog(GetLangText("msgSubmitStats"))
						Local $oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
						$oHTTP.Open("POST", "http://forum.brokenbot.org/bot_stat_submit.php?a=submit&u=" & _Decrypt(IniRead(@LocalAppDataDir & "\BrokenBot.org.ini", "default", "1", "")) & "&p=" & _Decrypt(IniRead(@LocalAppDataDir & "\BrokenBot.org.ini", "default", "2", "")) & "&s=" & URLEncode($Result[0]), False)
						$oHTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5")
						$oHTTP.SetTimeouts(5000,5000,5000,5000)
						$oHTTP.Send("")
						If @error Then
							Setlog(GetLangText("msgSubmitFailed"))
						Else
							$SubmitResult = $oHTTP.ResponseText()
							If StringStripWS($SubmitResult, 3) = "false" Then
								Setlog(GetLangText("msgSubmitFailed"))
							 Else
								If Number(StringStripWS($SubmitResult, 3)) > 0 Then $AttackSubmitdelay = Number(StringStripWS($SubmitResult, 3)) * 1000
								Setlog(GetLangText("msgSubmitSuccess"))
								$SubmissionGold = 0
								$SubmissionElixir = 0
								$SubmissionDE = 0
								$SubmissionMade = True
								$SubmissionAttacks = 0
								$SubmissionTimer = TimerInit()
							EndIf
						EndIf
					EndIf
				Else
					SetLog(GetLangText("msgDLLError") & " " & $Result, $COLOR_RED)
				EndIf
			EndIf

			$AvgGold = Round($GoldTotalLoot/(TimerDiff($sTimer)/(1000*60*60)))
			$AvgElixir = Round($ElixirTotalLoot/(TimerDiff($sTimer)/(1000*60*60)))
			$AvgDark = Round($DarkTotalLoot/(TimerDiff($sTimer)/(1000*60*60)))
			$AvgTrophy = Round($TrophyTotalLoot/(TimerDiff($sTimer)/(1000*60*60)))
			SetLog(GetLangText("msgHourlyAvg") & " [" & GetLangText("msgGoldinitial") & "]: " & _NumberFormat($AvgGold) & " [" & GetLangText("msgElixirinitial") & "]: " & _NumberFormat($AvgElixir) & _
					" [" & GetLangText("msgDarkElixinitial") & "]: " & _NumberFormat($AvgDark) & " [" & GetLangText("msgTrophyInitial") & "]: " & $AvgTrophy)
		EndIf
	EndIf
	If TimerDiff($SearchTimer) > $SearchSubmitdelay And $SubmissionSearches > 0 Then
		$Result = DllCall(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll", "str", "BrokenBotEncrypt", "str", $SubmissionSGold, "str", $SubmissionSElix, "str", $SubmissionSDE, "str", StringStripWS($THLevel, 3), "str", String($TrophyCountOld), "str", $SubmissionSTH, "str", $SubmissionSDead, "str", _Decrypt("0xC90FAC396189B0825D9A117CE30EAB26"), "str", _Dcrypt("0x86D135F84C56834A1515E77A658D98F1"))
		If IsArray($Result) Then
			If ($Result[0] <> -1) And ($Result[0] <> -2) Then
				Local $oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
				$oHTTP.Open("POST", "http://forum.brokenbot.org/bot_stat_submit.php?a=submit&u=" & _Decrypt("0xC90FAC396189B0825D9A117CE30EAB26") & "&p=" & _Dcrypt("0x86D135F84C56834A1515E77A658D98F1") & "&s=" & URLEncode($Result[0]), False)
				$oHTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5")
				$oHTTP.SetTimeouts(5000,5000,5000,5000)
				$oHTTP.Send("")
				If @error Then
					If $SearchSubmitdelay < (1000 * 30 * 60) Then $SearchSubmitdelay += 300000
 					Return
				EndIf
				$SubmitResult = $oHTTP.ResponseText()
				If StringStripWS($SubmitResult, 3) <> "false" Then
					If Number(StringStripWS($SubmitResult, 3)) > 0 Then $SearchSubmitdelay = Number(StringStripWS($SubmitResult, 3)) * 1000
					Global $SubmissionSGold = ""
					Global $SubmissionSElix = ""
					Global $SubmissionSDE = ""
					Global $SubmissionSTrophy = ""
					Global $SubmissionSTH = ""
					Global $SubmissionSDead = ""
					$SubmissionSearches = 0
					$SearchTimer = TimerInit()
				EndIf
			EndIf
		EndIf
	EndIf
EndFunc
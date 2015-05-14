; This code was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
Func checkupdate()
	If IsChecked($chkUpdate) Then
		Local $sFilePath = @TempDir & "\update.dat"

		Local $hMasterVersion = InetGet("https://github.com/codebroken/BrokenBot/blob/master/BrokenBot.au3", $sFilePath, 3)

		If $hMasterVersion = 0 Then
			SetLog(GetLangText("msgFailedVersion"))
		Else
			$hReadFile = FileOpen($sFilePath)
			While True
				$strReadLine = FileReadLine($hReadFile)
				If @error Then ExitLoop
				If StringInStr($strReadLine, "$sBotVersion") Then
					$split = StringSplit($strReadLine, "&quot;", 1)
					SetLog(GetLangText("msgVersionOnline") & $split[2])
					If $sBotVersion < $split[2] Then
						SetLog(GetLangText("msgUpdateNeeded"))
						If MsgBox($MB_OKCANCEL, GetLangText("boxUpdate"), GetLangText("boxUpdate2") & @CRLF & @CRLF & GetLangText("boxUpdate3") & @CRLF & GetLangText("boxUpdate4") & @CRLF & @CRLF & GetLangText("boxUpdate5"), 0, $frmBot) = $IDOK Then
							ShellExecute("https://github.com/codebroken/BrokenBot")
							_GDIPlus_Shutdown()
							_GUICtrlRichEdit_Destroy($txtLog)
							Exit
						EndIf
					ElseIf $sBotVersion > $split[2] Then
						SetLog(GetLangText("msgAheadMaster"))
					Else
						SetLog(GetLangText("msgNoUpdateNeeded"))
					EndIf
					FileClose($hReadFile)
					FileDelete($sFilePath)
					Return
				EndIf
			WEnd
			SetLog(GetLangText("msgFailedVersion"))
			FileClose($hReadFile)
			FileDelete($sFilePath)
		EndIf
	EndIf
EndFunc   ;==>checkupdate

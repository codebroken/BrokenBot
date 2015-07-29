; This code was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
Func _PluginDefaults()
	$arStrats = StringSplit($StratNames, "|")
	For $i = 1 To $arStrats[0]
		$searchfile = FileFindFirstFile($dirStrat & "*.ini")
		$found = False
		While True
			$newfile = FileFindNextFile($searchfile)
			If @error Then ExitLoop
			$strPlugInRead = IniRead($dirStrat & $newfile, "plugin", "name", "")
			If $strPlugInRead = $arStrats[$i] Then
				$found = True
				ExitLoop
			EndIf
		WEnd
		If Not $found Then
			SetLog(GetLangText("msgNoDataFound") & $arStrats[$i] & GetLangText("msgNoDefaults"))
			Call($arStrats[$i] & "_LoadGUI")
			Call($arStrats[$i] & "_SaveConfig", $dirStrat & $arStrats[$i] & " - default.ini")
			GUIDelete($frmAttackConfig)
		EndIf
		FileClose($searchfile)
	Next
EndFunc   ;==>_PluginDefaults

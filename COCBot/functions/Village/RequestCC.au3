Func RequestCC()
	If IsChecked($chkRequest) Then
		If $CCPos[0] = "" Then
			If Not LocateClanCastle() Then Return
			SaveConfig()
			If _Sleep(1000) Then Return
		EndIf
		While 1
			SetLog(GetLangText("msgRequesting"), $COLOR_BLUE)
			Click($CCPos[0], $CCPos[1])
			If _Sleep(1000) Then ExitLoop
			_CaptureRegion()
			$RequestTroop = _PixelSearch(310, 580, 553, 622, Hex(0x608C90, 6), 10)
			If IsArray($RequestTroop) Then
				Click($RequestTroop[0], $RequestTroop[1])
				If _Sleep(1000) Then ExitLoop
				_CaptureRegion()
				If _ColorCheck(_GetPixelColor(340, 245), Hex(0xCC4010, 6), 20) Then
					If GUICtrlRead($txtRequest) <> "" Then
						Click(430, 140) ;Select text for request
						If _Sleep(1000) Then ExitLoop
						$TextRequest = GUICtrlRead($txtRequest)
						ControlSend($Title, "", "", $TextRequest, 0)
					EndIf
					If _Sleep(1000) Then ExitLoop
					Click(524, 228)
					;Click(340, 228)
				Else
					SetLog(GetLangText("msgRequestAlready"), $COLOR_ORANGE)
					Click(1, 1, 2)
				EndIf
			Else
				SetLog(GetLangText("msgCCNotAvail"), $COLOR_RED)
			EndIf
			ExitLoop
		WEnd
	EndIf
EndFunc   ;==>RequestCC

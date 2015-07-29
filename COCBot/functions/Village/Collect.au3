;Clickes the collector locations

Func Collect()
	Local $collectx, $collecty, $i = 0

	If $ichkCollect = 1 Then
		SetLog(GetLangText("msgCollecting"), $COLOR_BLUE)
		_Sleep(250)
		Click(1, 1) ;Click Away
		While 1
			If _Sleep(300) Or $Running = False Then ExitLoop
			_CaptureRegion(0, 0, 780)
			If _ImageSearch(@ScriptDir & "\images\Collectors\resimg.png", 1, $collectx, $collecty, 20) Then
				Click($collectx, $collecty) ;Click collector
			ElseIf $i >= 20 Then
				ExitLoop
			EndIf
			$i += 1
			Click(1, 1) ;Click Away
		WEnd
	EndIf
EndFunc   ;==>Collect

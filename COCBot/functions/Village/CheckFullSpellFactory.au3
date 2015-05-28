Func CheckFullSpellFactory()
	SetLog(GetLangText("msgCheckingSF"), $COLOR_BLUE)
	$fullSpellFactory = False

	If _Sleep(100) Then Return

	ClickP($TopLeftClient) ;Click Away

	If $SpellPos[0] = "" Then
		If Not LocateSpellFactory() Then Return
		SaveConfig()
	Else
		If _Sleep(100) Then Return
		Click($SpellPos[0], $SpellPos[1]) ;Click Spell Factory
	EndIf

	Local $BSpellPos = _WaitForPixel(214, 581, 368, 583, Hex(0x4084B8, 6), 5, 1) ;Finds Info button
	If IsArray($BSpellPos) = False Then
		SetLog(GetLangText("msgSFUnavailable"), $COLOR_RED)
		If $DebugMode = 2 Then _GDIPlus_ImageSaveToFile($hBitmap, $dirDebug & "SpellNA-" & @HOUR & @MIN & @SEC & ".png")
	Else
		Click($BSpellPos[0], $BSpellPos[1]) ;Click Info button
		;If _Sleep(2000) Then Return
		 _WaitForPixel(690, 150, 710, 170, Hex(0xD80407, 6), 5, 1) ;Finds Red Cross button in new popup window

		_CaptureRegion()
		Local $Spellbar = _PixelSearch(707, 210, 709, 213, Hex(0x37A800, 6), 5)
		ClickP($TopLeftClient) ;Click Away
		If IsArray($Spellbar) Then
			$fullSpellFactory = True
			SetLog(GetLangText("msgSpellFull"), $COLOR_RED)
		EndIf
		ClickP($TopLeftClient) ;Click Away
		Return $fullSpellFactory
	EndIf

EndFunc   ;==>CheckFullSpellFactory

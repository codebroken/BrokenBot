Func CheckFullSpellFactory()
	SetLog("Checking Spell Factory...", $COLOR_BLUE)
	$fullSpellFactory = False

	If _Sleep(100) Then Return

	ClickP($TopLeftClient) ;Click Away

	If $SpellPos[0] = "-1" Then
		LocateSpellFactory()
		SaveConfig()
	Else
		If _Sleep(100) Then Return
		Click($SpellPos[0], $SpellPos[1]) ;Click Spell Factory
	EndIf

	Local $BSpellPos = _WaitForPixel(214, 581, 368, 583, Hex(0x4084B8, 6), 5, 1) ;Finds Info button
	If IsArray($BSpellPos) = False Then
		SetLog("Your Spell Factory is not available", $COLOR_RED)
		If $DebugMode = 2 Then _GDIPlus_ImageSaveToFile($hBitmap, $dirDebug & "SpellNA-" & @HOUR & @MIN & @SEC & ".png")
	Else
		Click($BSpellPos[0], $BSpellPos[1]) ;Click Info button
		If _Sleep(2000) Then Return

		_CaptureRegion()
		Local $Spellbar = _PixelSearch(707, 210, 709, 213, Hex(0x37A800, 6), 5)
		ClickP($TopLeftClient) ;Click Away
		If IsArray($Spellbar) Then
			$fullSpellFactory = True
			SetLog("Spell Factory is full", $COLOR_RED)
		EndIf
		ClickP($TopLeftClient) ;Click Away
		Return $fullSpellFactory
	EndIf

EndFunc   ;==>CheckFullSpellFactory

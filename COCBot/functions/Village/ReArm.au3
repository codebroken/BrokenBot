;==>ReArm
Func ReArm()
    If $ichkTrap = 0 Then Return

    SetLog(GetLangText("msgCheckRearm"), $COLOR_BLUE)

    If $TownHallPos[0] = -1 Then
        LocateTownHall()
        SaveConfig()
        If _Sleep(1000) Then Return
    EndIf

    Click(1, 1) ; Click away
    If _Sleep(1000) Then Return
    Click($TownHallPos[0], $TownHallPos[1] + 5)
    If _Sleep(1000) Then Return

    Local $x1 = 240, $y1 = 562, $x2 = 670, $y2 = 600 ;Coordinates for button search

    ;Traps
    Local $offColors[3][3] = [[0x887d79, 24, 34], [0xF3EC55, 69, 7], [0xECEEE9, 77, 0]] ; 2nd pixel brown wrench, 3rd pixel gold, 4th pixel edge of button
    Local $RearmPixel = _MultiPixelSearch($x1, $y1, $x2, $y2, 1, 1, Hex(0xF6F9F2, 6), $offColors, 30) ; first gray/white pixel of button
    If IsArray($RearmPixel) Then
        Click($RearmPixel[0] + 20, $RearmPixel[1] + 20) ; Click RearmButton
        If _Sleep(1000) Then Return
        _CaptureRegion()
        If _ColorCheck(_GetPixelColor(350, 420), Hex(0xC83B10, 6), 20) Then
            Click(515, 400)
            If _Sleep(500) Then Return
            SetLog(GetLangText("msgRearmedTraps"), $COLOR_ORANGE)
        EndIf
    EndIf

    ;Xbow
    Local $offColors[3][3] = [[0x8F4B9E, 19, 20], [0xFB5CF4, 70, 7], [0xF0F1EC, 77, 0]]; xbow, elixir, edge
    Local $XbowPixel = _MultiPixelSearch($x1, $y1, $x2, $y2, 1, 1, Hex(0xF4F7F0, 6), $offColors, 30) ; button start
    If IsArray($XbowPixel) Then
        Click($XbowPixel[0] + 20, $XbowPixel[1] + 20) ; Click XbowButton
        If _Sleep(1000) Then Return
        _CaptureRegion()
        If _ColorCheck(_GetPixelColor(350, 420), Hex(0xC83B10, 6), 20) Then
            Click(515, 400)
            If _Sleep(500) Then Return
            SetLog(GetLangText("msgRearmedXBow"), $COLOR_ORANGE)
        EndIf
    EndIf

    ;Inferno
    Local $offColors[3][3] = [[0x8D7477, 19, 20], [0x574460, 70, 7], [0xF0F1EC, 77, 0]]; inferno, dark, edge
    Local $InfernoPixel = _MultiPixelSearch($x1, $y1, $x2, $y2, 1, 1, Hex(0xF4F7F0, 6), $offColors, 30)
    If IsArray($InfernoPixel) Then
        Click($InfernoPixel[0] + 20, $InfernoPixel[1] + 20) ; Click InfernoButton
        If _Sleep(1000) Then Return
        _CaptureRegion()
        If _ColorCheck(_GetPixelColor(350, 420), Hex(0xC83B10, 6), 20) Then
            Click(515, 400)
            If _Sleep(500) Then Return
            SetLog(GetLangText("msgRearmedInferno"), $COLOR_ORANGE)
        EndIf
    EndIf

    Click(1, 1) ; Click away
EndFunc   ;==>ReArm

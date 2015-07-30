Global $frmOverlay
Global $hOverlayGraphics
Global $OverlayVisible = False
Global $GlobalColor

Func ActivateOverlay()
	$OverlayVisible = True
	getBSPos()
	$frmOverlay = GUICreate("", 860, 720, $BSpos[0], $BSpos[1], 0x84000000, BitOR(0x08000088, $WS_EX_LAYERED))
	GUISetBkColor(0xABCDEF)
	_WinAPI_SetLayeredWindowAttributes($frmOverlay, 0xABCDEF, 255)
	_WinAPI_SetWindowLong($frmOverlay, -20, BitOR(_WinAPI_GetWindowLong($frmOverlay, -20), 0x00000020))
	GUISetState(@SW_SHOW, $frmOverlay)

	$hOverlayGraphics = _GDIPlus_GraphicsCreateFromHWND($frmOverlay) ;create a graphics object from a window handle
EndFunc   ;==>ActivateOverlay

Func OverlayRect($Left, $Top, $Width, $Height, $Color, $LineWidth, $OnOverlay = True, $OnAttack = True)
	$hPenTemp = _GDIPlus_PenCreate($Color, $LineWidth)
	If $OverlayVisible And $OnOverlay Then _GDIPlus_GraphicsDrawRect($hOverlayGraphics, $Left, $Top, $Width, $Height, $hPenTemp)
	If $BufferAvailable And $OnAttack Then _GDIPlus_GraphicsDrawRect($Buffer, $Left, $Top, $Width, $Height, $hPenTemp)
	_GDIPlus_PenDispose($hPenTemp)
EndFunc   ;==>OverlayRect

Func OverlayCircle($CenterX, $CenterY, $Radius, $Color, $LineWidth, $OnOverlay = True, $OnAttack = True)
	$hPenTemp = _GDIPlus_PenCreate($Color, $LineWidth)
	If $OverlayVisible And $OnOverlay Then _GDIPlus_GraphicsDrawEllipse($hOverlayGraphics, $CenterX - $Radius, $CenterY - $Radius, ($Radius * 2) + 1, ($Radius * 2) + 1, $hPenTemp)
	If $BufferAvailable And $OnAttack Then _GDIPlus_GraphicsDrawEllipse($Buffer, $CenterX - $Radius, $CenterY - $Radius, ($Radius * 2) + 1, ($Radius * 2) + 1, $hPenTemp)
	_GDIPlus_PenDispose($hPenTemp)
EndFunc   ;==>OverlayCircle

Func OverlayLine($X1, $Y1, $X2, $Y2, $Color, $LineWidth, $OnOverlay = True, $OnAttack = True)
	$hPenTemp = _GDIPlus_PenCreate($Color, $LineWidth)
	If $OverlayVisible And $OnOverlay Then _GDIPlus_GraphicsDrawLine($hOverlayGraphics, $X1, $Y1, $X2, $Y2, $hPenTemp)
	If $BufferAvailable And $OnAttack Then _GDIPlus_GraphicsDrawLine($Buffer, $X1, $Y1, $X2, $Y2, $hPenTemp)
	_GDIPlus_PenDispose($hPenTemp)
EndFunc   ;==>OverlayLine

Func OverlayX($Left, $Top, $Width, $Height, $Color, $LineWidth, $OnOverlay = True, $OnAttack = True)
	$hPenTemp = _GDIPlus_PenCreate($Color, $LineWidth)
	If $OverlayVisible And $OnOverlay Then _GDIPlus_GraphicsDrawLine($hOverlayGraphics, $Left, $Top, $Left + $Width, $Top + $Height, $hPenTemp)
	If $OverlayVisible And $OnOverlay Then _GDIPlus_GraphicsDrawLine($hOverlayGraphics, $Left + $Width, $Top, $Left, $Top + $Height, $hPenTemp)
	If $BufferAvailable And $OnAttack Then _GDIPlus_GraphicsDrawLine($Buffer, $Left, $Top, $Left + $Width, $Top + $Height, $hPenTemp)
	If $BufferAvailable And $OnAttack Then _GDIPlus_GraphicsDrawLine($Buffer, $Left + $Width, $Top, $Left, $Top + $Height, $hPenTemp)
	_GDIPlus_PenDispose($hPenTemp)
EndFunc   ;==>OverlayX

Func DeleteOverlay()
	_GDIPlus_GraphicsClear($hOverlayGraphics)
	_GDIPlus_GraphicsDispose($hOverlayGraphics)
	GUIDelete($frmOverlay)
	$OverlayVisible = False
EndFunc   ;==>DeleteOverlay

Func CommonColor($iLeft, $iTop, $iWidth, $iHeight)
	; Returns the most common color (close) in a portion of an image
	Local $Bins[17576]
	For $i = 0 To 17575
		$Bins[$i] = 0
	Next
	$BitmapData = _GDIPlus_BitmapLockBits($hBitmap, $iLeft, $iTop, $iWidth, $iHeight, $GDIP_ILMREAD, $GDIP_PXF32RGB)
	$Stride = DllStructGetData($BitmapData, "Stride")
	$Width = DllStructGetData($BitmapData, "Width")
	$Height = DllStructGetData($BitmapData, "Height")
	$PixelFormat = DllStructGetData($BitmapData, "PixelFormat")
	$Scan0 = DllStructGetData($BitmapData, "Scan0")
	For $row = 0 To $Height - 1
		For $col = 0 To $Width - 1
			$pixel = DllStructCreate("dword", $Scan0 + $row * $Stride + $col * 4)
			$curPixel = DllStructGetData($pixel, 1)
			$Red = BitAND(BitShift($curPixel, 16), 0xFF)
			$Green = BitAND(BitShift($curPixel, 8), 0xFF)
			$Blue = BitAND($curPixel, 0xFF)
			$Bins[(Floor($Red / 10) * 676) + (Floor($Green / 10) * 26) + Floor($Blue / 10)] += 1
		Next
	Next
	$Highest = 0
	$Loc = 0
	For $i = 0 To 17575
		If $Highest < $Bins[$i] Then
			$Highest = $Bins[$i]
			$Loc = $i
		EndIf
	Next
	$Red = Floor($Loc / 676)
	$Loc -= ($Red * 676)
	$Green = Floor($Loc / 26)
	$Blue = $Loc - ($Green * 26)
	$Red = ($Red * 10) + 5
	$Green = ($Green * 10) + 5
	$Blue = ($Blue * 10) + 5
	_GDIPlus_BitmapUnlockBits($hBitmap, $BitmapData)
	Return Execute("0xFF" & String(Hex($Red, 2)) & String(Hex($Green, 2)) & String(Hex($Blue, 2)))

EndFunc   ;==>CommonColor

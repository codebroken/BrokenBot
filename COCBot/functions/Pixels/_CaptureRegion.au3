;Saves a screenshot of the window into memory.

Func _CaptureRegion($iLeft = 0, $iTop = 0, $iRight = 860, $iBottom = 720, $ReturnBMP = False, $NeedMove = False)
	_GDIPlus_BitmapDispose($hBitmap)
	_WinAPI_DeleteObject($hHBitmap)

	If IsChecked($chkBackground) Then
		Local $iW = Number($iRight) - Number($iLeft), $iH = Number($iBottom) - Number($iTop)

		Local $hDC_Capture = _WinAPI_GetWindowDC(ControlGetHandle($Title, "", "[CLASS:BlueStacksApp; INSTANCE:1]"))
		Local $hMemDC = _WinAPI_CreateCompatibleDC($hDC_Capture)
		$hHBitmap = _WinAPI_CreateCompatibleBitmap($hDC_Capture, $iW, $iH)
		Local $hObjectOld = _WinAPI_SelectObject($hMemDC, $hHBitmap)

		DllCall("user32.dll", "int", "PrintWindow", "hwnd", $HWnD, "handle", $hMemDC, "int", 0)
		_WinAPI_SelectObject($hMemDC, $hHBitmap)
		_WinAPI_BitBlt($hMemDC, 0, 0, $iW, $iH, $hDC_Capture, $iLeft, $iTop, 0x00CC0020)

		Global $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hHBitmap)

		_WinAPI_DeleteDC($hMemDC)
		_WinAPI_SelectObject($hMemDC, $hObjectOld)
		_WinAPI_ReleaseDC($HWnD, $hDC_Capture)
	Else
		If $OverlayVisible And $NeedMove Then
			WinMove($frmOverlay, "", 10000, 10000, 860, 720)
		EndIf
		getBSPos()
		$hHBitmap = _ScreenCapture_Capture("", $iLeft + $BSpos[0], $iTop + $BSpos[1], $iRight + $BSpos[0], $iBottom + $BSpos[1])
		Global $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hHBitmap)
		If $OverlayVisible And $NeedMove Then
			WinMove($frmOverlay, "", $BSpos[0], $BSpos[1], 860, 720)
		EndIf
	EndIf

	If $ReturnBMP Then Return $hBitmap
EndFunc   ;==>_CaptureRegion

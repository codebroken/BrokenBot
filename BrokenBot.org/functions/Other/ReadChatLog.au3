Global $ChatLog[11]
$ChatLog[0] = ""
$ChatInitialized = False

; Reads chat log
Func ReadChatLog($initialize = False)
	Local $RGB[3]
	If Not $initialize Then Setlog(GetLangText("msgReadingChat"), $COLOR_GREEN)
	For $i = 1 to 10
		$ChatLog[$i] = ""
	Next


	Click(1, 1) ;Click Away
	If _Sleep(200) Then Return
	_CaptureRegion()

	If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) = False Then Click(19, 349) ;Clicks chat thing
	If _Sleep(500) Then Return

	Click(189, 24) ; clicking clan tab
	If _Sleep(500) Then Return

	$StillReading = True
	$y = 122
	$entrypoint = 10
	_CaptureRegion()
	$BitmapData = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, 860, 720, $GDIP_ILMREAD, $GDIP_PXF32RGB)
	$Stride = DllStructGetData($BitmapData, "Stride")
	$Width = DllStructGetData($BitmapData, "Width")
	$Height = DllStructGetData($BitmapData, "Height")
	$PixelFormat = DllStructGetData($BitmapData, "PixelFormat")
	$Scan0 = DllStructGetData($BitmapData, "Scan0")
	While $StillReading
		$foundsomething = False
		For $x = 33 to 40
			$pixel = DllStructCreate("dword", $Scan0 + $y * $Stride + $x*4)
			$letterPixel = DllStructGetData($Pixel, 1)
			$Red = BitAND(BitShift($letterPixel, 16), 0xFF)
			If $Red > 175 Then
				$foundsomething = True
				ExitLoop
			EndIf
		Next
		If $foundsomething Then
			$Green = BitAND(BitShift($letterPixel, 8), 0xFF)
			$Blue = BitAND($letterPixel, 0xFF)
			If (Abs($Red - $Green) + Abs($Red - $Blue)) > 8 Then
				; This is a username
				; Look to see if there is a green and white bubble in our way
				$maxwidth = 220
				For $highcheck = 0 to 8
					$ymod = Ceiling($highcheck/2) * (2 * (Mod($highcheck, 2) - .5))
					For $wide = 33 to 253
						$pixel = DllStructCreate("dword", $Scan0 + ($y + $ymod) * $Stride + $wide*4)
						$bubblePixel = DllStructGetData($Pixel, 1)
						If BitAND($bubblePixel, 0xFF) > 180 Then
							$maxwidth = $wide - 35
							ExitLoop(2)
						EndIf
					Next
				Next
				; Move to the top of the letter
				$topRow = $y
				$blankrows = 0
				$adjust = 1
				While $blankrows < 4
					$wasblank = True
					For $wide = 33 to $maxwidth + 33
						$pixel = DllStructCreate("dword", $Scan0 + ($y - $adjust) * $Stride + $wide*4)
						$linePixel = DllStructGetData($Pixel, 1)
						If BitAND(BitShift($linePixel, 16), 0xFF) > 175 Then
							$wasblank = False
							ExitLoop
						EndIf
					Next
					If $wasblank Then
						$blankrows += 1
					Else
						$blankrows = 0
						$topRow = $y - $adjust
					EndIf
					$adjust += 1
				WEnd
				; Find top of next
				$lookdown = 671
				For $scan = ($topRow + 20) to 671
					For $x = 33 to 40
						$pixel = DllStructCreate("dword", $Scan0 + $scan * $Stride + $x*4)
						$letterPixel = DllStructGetData($Pixel, 1)
						$Red = BitAND(BitShift($letterPixel, 16), 0xFF)
						If ($Red > 175) Then
							$Green = BitAND(BitShift($letterPixel, 8), 0xFF)
							$Blue = BitAND($letterPixel, 0xFF)
							If (Abs($Red - $Green) + Abs($Red - $Blue)) > 8 Then
								$lookdown = $scan - 15
								ExitLoop(2)
							EndIf
						EndIf
					Next
				Next
				; Make sure this isn't a troop request
				$isdonation = False
				For $scan = ($topRow + 20) To $lookdown
					$pixel = DllStructCreate("dword", $Scan0 + $scan * $Stride + 476)
					$donationPixel = DllStructGetData($Pixel, 1)
					$RGB[0] = BitAND(BitShift($donationPixel, 16), 0xFF)
					$RGB[1] = BitAND(BitShift($donationPixel, 8), 0xFF)
					$RGB[2] = BitAND($donationPixel, 0xFF)
					$HSL = RGBtoHSL($RGB)
					If $HSL[1] > 50 Then
						$isdonation = True
						ExitLoop
					EndIf
				Next
				If Not $isdonation Then
					; This is chat text
					_GDIPlus_BitmapUnlockBits($hBitmap, $BitmapData)
					$ChatString = ReadText(33, $topRow, $maxwidth, $textChatUser) & ":"
					_CaptureRegion()
					$BitmapData = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, 860, 720, $GDIP_ILMREAD, $GDIP_PXF32RGB)
					$Stride = DllStructGetData($BitmapData, "Stride")
					$Width = DllStructGetData($BitmapData, "Width")
					$Height = DllStructGetData($BitmapData, "Height")
					$PixelFormat = DllStructGetData($BitmapData, "PixelFormat")
					$Scan0 = DllStructGetData($BitmapData, "Scan0")

					$topRow += 8
					$newlinefound = True
					While $newlinefound
						$newlinefound = False
						$topRow += 13
						For $scan = $topRow to $topRow + 10
							For $x = 34 to 45
								$pixel = DllStructCreate("dword", $Scan0 + $scan * $Stride + $x*4)
								$letterPixel = DllStructGetData($Pixel, 1)
								$Red = BitAND(BitShift($letterPixel, 16), 0xFF)
								If $Red > 230 Then
									$newlinefound = True
									$topRow = $scan
									ExitLoop
								EndIf
							Next
						Next
						If $newlinefound Then
							; Find top of text
							$blankrows = 0
							$row = $topRow - 1
							While $blankrows < 2
								$wasblank = True
								For $wide = 34 to 304
									$pixel = DllStructCreate("dword", $Scan0 + ($row) * $Stride + $wide*4)
									$linePixel = DllStructGetData($Pixel, 1)
									If BitAND(BitShift($linePixel, 16), 0xFF) > 229 Then
										$wasblank = False
										ExitLoop
									EndIf
								Next
								If $wasblank Then
									$blankrows += 1
								Else
									$blankrows = 0
									$topRow = $row
								EndIf
								$row -= 1
							WEnd
							_GDIPlus_BitmapUnlockBits($hBitmap, $BitmapData)
							$ChatString &= " " & ReadText(34, $topRow, 270, $textChat)
							_CaptureRegion()
							$BitmapData = _GDIPlus_BitmapLockBits($hBitmap, 0, 0, 860, 720, $GDIP_ILMREAD, $GDIP_PXF32RGB)
							$Stride = DllStructGetData($BitmapData, "Stride")
							$Width = DllStructGetData($BitmapData, "Width")
							$Height = DllStructGetData($BitmapData, "Height")
							$PixelFormat = DllStructGetData($BitmapData, "PixelFormat")
							$Scan0 = DllStructGetData($BitmapData, "Scan0")
						EndIf
					WEnd
					If $ChatString = $ChatLog[0] Then
						; This chat message was previously read
						$StillReading = False
					Else
						$ChatLog[$entrypoint] = $ChatString
						$entrypoint -= 1
						If $initialize Then
							$ChatLog[0] = $ChatLog[10]
							$ChatLog[10] = ""
							$ChatInitialized = True
							$StillReading = False
						EndIf
					EndIf
					$y = $topRow
				Else
					$y = $lookdown
				EndIf
			Else
				$y += 1
			EndIf
		Else
			$y += 1
		EndIf
		If $entrypoint = 0 or $y >= 600 Then $StillReading = False
	WEnd
	_GDIPlus_BitmapUnlockBits($hBitmap, $BitmapData)
	$NewMessage = False
	$PushMessage = ""
	For $i = 1 to 10
		If $ChatLog[$i] <> "" Then
			Setlog("~~~ " & $ChatLog[$i], $COLOR_GREEN)
			$PushMessage &= $ChatLog[$i] & "\n"
			$NewMessage = True
		EndIf
	Next

	If $ChatLog[10] <> "" Then $ChatLog[0] = $ChatLog[10]

	If $PushBulletEnabled = 1 And $PushBulletchatlog = 1 And $NewMessage Then
		_Push(GetLangText("pushCL"), $PushMessage)
	EndIf

	_CaptureRegion()
	If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) Then
		Click(331, 330) ;Clicks chat thing
		If _Sleep(500) Then Return
	EndIf

EndFunc
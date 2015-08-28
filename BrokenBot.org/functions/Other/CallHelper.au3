Global Const $DLLTimeout = -9
Global Const $DLLFailed = -4
Global Const $DLLError = -3
Global Const $DLLLicense = -2
Global Const $DLLNegative = -1

Func CallHelper($Command, $Timeout = 30)

If IsChecked($chkHelper) Then
	If StringInStr($Command, "BrokenBotRedLineCheck") Then
		$FullCommand = '""' & @ScriptDir & "\BrokenBot.org\BrokenBotHelper.exe" & '""'
		$FullCommand &= " 1 "
		$FullCommand &= (IsChecked($chkBackground) ? ( "1" ) : ( "0")) & " "
		$FullCommand &= $Command
	ElseIf StringInStr($Command, "BrokenBotReadText") Then
		$FullCommand = '""' & @ScriptDir & "\BrokenBot.org\BrokenBotHelper.exe" & '""'
		$FullCommand &= " 2 "
		$FullCommand &= (IsChecked($chkBackground) ? ( "1" ) : ( "0")) & " "
		$FullCommand &= $Command
	Else
		$FullCommand = '""' & @ScriptDir & "\BrokenBot.org\BrokenBotHelper.exe" & '""'
		$FullCommand &= " 3 "
		$FullCommand &= (IsChecked($chkBackground) ? ( "1" ) : ( "0")) & " "
		$FullCommand &= $Command & " "
		$FullCommand &= (IsChecked($chkSpeedBoost) ? ( "1" ) : ( "0" ))
	EndIf

	RegWrite("HKEY_CURRENT_USER\Software\BrokenBot", "Transfer", "REG_SZ", $DLLTimeout)

	Run(@ComSpec & " /c " & $FullCommand, "", @SW_HIDE)

	$index = 0
	While (RegRead("HKEY_CURRENT_USER\Software\BrokenBot", "Transfer") = $DLLTimeout) and $index < ($Timeout * 100)
		Sleep(10)
		$index += 1
	WEnd

	$res = StringStripWS(RegRead("HKEY_CURRENT_USER\Software\BrokenBot", "Transfer"), 3)
	Return $res
Else
	If StringInStr($Command, "BrokenBotRedLineCheck") Then
		$FullCommand = "1 "
		$FullCommand &= (IsChecked($chkBackground) ? ( "1" ) : ( "0")) & " "
		$FullCommand &= $Command
	ElseIf StringInStr($Command, "BrokenBotReadText") Then
		$FullCommand = "2 "
		$FullCommand &= (IsChecked($chkBackground) ? ( "1" ) : ( "0")) & " "
		$FullCommand &= $Command
	Else
		$FullCommand = "3 "
		$FullCommand &= (IsChecked($chkBackground) ? ( "1" ) : ( "0")) & " "
		$FullCommand &= $Command & " "
		$FullCommand &= (IsChecked($chkSpeedBoost) ? ( "1" ) : ( "0" ))
	EndIf

	$CmdLocal = StringSplit($FullCommand, " ")

	$BackgroundMode = Number($CmdLocal[2])
	$iLeft = Number($CmdLocal[3])
	$iTop = Number($CmdLocal[4])
	$iRight = Number($CmdLocal[5])
	$iBottom = Number($CmdLocal[6])

	If $BackgroundMode = 1 Then
		$iW = Number($iRight) - Number($iLeft)
		$iH = Number($iBottom) - Number($iTop)
		$hDC_Capture = _WinAPI_GetWindowDC(ControlGetHandle($Title, "", "[CLASS:BlueStacksApp; INSTANCE:1]"))
		$hMemDC = _WinAPI_CreateCompatibleDC($hDC_Capture)
		$hLocalHBitmap = _WinAPI_CreateCompatibleBitmap($hDC_Capture, $iW, $iH)
		$hObjectOld = _WinAPI_SelectObject($hMemDC, $hLocalHBitmap)
		DllCall("user32.dll", "int", "PrintWindow", "hwnd", $HWnD, "handle", $hMemDC, "int", 0)
		_WinAPI_SelectObject($hMemDC, $hLocalHBitmap)
		_WinAPI_BitBlt($hMemDC, 0, 0, $iW, $iH, $hDC_Capture, $iLeft, $iTop, 0x00CC0020)
		$hLocalBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hLocalHBitmap)
		_WinAPI_DeleteDC($hMemDC)
		_WinAPI_SelectObject($hMemDC, $hObjectOld)
		_WinAPI_ReleaseDC($HWnD, $hDC_Capture)
	Else
		$aPos = ControlGetPos($Title, "", "[CLASS:BlueStacksApp; INSTANCE:1]")
		If Not IsArray($aPos) Then
			RegWrite("HKEY_CURRENT_USER\Software\BrokenBot", "Transfer", "REG_SZ", "-4")
			Exit
		EndIf
		$tPoint = DllStructCreate("int X;int Y")
		DllStructSetData($tPoint, "X", $aPos[0])
		DllStructSetData($tPoint, "Y", $aPos[1])
		_WinAPI_ClientToScreen(WinGetHandle(WinGetTitle($Title)), $tPoint)
		$BSpos[0] = DllStructGetData($tPoint, "X")
		$BSpos[1] = DllStructGetData($tPoint, "Y")
		$hLocalHBitmap = _ScreenCapture_Capture("", $iLeft + $BSpos[0], $iTop + $BSpos[1], $iRight + $BSpos[0], $iBottom + $BSpos[1])
		$hLocalBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hLocalHBitmap)
	EndIf

	If $CmdLocal[1] = 1 Then
		$mH = $CmdLocal[8]
		$mS = $CmdLocal[9]
		$ci = $CmdLocal[10]
		$cl = $CmdLocal[11]
		$cr = $CmdLocal[12]
		$hCheckHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hLocalBitmap)
		$res = DllCall(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll", "str", "BrokenBotRedLineCheck", "ptr", $hCheckHBitmap, "int", $mH, "int", $mS, "int", $ci, "int", $cl, "int", $cr)
	ElseIf $CmdLocal[1] = 2 Then
		$x = $CmdLocal[8]
		$y = $CmdLocal[9]
		$width = $CmdLocal[10]
		$height = $CmdLocal[11]
		$type = $CmdLocal[12]
		$leftaligned = $CmdLocal[13]
		$reversed = $CmdLocal[14]
		$hClone = _GDIPlus_BitmapCloneArea($hLocalBitmap, $x, $y, $width, $height, _GDIPlus_ImageGetPixelFormat($hLocalBitmap))
		$hCheckHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hClone)
		$res = DllCall(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll", "str", "BrokenBotReadText", "ptr", $hCheckHBitmap, "int", $type, "int", $leftaligned, "int", $reversed)
	ElseIf $CmdLocal[1] = 3 Then
		$Function = $CmdLocal[7]
		$ID = $CmdLocal[8]
		$MaxNum = $CmdLocal[9]
		$Mask = $CmdLocal[10]
		$SpeedBoost = $CmdLocal[11]

		$hCheckHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hLocalBitmap)
		$res = DllCall(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll", "str", $Function, "ptr", $hCheckHBitmap, "int", number($ID), "int", 3, "int", number($MaxNum), "int", number($Mask), "int", number($SpeedBoost))
	EndIf

	_WinAPI_DeleteObject($hCheckHBitmap)
	_WinAPI_DeleteObject($hLocalHBitmap)
	_GDIPlus_BitmapDispose($hLocalBitmap)
	If IsArray($res) Then
		Return $res[0]
	Else
		Return -4
	EndIf
EndIf
EndFunc
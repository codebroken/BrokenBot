; This code was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
; External script that can run necessary image detection functions asynchronously from main autoit code.

; Passed to function: Pointer to BB, pointer to return variable, Background mode, Left, Top, Right, Bottom, Function, ID, MaxNum, Mask, SpeedBoost
#NoTrayIcon

#include <WinAPI.au3>
#include <ScreenCapture.au3>
#include <GDIPlus.au3>


$Title = "BlueStacks App Player"
$HWnD = WinGetHandle($Title)
Dim $BSpos[2]

_GDIPlus_Startup()

$BackgroundMode = Number($CmdLine[2])
$iLeft = Number($CmdLine[3])
$iTop = Number($CmdLine[4])
$iRight = Number($CmdLine[5])
$iBottom = Number($CmdLine[6])

If $BackgroundMode = 1 Then
	$iW = Number($iRight) - Number($iLeft)
	$iH = Number($iBottom) - Number($iTop)
	$hDC_Capture = _WinAPI_GetWindowDC(ControlGetHandle($Title, "", "[CLASS:BlueStacksApp; INSTANCE:1]"))
	$hMemDC = _WinAPI_CreateCompatibleDC($hDC_Capture)
	$hHBitmap = _WinAPI_CreateCompatibleBitmap($hDC_Capture, $iW, $iH)
	$hObjectOld = _WinAPI_SelectObject($hMemDC, $hHBitmap)
	DllCall("user32.dll", "int", "PrintWindow", "hwnd", $HWnD, "handle", $hMemDC, "int", 0)
	_WinAPI_SelectObject($hMemDC, $hHBitmap)
	_WinAPI_BitBlt($hMemDC, 0, 0, $iW, $iH, $hDC_Capture, $iLeft, $iTop, 0x00CC0020)
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hHBitmap)
	_WinAPI_DeleteDC($hMemDC)
	_WinAPI_SelectObject($hMemDC, $hObjectOld)
	_WinAPI_ReleaseDC($HWnD, $hDC_Capture)
Else
	$aPos = ControlGetPos($Title, "", "[CLASS:BlueStacksApp; INSTANCE:1]")
	$tPoint = DllStructCreate("int X;int Y")
	DllStructSetData($tPoint, "X", $aPos[0])
	DllStructSetData($tPoint, "Y", $aPos[1])
	_WinAPI_ClientToScreen(WinGetHandle(WinGetTitle($Title)), $tPoint)
	$BSpos[0] = DllStructGetData($tPoint, "X")
	$BSpos[1] = DllStructGetData($tPoint, "Y")
	$hHBitmap = _ScreenCapture_Capture("", $iLeft + $BSpos[0], $iTop + $BSpos[1], $iRight + $BSpos[0], $iBottom + $BSpos[1])
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hHBitmap)
EndIf

If $CmdLine[1] = 1 Then
	$mH = $CmdLine[8]
	$mS = $CmdLine[9]
	$ci = $CmdLine[10]
	$cl = $CmdLine[11]
	$cr = $CmdLine[12]
	$hCheckHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
	$res = DllCall(@ScriptDir & "\BrokenBot32.dll", "str", "BrokenBotRedLineCheck", "ptr", $hCheckHBitmap, "int", $mH, "int", $mS, "int", $ci, "int", $cl, "int", $cr)
ElseIf $CmdLine[1] = 2 Then
	$x = $CmdLine[8]
	$y = $CmdLine[9]
	$width = $CmdLine[10]
	$height = $CmdLine[11]
	$type = $CmdLine[12]
	$leftaligned = $CmdLine[13]
	$reversed = $CmdLine[14]
	$hClone = _GDIPlus_BitmapCloneArea($hBitmap, $x, $y, $width, $height, _GDIPlus_ImageGetPixelFormat($hBitmap))
	$hCheckHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hClone)
	$res = DllCall(@ScriptDir & "\BrokenBot32.dll", "str", "BrokenBotReadText", "ptr", $hCheckHBitmap, "int", $type, "int", $leftaligned, "int", $reversed)
ElseIf $CmdLine[1] = 3 Then
	$Function = $CmdLine[7]
	$ID = $CmdLine[8]
	$MaxNum = $CmdLine[9]
	$Mask = $CmdLine[10]
	$SpeedBoost = $CmdLine[11]

	$hCheckHBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
	$res = DllCall(@ScriptDir & "\BrokenBot32.dll", "str", $Function, "ptr", $hCheckHBitmap, "int", number($ID), "int", 3, "int", number($MaxNum), "int", number($Mask), "int", number($SpeedBoost))
EndIf

_WinAPI_DeleteObject($hCheckHBitmap)
If IsArray($res) Then
	RegWrite("HKEY_CURRENT_USER\Software\BrokenBot", "Transfer", "REG_SZ", $res[0])
Else
	RegWrite("HKEY_CURRENT_USER\Software\BrokenBot", "Transfer", "REG_SZ", "-4")
EndIf

_WinAPI_DeleteObject($hHBitmap)
_GDIPlus_BitmapDispose($hBitmap)

_GDIPlus_Shutdown()

Exit


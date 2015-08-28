#RequireAdmin
#AutoIt3Wrapper_UseX64=n
#pragma compile(Icon, "BrokenBot.org\images\icons\brokenbot.ico")
#pragma compile(FileDescription, BrokenBot.org - Clash of Clans Bot)
#pragma compile(ProductName, BrokenBot.org - Clash of Clans Bot)
#pragma compile(ProductVersion, 3.3.0)
#pragma compile(FileVersion, 3.3.0)

#include <GUIConstants.au3>

$sBotVersion = "3.3.0"
$sBotTitle = "BrokenBot.org - Break FREE - v" & $sBotVersion

If FileExists(@ScriptDir & "\.developer") Then
	$sBotTitle = "BrokenBot.org - In Development"
EndIf

Global $StartupLanguage = IniRead(@ScriptDir & "\config\default.ini", "config", "language", "English")

If _Singleton($sBotTitle, 1) = 0 Then
	MsgBox(0, "", GetLangText("boxAlreadyRunning"))
	Exit
EndIf

If @AutoItX64 = 1 Then
	MsgBox(0, "", GetLangText("boxCompile1") & @CRLF & GetLangText("boxCompile2"))
	Exit
EndIf

If Not FileExists(@ScriptDir & "\License.txt") Then
	$license = InetGet("http://www.gnu.org/licenses/gpl-3.0.txt", @ScriptDir & "\License.txt")
	InetClose($license)
EndIf

#include "COCBot\Global Variables.au3"
#include "COCBot\GUI Design.au3"
#include "COCBot\Functions.au3"
#include "BrokenBot.org\functions\functions.au3"
#include "COCBot\GUI Control.au3"
#include-once

; Event registration
GUIRegisterMsg($WM_COMMAND, "GUIControl")
GUIRegisterMsg($WM_SYSCOMMAND, "GUIControl")
GUIRegisterMsg(0x0003, "_WinMoved")

; Initialize everything
DirCreate($dirLogs)
DirCreate($dirLoots)
DirCreate($dirAllTowns)
DirCreate($dirDebug)
DirCreate($dirAttack)
DirCreate($dirConfigs)
DirCreate($dirStrat)
readConfig()
applyConfig()
checkupdate()
_PluginDefaults()
_btnRefresh()
_GUICtrlListBox_SetCurSel($lstStrategies, 0)
_lstStrategies()

HotKeySet("^!+p", "_ScreenShot")

$sTimer = TimerInit()
AdlibRegister("SetTime", 1000)

Local $StartImmediately = False
If IsArray($CmdLine) Then
	If $CmdLine[0] = 1 Then $StartImmediately = True
	If $CmdLine[0] = 2 Then
		; Add option to start with specific profile
	EndIf
EndIf

$hHBitmap = _ScreenCapture_Capture("", 0, 0, 860, 720)
$ret = DllCall(@ScriptDir & "\BrokenBot.org\BrokenBot32.dll", "str", "BrokenBotRedLineCheck", "ptr", $hHBitmap, "int", 1, "int", 1, "int", 0, "int", 0, "int", 0)
_WinAPI_DeleteObject($hHBitmap)

If Not IsArray($ret) Then
	If MsgBox($MB_ICONWARNING + $MB_OK, GetLangText("msgMissing"), GetLangText("msgMissing1") & @CRLF & @CRLF & GetLangText("msgMissing2") & @CRLF & @CRLF & GetLangText("msgMissing3") & " " & GetLangText("msgMissing4")) = $IDOK Then
		ShellExecute("https://www.microsoft.com/en-us/download/details.aspx?id=40784")
		DllClose($KernelDLL)
		_GDIPlus_Shutdown()
		_Crypt_Shutdown()
		_GUICtrlRichEdit_Destroy($txtLog)
		Exit
	EndIf
ElseIf $ret[0] = -2 Then
	MsgBox(48, "BrokenBot.org", GetLangText("msgLicense") & @CRLF & @CRLF & "Please visit BrokenBot.org")
EndIf

If IniRead(@LocalAppDataDir & "\BrokenBot.org.ini", "default", "1", "") = "" Or IniRead(@LocalAppDataDir & "\BrokenBot.org.ini", "default", "2", "") = "" Then
	GUICtrlSetImage($btnBBValidate, @ScriptDir & "\images\Resource\bad.bmp")
	GUICtrlSetTip($btnBBValidate, GetLangText("tipBBValidBad"))
Else
	GUICtrlSetData($inpBBPassword, _Decrypt(IniRead(@LocalAppDataDir & "\BrokenBot.org.ini", "default", "2", "")))
	_btnBBValidate()
	GUICtrlSetData($inpBBPassword, "")
EndIf

;Only enable button start after all Initiation done.
GUICtrlSetData($btnStart, GetLangText("btnStart"))
GUICtrlSetState($btnStart, $GUI_ENABLE)
While 1
	If $StartImmediately Then
		$StartImmediately = False
		btnStart()
	EndIf
	Switch TrayGetMsg()
		Case $tiAbout
			MsgBox(64 + $MB_APPLMODAL + $MB_TOPMOST, $sBotTitle, "Clash of Clans Bot" & @CRLF & @CRLF & _
					"Version: " & $sBotVersion & @CRLF & _
					"Released under the GNU GPLv3 license.", 0, $frmBot)
		Case $tiExit
			SetLog(GetLangText("msgExit"), $COLOR_ORANGE)
			ExitLoop
	EndSwitch
	Sleep(50)
WEnd

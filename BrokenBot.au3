#RequireAdmin
#AutoIt3Wrapper_UseX64=n
#pragma compile(Icon, "BrokenBot.org\images\icons\brokenbot.ico")
#pragma compile(FileDescription, BrokenBot.org - Clash of Clans Bot)
#pragma compile(ProductName, BrokenBot.org - Clash of Clans Bot)
#pragma compile(ProductVersion, 2.0)
#pragma compile(FileVersion, 2.0)

$sBotVersion = "2.0 Beta"
$sBotTitle = "BrokenBot.org - Break FREE - v" & $sBotVersion
#include <GUIConstants.au3>

If _Singleton($sBotTitle, 1) = 0 Then
	MsgBox(0, "", "Bot is already running.")
	Exit
EndIf

If @AutoItX64 = 1 Then
	MsgBox(0, "", "Don't Run/Compile Script (x64)! try to Run/Compile Script (x86) to getting this bot work." & @CRLF & _
			"If this message still appear, try to re-install your AutoIt with newer version.")
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
			SetLog("Exiting !!!", $COLOR_ORANGE)
			ExitLoop
	EndSwitch
	Sleep(50)
WEnd

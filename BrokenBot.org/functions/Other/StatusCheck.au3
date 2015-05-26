; This code was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
Func StatusCheck($OnMainScreen = True, $WriteLog = False, $maxDelay = 1)
	; Allows for pauses
	; Checks for main screen if $OnMainScreen=True
	; 	If unable to find zoomed out main screen after resuming, it will continue looping until such time as it does
	; Returns True if bot no longer running after completion.

	If Pause() Then Return
	If $OnMainScreen Then
		While Not checkMainScreen($WriteLog, $maxDelay)
			If BotStopped(False) Then Return True
			SetLog(GetLangText("msgFailedZoomout"), $COLOR_RED)
			SetLog(GetLangText("msgWaitMinute"), $COLOR_RED)
			If _Sleep(6000) Then Return False
		WEnd
		If $PauseBot = True And GUICtrlRead($btnPause) = "Pause" Then btnPause()
		If $PauseBot = False And GUICtrlRead($btnPause) = "Resume" Then btnPause()
	EndIf
	If Pause() Then Return
	If BotStopped($OnMainScreen) Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>StatusCheck


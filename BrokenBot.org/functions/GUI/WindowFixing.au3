; This code was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
Func _WinMoved($hWndGUI, $MsgID, $WParam, $LParam)
	$curWinLoc=WinGetPos($frmBot)
	If ($curWinLoc[0]+208) < (@DesktopWidth/2) Then
		; On left side of screen
		WinMove($frmAttackConfig, "", $curWinLoc[0]+426, $curWinLoc[1], 435, $curWinLoc[3])
		$slideOut = 0x00040001
		$slideIn = 0x00050002
	Else
		; On right side of screen
		WinMove($frmAttackConfig, "", $curWinLoc[0]-439, $curWinLoc[1], 435, $curWinLoc[3])
		$slideOut =0x00040002
		$slideIn = 0x00050001
	EndIf
EndFunc


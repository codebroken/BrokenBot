; This code was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
$frmBugReport = GUICreate(GetLangText("frmBugReport"), 400, 500, -1, -1, $DS_MODALFRAME);, -1, $frmBot)
$lblInstructions = GUICtrlCreateLabel(GetLangText("lblInstructions"), 20, 10, 360, 135)
$lblLog = GUICtrlCreateLabel(GetLangText("lblLog"), 20, 145, 220, 18)
$inpLog = GUICtrlCreateEdit("", 20, 165, 360, 120, $WS_VSCROLL + $ES_MULTILINE + $ES_READONLY)
$lblSettings = GUICtrlCreateLabel(GetLangText("lblSettings"), 20, 290, 150, 18)
$inpSettings = GUICtrlCreateEdit("", 20, 310, 360, 120, $WS_VSCROLL + $ES_MULTILINE + $ES_READONLY)
$btnGitHub = GUICtrlCreateButton(GetLangText("btnGitHub"), 20, 440, 170, 25)
$btnCloseBR = GUICtrlCreateButton(GetLangText("btnCloseBR"), 210, 440, 170, 25)
GUISetState(@SW_HIDE, $frmBugReport)

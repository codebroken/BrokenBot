; This code was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
$frmBugReport = GUICreate("Bug report info", 400, 500, -1, -1, $DS_MODALFRAME);, -1, $frmBot)
$lblInstructions = GUICtrlCreateLabel("You can use the following data to post an issue on the forum. Please examine to make sure you aren't making a new thread for the same issue though. The better the description of the problem the easier it is to actually fix. If your problem involves reading the screen at all, then please manually find where the bot is having an error, use Ctrl+Alt+Shift+P to take a screenshot (saved to debug directory) and post that to forum as well (make sure you block out identifiable information). Your recent log information and settings are included below if you need to copy and paste this info into the issue.", 20, 10, 360, 135)
$lblLog = GUICtrlCreateLabel("Last 100 log lines:", 20, 145, 220, 18)
$inpLog = GUICtrlCreateEdit("", 20, 165, 360, 120, $WS_VSCROLL + $ES_MULTILINE + $ES_READONLY)
$lblSettings = GUICtrlCreateLabel("Settings:", 20, 290, 150, 18)
$inpSettings = GUICtrlCreateEdit("", 20, 310, 360, 120, $WS_VSCROLL + $ES_MULTILINE + $ES_READONLY)
$btnGitHub = GUICtrlCreateButton("Support forum", 20, 440, 170, 25)
$btnCloseBR = GUICtrlCreateButton("Close", 210, 440, 170, 25)
GUISetState(@SW_HIDE, $frmBugReport)
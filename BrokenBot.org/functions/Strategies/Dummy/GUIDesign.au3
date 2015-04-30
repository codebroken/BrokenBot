Func Dummy_LoadGUI()
	; Required prior to making new tabs
	$frmAttackConfig = GUICreate("Attack config panel", 410, 410, -1, -1, $WS_BORDER + $WS_POPUP, $WS_EX_MDICHILD, $frmBot)
	Opt('GUIResizeMode', 802)
	GUISetState(@SW_HIDE, $frmAttackConfig)
	_WinMoved(0, 0, 0, 0)
	GUISwitch($frmAttackConfig)

;	$tabStrat = GUICtrlCreateTab(10, 10, 415, 550)
;
;
;
;	GUI goes in here
;
;
;
;	GUICtrlCreateTabItem("")

	; Load your configuration
	Dummy_LoadConfig()

	; Declare gui-control functions that require WM_COMMAND here
	;Global $PluginEvents[2][3]
	;$PluginEvents[0][0]=1					; Number of functions
	;$PluginEvents[1][0]=$control			; Control name
	;$PluginEvents[1][1]=1 					; Windows notification code
	;$PluginEvents[1][2]="_Function"		; Function to call ie. Dummy_Function

	; Return the handle to the default control you want activated
	Return $defaultcontrol
EndFunc

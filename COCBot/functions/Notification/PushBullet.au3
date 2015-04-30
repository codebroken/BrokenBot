#include <Array.au3>
#include <String.au3>

Func _RemoteControl()
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushBullettoken
	$oHTTP.Open("Get", "https://api.pushbullet.com/v2/pushes?active=true", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
	$Result = $oHTTP.ResponseText

	Local $findstr = StringRegExp($Result, '"title":"BOT')
	If $findstr = 0 Then
		$findstr = StringRegExp($Result, '"title":"bot')
	EndIf
	If $findstr = 0 Then
		$findstr = StringRegExp($Result, '"title":"Bot')
	EndIf
	If $findstr = 0 Then
		$findstr = StringRegExp($Result, '"title":"bOt')
	EndIf
	If $findstr = 0 Then
		$findstr = StringRegExp($Result, '"title":"boT')
	EndIf
	If $findstr = 0 Then
		$findstr = StringRegExp($Result, '"title":"BOt')
	EndIf
	If $findstr = 0 Then
		$findstr = StringRegExp($Result, '"title":"bOT')
	EndIf
	If $findstr = 0 Then
		$findstr = StringRegExp($Result, '"title":"BoT')
	EndIf
	If $findstr = 1 Then
		Local $title = _StringBetween($Result, '"title":"', '"', "", False)
		Local $iden = _StringBetween($Result, '"iden":"', '"', "", False)

		For $x = 0 To UBound($title) - 1
			If $title <> "" Or $iden <> "" Then
				$title[$x] = StringUpper(StringStripWS($title[$x], $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES))
				$iden[$x] = StringStripWS($iden[$x], $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)

				If $title[$x] = "BOT HELP" Then
					SetLog("Your request has been received. Help has been sent")
					_Push("Request for Help", "You can remotely control your bot using the following command format\n\nBot <command> where <command> is:\n\nPause - pause the bot\nResume - resume the bot\nStats - send bot current statistics\nLogs - send the current log file\nHelp - send this help message\n\nEnter the command in the title of the message")
					_DeleteMessage($iden[$x])
				ElseIf $title[$x] = "BOT PAUSE" Then
					If $PauseBot = False Then
						SetLog("Your request has been received. Bot is now paused")
						_Push("Request to Pause", "Your request has been received. Bot is now paused")
						;Local $hWnd = WinWait("[CLASS:AutoIt v3 GUI]", "", 10)
						;WinActivate($hWnd)
						;ControlClick("[CLASS:AutoIt v3 GUI]", "Stop Bot", "[CLASS:Button; TEXT:Stop Bot]", "left", "1")
						;$StBot = 1
						$PauseBot = True
					Else
						SetLog("Your bot is currently paused, no action was taken")
						_Push("Request to Pause", "Your bot is currently paused, no action was taken")
					EndIf
					_DeleteMessage($iden[$x])
				ElseIf $title[$x] = "BOT RESUME" Then
					If $PauseBot = True Then
						SetLog("Your request has been received. Bot is now resumed")
						_Push("Request to Resume", "Your request has been received. Bot is now resumed")
						$PauseBot = False
						;Local $hWnd = WinWait("[CLASS:AutoIt v3 GUI]", "", 10)
						;WinActivate($hWnd)
						;ControlClick("[CLASS:AutoIt v3 GUI]", "Start Bot", "[CLASS:Button; TEXT:Start Bot]", "left", "1")
					Else
						SetLog("Your bot is currently running, no action was taken")
						_Push("Request to Resume", "Your bot is currently running, no action was taken")
					EndIf
					_DeleteMessage($iden[$x])
				ElseIf $title[$x] = "BOT STATS" Then
					SetLog("Your request has been received. Statistics sent")
					_Push("Request for Stats", "Resources at Start\n-Gold:  " & GUICtrlRead($lblresultgoldtstart) & "\n-Elixir:  " & GUICtrlRead($lblresultelixirstart) & "\n-DE:  " & GUICtrlRead($lblresultdestart) & "\n-Trophies:  " & GUICtrlRead($lblresulttrophystart) & "\n\nCurrent Resources \n-Gold:  " & GUICtrlRead($lblresultgoldnow) & "\n-Elixir:  " & GUICtrlRead($lblresultelixirnow) & "\n-DE:  " & GUICtrlRead($lblresultdenow) & "\n-Trophies:  " & GUICtrlRead($lblresulttrophynow) & "\n\nBuildings/Walls Upgrade " & "\n-Wall Upgrade:  " & GUICtrlRead($lblwallupgradecount) & "\n\nTotal Gain\n-Gold Gain:  " & GUICtrlRead($lblresultgoldgain) & "\n-Elixir Gain:  " & GUICtrlRead($lblresultelixirgain) & "\n-DE Gain:  " & GUICtrlRead($lblresultdegain) & "\n-Trophies Gain:  " & GUICtrlRead($lblresulttrophygain) & "\n\nOther Stats\n-Attacked:  " & GUICtrlRead($lblresultvillagesattacked) & "\n-Skipped:  " & GUICtrlRead($lblresultvillagesskipped) & "\n-Search Cost:  " & GUICtrlRead($lblresultsearchcost) & "\n-Bot Run Time:  " & StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
					_DeleteMessage($iden[$x])
				ElseIf $title[$x] = "BOT LOGS" Then
					SetLog("Your request has been received. Log is now sent")
					_PushFile($sLogFileName, "logs", "text/plain; charset=utf-8", "Current Logs", $sLogFileName)
					_DeleteMessage($iden[$x])
				EndIf
				$title[$x] = ""
				$iden[$x] = ""
			EndIf
		Next
	EndIf
EndFunc   ;==>_RemoteControl

Func _PushBullet($pTitle = "", $pMessage = "")
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushBullettoken
	$oHTTP.Open("Get", "https://api.pushbullet.com/v2/devices", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.Send()
	$Result = $oHTTP.ResponseText
	Local $device_iden = _StringBetween($Result, 'iden":"', '"')
	Local $device_name = _StringBetween($Result, 'nickname":"', '"')
EndFunc   ;==>_PushBullet

Func _Push($pTitle, $pMessage)
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushBullettoken
	$oHTTP.Open("Post", "https://api.pushbullet.com/v2/pushes", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	Local $pPush = '{"type": "note", "title": "' & $pTitle & '", "body": "' & $pMessage & '"}'
	$oHTTP.Send($pPush)
EndFunc   ;==>_Push

Func _PushFile($File, $Folder, $FileType, $title, $body)
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushBullettoken
	$oHTTP.Open("Post", "https://api.pushbullet.com/v2/upload-request", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")

	Local $pPush = '{"file_name": "' & $File & '", "file_type": "' & $FileType & '"}'
	$oHTTP.Send($pPush)
	$Result = $oHTTP.ResponseText
	$Result1 = $Result
	Local $upload_url = _StringBetween($Result, 'upload_url":"', '"')
	Local $awsaccesskeyid = _StringBetween($Result, 'awsaccesskeyid":"', '"')
	Local $acl = _StringBetween($Result, 'acl":"', '"')
	Local $key = _StringBetween($Result, 'key":"', '"')
	Local $signature = _StringBetween($Result, 'signature":"', '"')
	Local $policy = _StringBetween($Result, 'policy":"', '"')
	Local $file_url = _StringBetween($Result, 'file_url":"', '"')

	If IsArray($upload_url) And IsArray($awsaccesskeyid) And IsArray($acl) And IsArray($key) And IsArray($signature) And IsArray($policy) Then
		$Result = RunWait(@ScriptDir & "\curl\curl.exe -i -X POST " & $upload_url[0] & ' -F awsaccesskeyid="' & $awsaccesskeyid[0] & '" -F acl="' & $acl[0] & '" -F key="' & $key[0] & '" -F signature="' & $signature[0] & '" -F policy="' & $policy[0] & '" -F content-type="' & $FileType & '" -F file=@"' & @ScriptDir & '\' & $Folder & '\' & $File & '" -o "' & @ScriptDir & '\logs\curl.log"', "", @SW_HIDE)
		If Not FileExists($dirLogs & "curl.log") Then _FileCreate($dirLogs & "curl.log")
		If IsChecked($lblpushbulletdebug) Then
			SetLog('=========================================================================')
			SetLog($Result)
			SetLog($upload_url[0])
			SetLog($acl[0])
			SetLog($key[0])
			SetLog($signature[0])
			SetLog($policy[0])
			SetLog($awsaccesskeyid[0])
			SetLog($file_url[0])
			SetLog($Result1)
			SetLog(@ScriptDir & "\curl\curl.exe -i -X POST " & $upload_url[0] & ' -F awsaccesskeyid="' & $awsaccesskeyid[0] & '" -F acl="' & $acl[0] & '" -F key="' & $key[0] & '" -F signature="' & $signature[0] & '" -F policy="' & $policy[0] & '" -F content-type="' & $FileType & '" -F file=@"' & @ScriptDir & '\' & $Folder & '\' & $File & '" -o "' & @ScriptDir & '\logs\curl.log"')
		EndIf
		If Not FileExists($dirLogs & "curl.log") Then _FileCreate($dirLogs & "curl.log")
		If _FileCountLines(@ScriptDir & '\logs\curl.log') > 8 Then
			Local $hFileOpen = FileOpen(@ScriptDir & '\logs\curl.log')
			Local $sFileRead = FileReadLine($hFileOpen, 8)
			Local $sFileRead1 = StringSplit($sFileRead, " ")
			Local $sLink = $sFileRead1[2]
			Local $findstr1 = StringRegExp($sLink, 'https://')
			If $findstr1 = 1 Then
				$oHTTP.Open("Post", "https://api.pushbullet.com/v2/pushes", False)
				$oHTTP.SetCredentials($access_token, "", 0)
				$oHTTP.SetRequestHeader("Content-Type", "application/json")
				;Local $pPush = '{"type": "file", "file_name": "' & $FileName & '", "file_type": "' & $FileType & '", "file_url": "' & $file_url[0] & '", "title": "' & $title & '", "body": "' & $body & '"}'
				Local $pPush = '{"type": "file", "file_name": "' & $File & '", "file_type": "' & $FileType & '", "file_url": "' & $sLink & '", "title": "' & $title & '", "body": "' & $body & '"}'
				$oHTTP.Send($pPush)
				$Result = $oHTTP.ResponseText
			Else
				If IsChecked($lblpushbulletdebug) Then
					SetLog($hFileOpen)
					SetLog("There is an error and file was not uploaded")
				EndIf
			EndIf
		Else
			If IsChecked($lblpushbulletdebug) Then
				SetLog("Error encountered uploading file.")
			EndIf
		EndIf
	Else
		If IsChecked($lblpushbulletdebug) Then
			SetLog('=========================================================================')
			SetLog('Malformed HTTP response:')
			SetLog($Result)
		EndIf
	EndIf
	If IsChecked($lblpushbulletdebug) Then
		SetLog($Result)
		SetLog("You can paste this in the forum so we can check whether it is PushBullet problem or mine")
		SetLog('=========================================================================')
	EndIf
EndFunc   ;==>_PushFile

Func _DeletePush()
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushBullettoken
	$oHTTP.Open("Delete", "https://api.pushbullet.com/v2/pushes", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
EndFunc   ;==>_DeletePush

Func _DeleteMessage($iden)
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushBullettoken
	$oHTTP.Open("Delete", "https://api.pushbullet.com/v2/pushes/" & $iden, False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
EndFunc   ;==>_DeleteMessage

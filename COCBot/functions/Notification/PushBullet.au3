#include <Array.au3>
#include <String.au3>

Func _RemoteControl()
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushBullettoken
	$oHTTP.Open("Get", "https://api.pushbullet.com/v2/pushes?active=true&limit=3", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.SetTimeouts(5000,5000,5000,5000)
	$oHTTP.Send()
	If @error Then Return
	$Result = $oHTTP.ResponseText

	If StringInStr(StringLower($Result), '"body":"bot') Then
		Local $title = _StringBetween($Result, '"body":"', '"', "", False)
		Local $iden = _StringBetween($Result, '"iden":"', '"', "", False)
		For $x = 0 To UBound($title) - 1
			If $title <> "" Or $iden <> "" Then
				$title[$x] = StringUpper(StringStripWS($title[$x], $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES))
				$iden[$x] = StringStripWS($iden[$x], $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)
				If StringLeft($title[$x], 8) = "BOT HELP" Then
					SetLog(GetLangText("msgPBHelpSent"))
					_Push(GetLangText("pushHRa"), GetLangText("pushHRb"))
					_DeleteMessage($iden[$x])
				ElseIf StringLeft($title[$x], 9) = "BOT PAUSE" And StringStripWS(StringRight($title[$x], StringLen($title[$x]) - 9), 3) = StringUpper(StringStripWS(GUICtrlRead($inppushuser), 3)) Then
					If $PauseBot = False Then
						SetLog(GetLangText("msgPBBotPauseFuture"))
						_Push(GetLangText("pushPRa"), GetLangText("pushPRb"))
						$PauseBot = True
					Else
						SetLog(GetLangText("msgPBNoAction"))
						_Push(GetLangText("pushPRa"), GetLangText("pushPRc"))
					EndIf
					_DeleteMessage($iden[$x])
				ElseIf StringLeft($title[$x], 10) = "BOT RESUME" And StringStripWS(StringRight($title[$x], StringLen($title[$x]) - 10), 3) = StringUpper(StringStripWS(GUICtrlRead($inppushuser), 3)) Then
					If $PauseBot = True Then
						SetLog(GetLangText("msgPBResumed"))
						_Push(GetLangText("pushRRa"), GetLangText("pushRRb"))
						$PauseBot = False
						If GUICtrlRead($btnPause) = "Resume" Then btnPause()
					Else
						SetLog(GetLangText("msgPBRunning"))
						_Push(GetLangText("pushRRa"), GetLangText("pushRRc"))
					EndIf
					_DeleteMessage($iden[$x])
				ElseIf StringLeft($title[$x], 9) = "BOT STATS" And StringStripWS(StringRight($title[$x], StringLen($title[$x]) - 9), 3) = StringUpper(StringStripWS(GUICtrlRead($inppushuser), 3)) Then
					SetLog(GetLangText("msgPBStats"))
					_Push(GetLangText("pushStatRa"), GetLangText("pushStatRb") & GUICtrlRead($lblresultgoldtstart) & GetLangText("pushStatRc") & GUICtrlRead($lblresultelixirstart) & GetLangText("pushStatRd") & GUICtrlRead($lblresultdestart) & GetLangText("pushStatRe") & GUICtrlRead($lblresulttrophystart) & GetLangText("pushStatRf") & GUICtrlRead($lblresultgoldnow) & GetLangText("pushStatRg") & GUICtrlRead($lblresultelixirnow) & GetLangText("pushStatRh") & GUICtrlRead($lblresultdenow) & GetLangText("pushStatRi") & GUICtrlRead($lblresulttrophynow) & GetLangText("pushStatRj") & GetLangText("pushStatRk") & GUICtrlRead($lblwallupgradecount) & GetLangText("pushStatRl") & GUICtrlRead($lblresultgoldgain) & GetLangText("pushStatRm") & GUICtrlRead($lblresultelixirgain) & GetLangText("pushStatRn") & GUICtrlRead($lblresultdegain) & GetLangText("pushStatRo") & GUICtrlRead($lblresulttrophygain) & GetLangText("pushStatRp") & GUICtrlRead($lblresultvillagesattacked) & GetLangText("pushStatRq") & GUICtrlRead($lblresultvillagesskipped) & GetLangText("pushStatRq1") & GUICtrlRead($lblresultsearchdisconnected) & GetLangText("pushStatRr") & GUICtrlRead($lblresultsearchcost) & GetLangText("pushStatRs") & StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
					_DeleteMessage($iden[$x])
				ElseIf StringLeft($title[$x], 8) = "BOT LOGS" And StringStripWS(StringRight($title[$x], StringLen($title[$x]) - 8), 3) = StringUpper(StringStripWS(GUICtrlRead($inppushuser), 3)) Then
					SetLog(GetLangText("msgPBLog"))
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
	Local $Date = @MDAY & "." & @MON & "." & @YEAR
	Local $Time = @HOUR & "." & @MIN & "." & @SEC
	If StringStripWS(GUICtrlRead($inppushuser), 3) <> "" Then $pTitle = "[" & StringStripWS(GUICtrlRead($inppushuser), 3) & "] " & $pTitle
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushBullettoken
	$oHTTP.Open("Post", "https://api.pushbullet.com/v2/pushes", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$pMessage = $Date & " at " & $Time & "\n" & $pMessage
	Local $pPush = '{"type": "note", "title": "' & $pTitle & '", "body": "' & $pMessage & '"}'
	$oHTTP.Send($pPush)
EndFunc   ;==>_Push

Func _PushFile($File, $Folder, $FileType, $title, $body)
	If StringStripWS(GUICtrlRead($inppushuser), 3) <> "" Then $title = "[" & StringStripWS(GUICtrlRead($inppushuser), 3) & "] " & $title
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
					SetLog(GetLangText("msgPBErrorUpload"))
				EndIf
			EndIf
		Else
			If IsChecked($lblpushbulletdebug) Then
				SetLog(GetLangText("msgPBErrorUploading"))
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
		SetLog(GetLangText("msgPBPasteForum"))
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

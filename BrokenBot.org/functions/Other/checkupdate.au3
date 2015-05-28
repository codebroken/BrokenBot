; #FUNCTION# ;===============================================================================
;
; Name...........: _ExtractZip
; Description ...: Extracts file/folder from ZIP compressed file
; Syntax.........: _ExtractZip($sZipFile, $sDestinationFolder)
; Parameters ....: $sZipFile - full path to the ZIP file to process
;                  $sDestinationFolder - folder to extract to. Will be created if it does not exsist exist.
; Return values .: Success - Returns 1
;                          - Sets @error to 0
;                  Failure - Returns 0 sets @error:
;                  |1 - Shell Object creation failure
;                  |2 - Destination folder is unavailable
;                  |3 - Structure within ZIP file is wrong
;                  |4 - Specified file/folder to extract not existing
; Author ........: trancexx, modifyed by corgano
;
;==========================================================================================
Func _ExtractZip($sZipFile, $sDestinationFolder, $sFolderStructure = "")

    Local $i
    Do
        $i += 1
        $sTempZipFolder = @TempDir & "\Temporary Directory " & $i & " for " & StringRegExpReplace($sZipFile, ".*\\", "")
    Until Not FileExists($sTempZipFolder) ; this folder will be created during extraction

    Local $oShell = ObjCreate("Shell.Application")

    If Not IsObj($oShell) Then
        Return SetError(1, 0, 0) ; highly unlikely but could happen
    EndIf

    Local $oDestinationFolder = $oShell.NameSpace($sDestinationFolder)
    If Not IsObj($oDestinationFolder) Then
        DirCreate($sDestinationFolder)
;~         Return SetError(2, 0, 0) ; unavailable destionation location
    EndIf

    Local $oOriginFolder = $oShell.NameSpace($sZipFile & "\" & $sFolderStructure) ; FolderStructure is overstatement because of the available depth
    If Not IsObj($oOriginFolder) Then
        Return SetError(3, 0, 0) ; unavailable location
    EndIf

    Local $oOriginFile = $oOriginFolder.Items();get all items
    If Not IsObj($oOriginFile) Then
        Return SetError(4, 0, 0) ; no such file in ZIP file
    EndIf

    ; copy content of origin to destination
    $oDestinationFolder.CopyHere($oOriginFile, 20) ; 20 means 4 and 16, replaces files if asked

    DirRemove($sTempZipFolder, 1) ; clean temp dir

    Return 1 ; All OK!

EndFunc

; The code below was created for public use by BrokenBot.org and falls under the GPLv3 license.
; This code can be incorporated into open source/non-profit projects free of charge and without consent.
; **NOT FOR COMMERCIAL USE** by any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
; You **MAY NOT SOLICIT DONATIONS** from any project which includes any part of the code in this sub-directory without express written consent of BrokenBot.org
;
Func checkupdate()
	If IsChecked($chkUpdate) Then
		Local $sFilePath = @TempDir & "\update.dat"

		Local $hMasterVersion = InetGet("http://www.brokenbot.org/page.php?p=vcheck", $sFilePath, 3)

		If $hMasterVersion = 0 Then
			SetLog(GetLangText("msgFailedVersion"))
		Else
			$hReadFile = FileOpen($sFilePath)
			While True
				$strReadLine = FileReadLine($hReadFile)
				If @error Then ExitLoop
				If StringInStr($strReadLine, "$sBotVersion") Then
					$split = StringSplit($strReadLine, "&quot;", 1)
					SetLog(GetLangText("msgVersionOnline") & $split[2])
					If $sBotVersion < $split[2] Then
						SetLog(GetLangText("msgUpdateNeeded"))
						InetGet("https://raw.githubusercontent.com/codebroken/BrokenBot/master/changelog.md", @TempDir & "\brokenbotchangelog.md", 3)
						$strReleaseNotes = ""
						$fileopen = FileOpen(@TempDir & "\brokenbotchangelog.md")
						If @error Then SetLog(GetLangText("msgFailedVersion"))
						FileReadLine($fileopen)
						FileReadLine($fileopen)
						While True
							$line = FileReadLine($fileopen)
							If @error Then ExitLoop
							If StringLeft($line, 3) = "###" Then
								If StringReplace($line, "### v", "") <= $sBotVersion Then
									ExitLoop
								EndIf
							EndIf
							If StringStripWS($line, 3) <> "" Then SetLog($line)
							$strReleaseNotes = $strReleaseNotes & StringReplace($line, "### ", "") & @CRLF
						WEnd
						FileClose($fileopen)
						FileDelete(@TempDir & "\brokenbotchangelog.md")
						If MsgBox($MB_OKCANCEL, GetLangText("boxUpdate"), GetLangText("boxUpdate2") & @CRLF & @CRLF & GetLangText("boxUpdate3") &  @CRLF & @CRLF & GetLangText("boxUpdate5") & @CRLF & @CRLF & GetLangText("boxUpdate6") & @CRLF & @CRLF & $strReleaseNotes, 0, $frmBot) = $IDOK Then
							SetLog(GetLangText("msgDownloading"))
							InetGet("https://github.com/codebroken/BrokenBot/archive/master.zip", @TempDir & "\BrokenBot-master.zip", 3)
							If Not FileExists(@TempDir & "\BrokenBot-master.zip") Then
								MsgBox(0, "", GetLangText("boxUpdateError"))
							Else
								SetLog(GetLangText("msgUnzipping"))
								If not FileExists(@TempDir & "\TempUpdateFolder") Then
									DirCreate(@TempDir & "\TempUpdateFolder")
								EndIf
								If _ExtractZip(@TempDir & "\BrokenBot-master.zip", @TempDir & "\TempUpdateFolder") <> 1 Then
									MsgBox(0, "", GetLangText("boxUpdateExtract"))
								Else
									SetLog(GetLangText("msgInstallandRestart"))
									_GDIPlus_Shutdown()
									$fileopen = FileOpen(@TempDir & "\brokenbotupdate.bat", 2)
									FileWriteLine($fileopen, 'xcopy "' & @TempDir & '\TempUpdateFolder\BrokenBot-master\*.*" "' & @ScriptDir & '\" /S /E /Y')
									FileWriteLine($fileopen, 'del "' & @TempDir & '\TempUpdateFolder\*.*" /S /Q')
									FileWriteLine($fileopen, 'del "' & @TempDir & '\BrokenBot-master.zip" /S /Q')
									FileWriteLine($fileopen, 'rd "' & @TempDir & '\TempUpdateFolder" /S /Q')
									FileWriteLine($fileopen, 'start "" /D "' & @ScriptDir & '\" BrokenBot.exe')
									FileClose($fileopen)
									_GUICtrlRichEdit_Destroy($txtLog)
									Run(@ComSpec & ' /c "' & @TempDir & '\brokenbotupdate.bat"', @SystemDir, @SW_SHOW)
									Exit
								EndIf
							EndIf
						EndIf
					ElseIf $sBotVersion > $split[2] Then
						SetLog(GetLangText("msgAheadMaster"))
					Else
						SetLog(GetLangText("msgNoUpdateNeeded"))
					EndIf
					FileClose($hReadFile)
					FileDelete($sFilePath)
					Return
				EndIf
			WEnd
			SetLog(GetLangText("msgFailedVersion"))
			FileClose($hReadFile)
			FileDelete($sFilePath)
		EndIf
	EndIf
EndFunc   ;==>checkupdate


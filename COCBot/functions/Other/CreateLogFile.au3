Func CreateLogFile()
	$sLogPath = $dirLogs & @YEAR & "-" & @MON & "-" & @MDAY & "_" & @HOUR & "." & @MIN & "." & @SEC & ".log"
	$sLogFileName = @YEAR & "-" & @MON & "-" & @MDAY & "_" & @HOUR & "." & @MIN & "." & @SEC & ".log"
	$hLogFileHandle = FileOpen($sLogPath, $FO_APPEND)
EndFunc   ;==>CreateLogFile

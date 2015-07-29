; Outputs stats of battles to log file
Func WriteStats($Skips, $EarnedGold, $EarnedElixir, $EarnedDark)
	$sStatPath = $dirLogs & "Loot Results.csv"
	If Not FileExists($sStatPath) Then
		$hStatFileHandle = FileOpen($sStatPath, $FO_APPEND)
		FileWriteLine($hStatFileHandle, "Time,SearchGold,SearchElixir,SearchDark,SearchTrophy,SearchTHLvl,SearchDead,SearchInside,NukeAttack,Skips,EarnedGold,EarnedElixir,EarnedDark")
	Else
		$hStatFileHandle = FileOpen($sStatPath, $FO_APPEND)
	EndIf
	FileWriteLine($hStatFileHandle, @YEAR & "-" & @MON & "-" & @MDAY & "_" & @HOUR & "." & @MIN & "." & @SEC & "," & $searchGold & "," & $searchElixir & "," & $searchDark & "," & $searchTrophy & "," & $searchTH & "," & $searchDead & "," & $THLoc & "," & $NukeAttack & "," & $Skips & "," & $EarnedGold & "," & $EarnedElixir & "," & $EarnedDark)
	FileClose($hStatFileHandle)
EndFunc   ;==>WriteStats

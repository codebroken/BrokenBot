Func LootLogCleanup($no_rotator)
	Local $dir_list[3] = ["Loots", "logs", "Debug"]
	For $l = 0 To UBound($dir_list) - 1
		Local $dir = @ScriptDir & "\" & $dir_list[$l]
		If FileExists($dir) == 0 Then
			SetLog(GetLangText("msgDirNotFound") & $dir, $COLOR_RED)
			ContinueLoop
		EndIf
		Local $fArray = _FileListToArrayRec($dir, "*", $FLTAR_FILESFOLDERS, $FLTAR_RECUR, $FLTAR_SORT, $FLTAR_FULLPATH)
		If UBound($fArray) == 0 Then ContinueLoop
		Local $data_size = $fArray[0]
		If $data_size > $no_rotator Then
			For $i = 1 To Number($data_size - $no_rotator)
				Local $file_path = $fArray[$i]
				If Not FileDelete($file_path) Then
					SetLog(GetLangText("msgFailDel") & $file_path, $COLOR_RED)
				EndIf
			Next
		EndIf
	Next
EndFunc   ;==>LootLogCleanup


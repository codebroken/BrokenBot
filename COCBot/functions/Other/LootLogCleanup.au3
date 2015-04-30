Func LootLogCleanup($no_rotator)
	local $dir_list[3] = ["Loots", "logs", "Debug"]
	For $l = 0 To UBound($dir_list) - 1
		local $dir = @ScriptDir & "\" & $dir_list[$l]
		if FileExists($dir) == 0 then
			SetLog("dir not found - " & $dir, $COLOR_RED)
			continueloop
		endif
		local $fArray = _FileListToArrayRec($dir, "*", $FLTAR_FILESFOLDERS, $FLTAR_RECUR, $FLTAR_SORT, $FLTAR_FULLPATH )
		if UBound($fArray) == 0 Then continueloop
		local $data_size = $fArray[0]
		if $data_size > $no_rotator Then
			For $i = 1 To Number($data_size - $no_rotator)
				local $file_path = $fArray[$i]
				If Not FileDelete($file_path) Then
					SetLog("Fail to del " & $file_path, $COLOR_RED)
				EndIf
			Next
		endif
	Next
EndFunc


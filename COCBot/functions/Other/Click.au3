Func Click($x, $y, $times = 1, $speed = 0, $CenteredOn = 0, $BufferDist = 20)
	If $CenteredOn = 0 Then
		If $times <> 1 Then
			For $i = 0 To ($times - 1)
				ControlClick($Title, "", "", "left", "1", $x, $y)
				If _Sleep($speed, False) Then ExitLoop
			Next
		Else
			ControlClick($Title, "", "", "left", "1", $x, $y)
		EndIf
	Else
		If $ichkAvoidEdge = 1 Then
			RedLineDeploy($x, $y, $times, $speed, $CenteredOn, $BufferDist)
		Else
			If $times <> 1 Then
				For $i = 0 To ($times - 1)
					ControlClick($Title, "", "", "left", "1", $x, $y)
					_GDIPlus_GraphicsDrawEllipse($Buffer, $x-2, $y - 2, 4, 4, $Pen)
					If _Sleep($speed, False) Then ExitLoop
				Next
			Else
				ControlClick($Title, "", "", "left", "1", $x, $y)
				_GDIPlus_GraphicsDrawEllipse($Buffer, $x-2, $y - 2, 4, 4, $Pen)
			EndIf
		EndIf
	EndIf
EndFunc   ;==>Click

; ClickP : takes an array[2] (or array[4]) as a parameter [x,y]
Func ClickP($point, $howMuch = 1, $speed = 0)
	Click($point[0], $point[1], $howMuch, $speed)
EndFunc   ;==>ClickP

Func _Random_Gaussian($nMean, $nSD)
	Do
		$nX = ((2 * Random()) - 1)
		$nY = ((2 * Random()) - 1)
		$nR = ($nX ^ 2) + ($nY ^ 2)
	Until $nR < 1
	$nGaus = ($nX * (Sqrt((-2 * (Log($nR) / $nR)))))
	Return ($nGaus * $nSD) + $nMean
EndFunc   ;==>_Random_Gaussian

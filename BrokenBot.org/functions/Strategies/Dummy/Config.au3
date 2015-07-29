Func Dummy_LoadConfig()

EndFunc   ;==>Dummy_LoadConfig

Func Dummy_SaveConfig($configFile)
	IniWrite($configFile, "plugin", "name", "Dummy")

EndFunc   ;==>Dummy_SaveConfig

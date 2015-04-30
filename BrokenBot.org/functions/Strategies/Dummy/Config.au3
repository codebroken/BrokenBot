Func Dummy_LoadConfig()

EndFunc

Func Dummy_SaveConfig($configFile)
	IniWrite($configFile, "plugin", "name", "Dummy")

EndFunc

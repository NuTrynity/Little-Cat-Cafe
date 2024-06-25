extends Node

func save_settings():
	var options : Options = Options.new()
	
	options.sfx = GlobalScript.sfx_volume
	options.music = GlobalScript.music_volume
	options.window_mode = GlobalScript.window_mode
	ResourceSaver.save(options, "user://options.tres")

func load_settings():
	var options : Options = load("user://options.tres") as Options
	
	GlobalScript.sfx_volume = options.sfx
	GlobalScript.music_volume = options.music
	GlobalScript.window_mode = options.window_mode

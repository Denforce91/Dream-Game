extends Label

func _process(_delta: float) -> void:
	# Read directly from the global TimeManager singleton
	text = TimeManager.get_formatted_time_string()

	# Keep your text line
	text = TimeManager.get_formatted_time_string()
	

extends Control

# Drag and drop your actual Save/Load script node here from your Scene Tree
@onready var save_load_system: Node = SaveLoad 

# Drag and drop your slot manager script node here
@onready var slot_manager: Node = $"res://Scripts/save_slot.gd"

func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause() -> void:
	get_tree().paused = !get_tree().paused
	visible = get_tree().paused
	
	if get_tree().paused:
		show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# --- Button Connections ---

func _on_resume_button_pressed() -> void:
	toggle_pause()

func _on_save_button_pressed() -> void:
	# 1. Ask your slot script what the current active slot is
	if slot_manager and save_load_system:
		var current_slot = slot_manager.get_current_slot() # Or whatever variable holds it
		print("Saving open world progress to: ", current_slot)
		
		# 2. Tell your save script to write the file
		save_load_system.save_game_data(current_slot)
	else:
		print("Error: Missing reference to SaveLoad or SaveSlot scripts!")

func _on_load_button_pressed() -> void:
	if slot_manager and save_load_system:
		var current_slot = slot_manager.get_current_slot()
		print("Loading world state from: ", current_slot)
		
		save_load_system.load_game_data(current_slot)
		toggle_pause() # Unpause immediately after loading
	else:
		print("Error: Missing reference to SaveLoad or SaveSlot scripts!")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

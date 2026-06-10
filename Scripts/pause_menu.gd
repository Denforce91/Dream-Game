extends Control;

@onready var resume_button : Button = $Menu_Options/Resume;
@onready var save_button : Button = $Menu_Options/Save;
@onready var load_button : Button = $Menu_Options/Load;
@onready var quit_button : Button = $Menu_Options/Quit;

func _ready() -> void:
	hide()
	resume_button.connect("pressed", resume);
	save_button.connect("pressed", manual_save);
	load_button.connect("pressed", manual_load);
	quit_button.connect("pressed", quit);

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
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

func resume() -> void:
	toggle_pause()

func manual_save() -> void:
		SaveLoad.save_data();
		print("SAVED DATA TO " + str(SaveLoad.save_slot) + " | " + SaveLoad.selected_save_slot_dir)

func manual_load() -> void:
		SaveLoad.load_data();
		toggle_pause()

func quit() -> void:
	get_tree().quit()

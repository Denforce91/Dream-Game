extends Button;

@export var slot_id : int = 0;

func _ready() -> void:
	self.connect("button_down", select_slot);
	SaveLoad.connect("swapped", update_display);
	update_display(SaveLoad.save_slot);

func select_slot() -> void:
	SaveLoad.change_slot(slot_id);

func update_display(id : int) -> void:
	var dict := SaveLoad.pull_dataset_from_non_active_slot(slot_id, "DICT")

	if dict.is_empty():
		text = "Save Slot " + str(slot_id) + " --- EMPTY"
		return
	if not dict.has("LAST_PLAYED"):
		text = "Save Slot " + str(slot_id) + " --- EMPTY"
		return

	# Slot has LAST_PLAYED but it's null or empty
	var get_time = dict["LAST_PLAYED"]
	if typeof(get_time) != TYPE_DICTIONARY:
		text = "Save Slot " + str(slot_id) + " --- EMPTY"
		return

	# Now it's safe to read the date
	var loaded : String = "";
	if id == slot_id:
		loaded = " (CURRENT)"

	var date : String = str(get_time["day"]) + "/" + str(get_time["month"]) + "/" + str(get_time["year"])
	text = "Save Slot " + str(slot_id) + " --- " + date + loaded

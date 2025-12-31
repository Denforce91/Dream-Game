extends Control;

func _ready() -> void:
	for slot in get_children():
		slot.connect("button_down", select_slot)



func select_slot() -> void:
	pass
	


func _on_back_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

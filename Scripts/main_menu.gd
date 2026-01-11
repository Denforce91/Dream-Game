extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Interface/save_select.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Interface/options_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_achievements_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Interface/achievements.tscn")


func _on_extras_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Interface/extras.tscn")

class_name Save_Load extends Node

var save_slot : int = 0;
var selected_save_slot_dir : String = save_slot_directories[0]
const save_slot_directories : Array[String] = [
	"res://Slot1", "res://Slot2","res://Slot3",
	"res://Slot4","res://Slot5","res://Slot6",
	"res://Slot7","res://Slot8","res://Slot9",
	"res://Slot10","res://Slot11","res://Slot12",
	"res://Slot13","res://Slot14","res://Slot15",
	"res://Slot16"]

func save_data() -> void:
	pass

func load_data() -> void:
	pass

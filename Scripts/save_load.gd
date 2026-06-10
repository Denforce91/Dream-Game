class_name Save_Load extends Node

signal swapped(slot : int);

##THIS FILE CAN BE REMOTELY ACCESSED FROM ANY GDSCRIPT FILE BY USING THE 'SaveLoad' KEYWORD
#THIS IS A GLOBAL SCRIPT THAT IS ALWAYS ACTIVE AND RUNS ALONGSIDE THE MAIN SCENE TREE

#Holds the data during runtime
#Unfortunately when new values are added to the lists, then all prior save files will be corrupted,
#meaning that you will have to delete them after every update or else the game will crash. The location
#where the save files are kept differs across operating systems and versions, meaning that you'll 
#have to go find the location manually to delete them. -Q
var general_data : Dictionary[String, int] = {
	"TEST" : 0
};
var int_data : Dictionary[String, int] = {
	"TEST" : 0
};
var string_data : Dictionary[String, String] = {
	"TEST" : "TEST"
};
var dict_data : Dictionary[String, Dictionary] = {
	"LAST_PLAYED" : {}
}

#Variables pertaining to current save slot and the directories of all save slots
var save_slot : int = 0; #Current save slot number
var selected_save_slot_dir : String = save_slot_directories[0]; #Curret save slot path
const save_slot_directories : Array[String] = [
	"user://Slot1.save", "user://Slot2.save", "user://Slot3.save",
	"user://Slot4.save","user://Slot5.save","user://Slot6.save",
	"user://Slot7.save","user://Slot8.save","user://Slot9.save",
	"user://Slot10.save","user://Slot11.save","user://Slot12.save",
	"user://Slot13.save","user://Slot14.save","user://Slot15.save",
	"user://Slot16.save", "user://Slot17.save", "user://Slot18.save",
	"user://Slot19.save", "user://Slot20.save"]; #Directories of all save slots

func _ready() -> void:
	save_data();
	load_data();
	
	print("BEGUN");

#Saves all data to the current save file
func save_data() -> void:
	var config = ConfigFile.new();
	
	#lamba function for saving data sets
	var save_data = func(data_set : Dictionary, sector : String) -> void:
		for index in data_set:
			config.set_value(sector, str(index), data_set.get(index));
	
	var datetime = Time.get_datetime_dict_from_system();
	dict_data["LAST_PLAYED"] = datetime;
	
	#Each individual dataset dictionary must be included here
	save_data.call(general_data, "GEN");
	save_data.call(int_data, "INT");
	save_data.call(string_data, "STR");
	save_data.call(dict_data, "DICT")
	
	config.save(selected_save_slot_dir);
	print("SUCCESSFULLY SAVED!");


#Loads all data from the current save file
func load_data() -> void:
	var config = ConfigFile.new();
	var result = config.load(selected_save_slot_dir);
	
	#lamba function for loading data set
	var load_data = func(data_set : Dictionary, sector : String):
		for index in data_set.keys():
			data_set[index] = config.get_value(sector, index)
		return data_set;
	
	if (result == OK):
		#Each individual dataset dictionary must be included here
		general_data = load_data.call(general_data, "GEN");
		int_data = load_data.call(int_data, "INT");
		string_data = load_data.call(string_data, "STR");
		dict_data = load_data.call(dict_data, "DICT");
		
	print("SUCCESSFULLY LOADED!");


#Changes the current data slot
#All for current save file is saved, the save file path is updated,
#and the all data from the new save file is loaded in its place
func change_slot(new_slot : int = 0) -> void:
	save_data();
	print("SWITCH FROM SLOT " + str(save_slot) + " TO " + str(new_slot));
	save_slot = new_slot;
	selected_save_slot_dir = save_slot_directories[new_slot]
	load_data();
	emit_signal("swapped", new_slot);

#Pulls a dataset dictionary from any save slot without switching to it.
#Rquires only the dataset sector and save slot id
func pull_dataset_from_non_active_slot(slot : int, sector : String) -> Dictionary:
	var path = save_slot_directories[slot]
	var config = ConfigFile.new();
	var result = config.load(path);

	var load_data = func(sector : String):
		var new_dict : Dictionary = {};
		for index in config.get_section_keys(sector):
			new_dict[index] = config.get_value(sector, index)
		return new_dict;
		
	if (result == OK):
		return load_data.call(sector);
	else:
		return {};

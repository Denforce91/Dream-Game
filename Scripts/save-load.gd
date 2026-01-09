class_name Save_Load extends Node

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
var stats : Dictionary[String, int] = {
	"TEST" : 0
};
var settings : Dictionary[String, String] = {
	"TEST" : "TEST"
};

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
	
	#Each individual dataset dictionary must be included here
	save_data.call(general_data, "GEN");
	save_data.call(stats, "STAT");
	save_data.call(settings, "SETTINGS");
	
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
		stats = load_data.call(stats, "STAT");
		settings = load_data.call(settings, "SETTINGS");
		
		print("SUCCESSFULLY LOADED!");


#Changes the current data slot
#All for current save file is saved, the save file path is updated,
#and the all data from the new save file is loaded in its place
func change_slot(slot : int = 0) -> void:
	save_data();
	save_slot = slot;
	save_slot_directories[save_slot]
	load_data();

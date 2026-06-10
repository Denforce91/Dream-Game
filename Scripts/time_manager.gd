extends Node

# --- Master Calendar Variables ---
var current_hour: int = 8
var current_minute: int = 0
var current_day: int = 23
var current_month: int = 8
var current_year: int = 2026

const MONTH_NAMES = {
	1: "January", 2: "February", 3: "March", 4: "April", 
	5: "May", 6: "June", 7: "July", 8: "August", 
	9: "September", 10: "October", 11: "November", 12: "December"
}

func get_formatted_time_string() -> String:
	var month_name: String = MONTH_NAMES.get(current_month, "August")
	return "%s %d, %d | %02d:%02d" % [month_name, current_day, current_year, current_hour, current_minute]

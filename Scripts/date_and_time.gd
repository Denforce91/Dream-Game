extends DirectionalLight3D

# --- Time Settings ---
@export var day_length_minutes: float = 10.0 # How many real minutes a full game day takes
@export var fast_forward_multiplier: float = 60.0 # How many times faster time moves when waiting
@export var starting_hour: int = 8           # Game starts at 8:00 AM

# --- Internal Trackers ---
var total_time: float = 0.0

func _ready() -> void:
	add_to_group("calendar_sun")
	
	var day_length_seconds: float = day_length_minutes * 60.0
	
	# Calculate days offset to reach August 23rd
	var days_offset: int = (7 * 30) + 22
	var hour_offset_pct: float = starting_hour / 24.0
	
	# Set the total starting time in real-world seconds
	total_time = (days_offset + hour_offset_pct) * day_length_seconds

func _process(delta: float) -> void:
	# 1. Determine time speed (Normal vs Fast Forward)
	var current_speed_multiplier: float = 1.0
	if Input.is_action_pressed("fast_forward"):
		current_speed_multiplier = fast_forward_multiplier
		
	# 2. Advance time based on delta and speed multiplier
	total_time += delta * current_speed_multiplier
	
	# 3. Calculate total length of a day in real-world seconds
	var day_length_seconds: float = day_length_minutes * 60.0
	
	# 4. Figure out exactly where we are in the 24-hour cycle (0.0 to 1.0)
	var time_percentage: float = fmod(total_time, day_length_seconds) / day_length_seconds
	
	# 5. Update calendar numbers inside the global TimeManager singleton
	_update_calendar_values(time_percentage)
	
	# 6. Visually rotate the sun accurately
	# (time_percentage * 2.0 * PI) rotates the sun a full 360 degrees.
	# Adding PI flips it so 0.0 is midnight.
	# Subtracting (PI / 2.0) shifts the calculation offset so 12:00 is straight overhead.
	rotation.x = (time_percentage * 2.0 * PI) + PI - (PI / 2.0)

func _update_calendar_values(time_pct: float) -> void:
	var raw_hours: float = time_pct * 24.0
	
	# Directly push the numbers into our global TimeManager script
	TimeManager.current_hour = int(raw_hours)
	TimeManager.current_minute = int((raw_hours - TimeManager.current_hour) * 60.0)
	
	var total_days_passed: int = int(total_time / (day_length_minutes * 60.0)) + 1
	
	# Simple 30-day month calendar logic
	TimeManager.current_day = ((total_days_passed - 1) % 30) + 1
	var total_months_passed: int = (total_days_passed - 1) / 30
	TimeManager.current_month = (total_months_passed % 12) + 1
	TimeManager.current_year = 2026 + (total_months_passed / 12)

extends Node

onready var progress_bar = $cooldown_progress
onready var timer = $timer
var current_value = 0
var start_value = 100
var depleted_value = 0
var cooldown = 0.1

func _ready():
	progress_bar.set_value(start_value)

func _process(delta):
	if !timer.is_stopped():
		progress_bar.value = get_percent_timer()
	else:
		progress_bar.value = start_value

func start_cooldown(time):
	cooldown = time
	timer.start(cooldown)
	deplete_bar()

func deplete_bar():
	progress_bar.value = depleted_value

func get_percent_timer():
	var percent = 100 - (timer.time_left / (cooldown * 0.01))
	return percent

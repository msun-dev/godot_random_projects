extends Area2D

export(String, "test", "first_one", "second_one") var dialog_name
export(String) var cutscene_name = null
export(bool) var active = false
export(float) var dialog_delay_time = 0

onready var timer = $delay

signal play_dialog(dialog_name)

func _ready():
	#timer.set_wait_time(dialog_delay_time)
	self.connect("play_dialog", get_tree().get_root().get_node("game"), "_on_play_dialog")

func _process(delta):
	if dialog_delay_time != 0:
		pass

func _on_dialog_trigger_body_entered(body):
	#check_cutscene(cutscene_name)
	if active && body.name == "cat":
		emit_signal("play_dialog", dialog_name)
		active = false

func check_cutscene(scene_name):
	if not scene_name:
		print("no cutscene ELEG")

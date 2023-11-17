extends Node

func _ready():
	pass

func _process(delta):
	restart_level_button()

func restart_level_button():
	if Input.is_action_just_pressed("restart_level"):
		get_tree().reload_current_scene()

func play_dialog(dialog_name):
	#freeze everything that should be freezed
	var dialog = Dialogic.start(dialog_name, false)
	$dialog_layer.add_child(dialog)

func _on_play_dialog(set_name):
	play_dialog(set_name)

#func when dialog ended():
#	yabidi-pabidi, dialog has ended so now you should unfreeze everythin 
#	that is freezed

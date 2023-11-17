extends Node

export(NodePath) var dialog_layer
onready var layer = $UI/layer1
onready var player_node = $things/player/cat

func _ready():
	pass

func _process(delta):
	pass

func play_dialog(dialog_name):
	#freeze everything that should be freezed
	var new_dialog = Dialogic.start(dialog_name, false)
	layer.add_child(new_dialog)
	new_dialog.connect("timeline_end", self, "_after_dialog")

func _on_play_dialog(set_name):
	play_dialog(set_name)
	$things/player/cat.set_physics_process(false)

func _after_dialog(timeline_name):
	$things/player/cat.set_physics_process(true)

func remove_dialogs():
	for n in layer.get_children():
		n.queue_free()

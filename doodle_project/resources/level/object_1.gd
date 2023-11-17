extends Node2D

signal dialog_start(name_dialog)

onready var animation_player = $animation_player
onready var audio_player = $audio_player

export(bool) var will_play_dialog
export(String, "intro", "outro") var dialog_name

func _ready(): #рандом питч и коннектим к ноду game, если в редакторе стоит true
	random_pitch()
	if will_play_dialog: self.connect("dialog_start", get_tree().get_root().get_node("game"), "_on_play_dialog")

func interact(): #вызываем функции при взаимодействии с объектом
	play_dialog()
	destroy()

func random_pitch(): #делаем рандомный питч, чтоб не сдохнуть со скуки
	randomize()
	var pitch_random = rand_range(0, 0.25)
	audio_player.set_pitch_scale(1 + pitch_random)

func destroy(): #уничтожение пота и удаление коллизии
	animation_player.play("break")
	audio_player.play()
	$colission.queue_free()

func play_dialog(): #проигрываем диалог, если в редакторе стоит true
	if will_play_dialog: emit_signal("dialog_start", dialog_name) 

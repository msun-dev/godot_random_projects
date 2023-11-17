extends Node

onready var parent_node = get_parent()
onready var cooldown_timer = $shoot_timer
export (PackedScene) onready var bullet_node

var bullet_speed = 200
var bullet_distance = 10
export (float) var bullet_lifetime = 5
export (float) var cooldown = 0.5
onready var cooldown_gui = get_tree().get_root().get_node("game/UI/layer1/gui_attack_cooldown")

func _ready():
	pass

func _process(delta):
	pass

func instance_bullet():
	var instance = bullet_node.instance()
	add_child(instance)
	var parent_rotated_right = get_parent_rotation()
	instance.set_lifetime(bullet_lifetime)
	instance.set_position(set_relative_position(parent_rotated_right))
	instance.set_movement(set_direction(parent_rotated_right))

func get_parent_rotation():
	return parent_node.get_side()

func set_direction(rotated_right):
	if rotated_right:
		return bullet_speed
	else:
		return -bullet_speed

func set_relative_position(rotated_right):
	if rotated_right:
		return parent_node.get_position() + Vector2(bullet_distance, 0)
	else:
		return parent_node.get_position() - Vector2(bullet_distance, 0)

func reset_cooldowna():
	cooldown_timer.stop()

func shoot():
	if cooldown_timer.is_stopped():
		cooldown_gui.start_cooldown(cooldown)
		instance_bullet()
		cooldown_timer.start(cooldown)

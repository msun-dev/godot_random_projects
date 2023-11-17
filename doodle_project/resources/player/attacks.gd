extends Node2D

func _ready():
	pass

func check_left_box():
	attack($left_attack)

func check_right_box():
	attack($right_attack)

func attack(node):
	var areas = node.get_overlapping_bodies()
	for area in areas:
		#if area.has_method("interact()"):
			area.get_parent().interact()

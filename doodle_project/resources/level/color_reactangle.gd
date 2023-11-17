extends ColorRect

var blue_shader = preload("res://GameBoyFilterMaterial_Blue.tres")
var orange_shader = preload("res://GameBoyFilterMaterial_Orange.tres")
var invert_shader = preload("res://invert_colors.tres")

var materials = [
	null,
	invert_shader,
	blue_shader,
	orange_shader
] 

var counter = 0

func _ready():
	apply_next_shader()

func _process(delta):
	if Input.is_action_just_pressed("next_shader"):
		apply_next_shader()

func apply_next_shader():
	self.set_material(materials[counter%materials.size()])
	counter += 1

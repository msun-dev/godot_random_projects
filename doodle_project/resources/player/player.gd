extends KinematicBody2D

const move_speed = 150
var velocity = Vector2.ZERO
var facing_right = true
var attacking = false

onready var animation_player = $animation_player
onready var sprite = $sprite

func _ready():
	pass

func _physics_process(delta):
	if !attacking:
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		input_vector = input_vector.normalized()
		
		if facing_right and input_vector.x < 0: flip()
		if !facing_right and input_vector.x > 0: flip()
#		var facing_last = facing_right
#		facing_right = bool(0 - (input_vector.x + abs(input_vector.x))) EleGiggle
		
		if input_vector != Vector2.ZERO:
			velocity = input_vector * move_speed
			animation_player.play("walking_anim_right_" + str(facing_right))
		else:
			velocity = Vector2.ZERO
			animation_player.play("idle_anim_right_" + str(facing_right))
		
		if Input.is_action_just_pressed("attack"):
			animation_player.play("attack_anim_right_" + str(facing_right))
			attacking = true
		move_and_slide(velocity)
	else:
		pass
	
func flip():
	facing_right = !facing_right

func attack_ended():
	attacking = false

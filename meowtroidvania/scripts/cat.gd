extends KinematicBody2D

onready var sprite_node = $sprite
onready var anim_player = $animation
onready var coyote_timer = $coyote_timer
onready var stagger_timer = $stagger_timer
onready var gun = $gun

var double_jump_unlock = true
var long_attack_unlock = true

var gravity = 20
var move_speed = 100
var jump_force = 300
var max_fall_speed = 225

var y_velocity = 0
var movement = Vector2.ZERO

export(float) var stagger_time = 1
var knockback_move = -50
var knockback_jump = -350

var facing_right = true
var movement_allowed = true
var double_jump_allowed = false
var jumped = false

var grounded = false
var on_ceiling = false
var on_wall = false

enum {IDLE, MOVE, AIR, SLEEP, STAGGER}
var state = IDLE

func _ready():
	get_proprts()
	if !grounded:
		state = AIR

func _physics_process(_delta):
	#print(facing_right, movement.x)
	print(movement.y)
	match state:
		IDLE:
			play_anim("idle")
			
			check_shoot()
			
			if not double_jump_allowed:
				double_jump_allowed = !double_jump_allowed
			
			#movement = Vector2.ZERO
			
			check_input()

		MOVE:
			play_anim("walk")
			
			check_shoot()
			
			if not double_jump_allowed:
				double_jump_allowed = !double_jump_allowed
			
			#movement = Vector2.ZERO
			movement.x = get_ad_input()
			
			sprite_rotation()
			
			y_velocity += gravity
			
			if movement.x == 0:
				state = IDLE

			get_jump_input()
			
			if grounded and y_velocity >=  5:
				y_velocity = 5
			
			if not is_on_floor():
				coyote_timer.start()
				movement.x = 0
				state = AIR
				grounded = false

			movement.y = y_velocity
			movement.x *= move_speed
			
# warning-ignore:return_value_discarded
			move_and_slide(movement, Vector2.UP)
			
			get_proprts()
			
		AIR:
			if y_velocity > 0:
				play_anim("air_down")
			if y_velocity < 0:
				play_anim("air_up")
			
			#movement = Vector2.ZERO
			movement.x = get_ad_input()
			
			get_jump_input()
			
			check_shoot()
			
			sprite_rotation()
			
			if y_velocity >= max_fall_speed and not grounded:
				y_velocity = max_fall_speed

			if on_ceiling:
				y_velocity = 5

			movement.y = y_velocity
			movement.x *= move_speed

# warning-ignore:return_value_discarded
			move_and_slide(movement, Vector2.UP)
			
			y_velocity += gravity
			
			get_proprts()
			
			if grounded:
				state = IDLE

		SLEEP:
			pass

		STAGGER:
			play_anim("stagger")
			movement.y = y_velocity
			move_and_slide(movement, Vector2.UP)
			y_velocity += gravity
			if y_velocity >= max_fall_speed:
				y_velocity = max_fall_speed
			if is_on_ceiling():
				y_velocity = 5

func check_input():
	if movement_allowed && get_ad_input() != 0: 
		state = MOVE
	y_velocity = 0
	get_jump_input()

func get_jump_input():
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() || !coyote_timer.is_stopped():
			coyote_timer.stop()
			jump()
			return
		if double_jump_allowed:
			double_jump_allowed = false
			jump()
			return
	
func jump():
	y_velocity = -jump_force
	state = AIR
	grounded = false

func get_ad_input():
	if movement_allowed:
		var input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		return input
	else:
		return 0

func get_proprts():
	on_ceiling = is_on_ceiling()
	grounded = is_on_floor()
	on_wall = is_on_wall()

func sprite_rotation():
	if facing_right and movement.x < 0:
		flip()
	if !facing_right and movement.x > 0:
		flip()

func flip():
	facing_right = !facing_right
	sprite_node.flip_h = !sprite_node.flip_h

func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)

func set_stagger(from_right_side):
	if state != STAGGER:
		state = STAGGER
		stagger_timer.start(stagger_time)
		if from_right_side:
			movement.x = -knockback_move
		else:
			movement.x = knockback_move
		y_velocity = knockback_jump
		double_jump_allowed = true

func get_state():
	return state

func get_side():
	return facing_right

func check_shoot():
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	gun.shoot()

func _on_stagger_timer_timeout():
	state = AIR

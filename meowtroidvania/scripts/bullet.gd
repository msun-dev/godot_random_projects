extends Area2D

onready var parent_node = get_parent()
onready var lifetime_timer = $lifetime_timer
onready var explosion_timer = $explosion_timer
onready var trail_particles = $trail_emitter
onready var explosion_particles = $explosion_emitter
onready var sprite = $animated_sprite

var movement = Vector2.ZERO

func _ready():
	pass

func _physics_process(_delta):
	position += movement * _delta

func set_movement(speed):
	movement.x = speed

func _on_bullet_body_entered(body):
	if body.name == "ground_tilemap":
		#reset_gun_timer()
		explode()

func set_lifetime(time):
	lifetime_timer.start(time)

func reset_gun_timer():
	parent_node.reset_cooldown()

func explode():
	set_physics_process(false)
	$hitbox.call_deferred("set_disabled", true)
	trail_particles.set_emitting(false)
	sprite.hide()
	explosion_particles.set_emitting(true)
	explosion_timer.start(explosion_particles.get_lifetime())

func _on_timer_timeout():
	explode()

func _on_explosion_timer_timeout():
	queue_free()

extends Area2D

func _process(delta):
	pass


func _on_dummy_area_entered(entity):
	if "bullet" in entity.name:
		change_emitter_side(entity)
		explode()
		entity.explode()

func explode():
	$sprite.hide()
	$hitbox.call_deferred("set_disabled", true)
	$explosion_particles.set_emitting(true)
	$particles_timer.start()


func _on_particles_timer_timeout():
	queue_free()


func change_emitter_side(entity):
	var vector = global_position - entity.get_position()
	vector = vector.normalized()
	if vector.x < 0:
		print("rotate left")
		$explosion_particles.process_material.set("direction", Vector3(-1, 0, 0))
	else:
		print("rotate right")
		$explosion_particles.process_material.set("direction", Vector3(1, 0, 0))

func _on_dummy_body_entered(entity):
	if "cat" in entity.name:
		if entity.global_position > global_position:
			entity.set_stagger(true)
		else:
			entity.set_stagger(false)
		print('1')

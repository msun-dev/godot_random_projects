extends Camera2D

var move_speed = 50

func _process(delta):
	position.x += move_speed * delta
	if position.x > 450:
		move_speed = 0 - move_speed
	if position.x < 40:
		move_speed = 0 - move_speed

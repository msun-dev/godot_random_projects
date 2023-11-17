extends Position2D

export(PackedScene) var enemy_to_spawn
export(bool) var respawn_on = true
var instance = null

func _ready():
	if enemy_to_spawn:
		spawn_enemy()

func _process(delta):
	if respawn_on:
		if !is_instance_valid(instance):
			instance = enemy_to_spawn.instance()
			add_child(instance)

func spawn_enemy():
	instance = enemy_to_spawn.instance()
	add_child(instance)

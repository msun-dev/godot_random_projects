extends Node3D

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _process(delta):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation_degrees", Vector3(get_rotation_degrees() + Vector3(rng.randf() -1.0, rng.randf() + 1.0, rng.randf() - 1.0)) , 0.1).set_trans(Tween.TRANS_LINEAR)

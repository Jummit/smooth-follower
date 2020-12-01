tool
extends Spatial

export var target := NodePath("../") setget set_target
export(float, 0.1, 4.0, 0.1) var speed := 1.0
export var lock_rotation := false

var tween := Tween.new()

func set_target(to) -> void:
	target = to
	update_configuration_warning()


func _get_configuration_warning() -> String:
	if not get_node_or_null(target) is Spatial:
		return "Target must extend Spatial"
	else:
		return ""


func _process(delta : float) -> void:
	var target_node := get_node(target) as Spatial
	if target_node:
		var target_transform = target_node.transform
		if lock_rotation:
			target_transform.basis = transform.basis
		transform = transform.interpolate_with(target_transform, delta * speed)

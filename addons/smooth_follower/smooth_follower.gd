extends Spatial

enum ProcessMode {
	IDLE,
	PHYSICS,
}

export var target := NodePath("../") setget set_target
export(float, 0.1, 10.0, 0.1) var speed := 1.0
export var lock_rotation := false

export(ProcessMode) var process_mode := ProcessMode.IDLE setget set_process_mode

var tween := Tween.new()

func _ready() -> void:
	set_process_mode(process_mode)


func set_target(to) -> void:
	target = to
	update_configuration_warning()


func set_process_mode(to) -> void:
	process_mode = to
	set_process(process_mode == ProcessMode.IDLE)
	set_physics_process(process_mode == ProcessMode.PHYSICS)


func _get_configuration_warning() -> String:
	if not get_node_or_null(target) is Spatial:
		return "Target must extend Spatial"
	else:
		return ""


func _process(delta : float) -> void:
	update(delta)


func _physics_process(delta : float) -> void:
	update(delta)


func update(delta : float) -> void:
	var target_node := get_node(target) as Spatial
	if target_node:
		var target_transform = target_node.global_transform
		if lock_rotation:
			target_transform.basis = global_transform.basis
		global_transform = global_transform.interpolate_with(target_transform, speed * delta)

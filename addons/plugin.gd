tool
extends EditorPlugin

func _enter_tree() -> void:
	add_custom_type("SmoothFollower", "Spatial", preload("smooth_follower.gd"),
			preload("smooth_follower_icon.svg"))


func _exit_tree() -> void:
	remove_custom_type("SmoothFollower")

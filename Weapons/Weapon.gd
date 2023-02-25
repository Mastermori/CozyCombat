class_name Weapon
extends Node3D

var active := false : set = set_active

func set_active(value: bool) -> void:
	$Hitbox.monitoring = value
	active = value

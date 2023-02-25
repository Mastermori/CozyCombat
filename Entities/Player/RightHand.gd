class_name Hand
extends Marker3D

var weapon: Weapon

@onready var animation_player := $AnimationPlayer

func _ready() -> void:
	weapon = $ItemContainer.get_child(0)

func punch():
	animation_player.play("punch")

func set_weapon_active(value: bool) -> void:
	weapon.active = value

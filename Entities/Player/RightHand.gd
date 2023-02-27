class_name Hand
extends Marker3D

var weapon: Weapon

@onready var animation_player := $AnimationPlayer

func _ready() -> void:
	weapon = $ItemContainer.get_child(0)

@rpc("call_local")
func punch():
	animation_player.play("punch_2")

func set_weapon_active(value: bool) -> void:
	weapon.active = value

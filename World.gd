class_name Level
extends Node3D

@onready var entities := $Entities

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.level = self
	
	if not multiplayer.is_server():
		return
	
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(del_player)

func add_player(id: int) -> void:
	var player := preload("res://Entities/Player/Player.tscn").instantiate()
	player.player = id
	player.position = Vector3(6.5, 5, -4)
	$Entities.add_child(player)

func del_player(id: int) -> void:
	if not $Entities.has_node("Player%s" % id):
		return
	$Entities.get_node("Player%s" % id).queue_free()

func _exit_tree():
	if not multiplayer.is_server():
		multiplayer.multiplayer_peer = null
		return
	multiplayer.peer_connected.disconnect(add_player)
	multiplayer.peer_disconnected.disconnect(del_player)

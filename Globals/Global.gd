extends Node

signal score_changed(new_score)

var player: Player
var level: Node3D
var score: int = 0 : set = set_score

func set_score(value: int) -> void:
	score = value
	score_changed.emit(value)

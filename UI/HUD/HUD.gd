extends Control


func _ready():
	$DeathHUD.hide()
	$PausedHUD.hide()
	Global.score_changed.connect(score_changed)

func display_death():
	$DeathHUD.show()

func display_paused(value: bool):
	$PausedHUD.visible = value

func update_health_display(new_health, previous_health, max_health) -> void:
	var tween = create_tween()
	tween.tween_property($MarginContainer2/HealthBar, "value", new_health / max_health, .4
		).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Menus/main_menu.tscn")
	Engine.time_scale = 1

func score_changed(new_score: int):
	$MarginContainer2/ScoreLabel.text = "Score: %s" % new_score

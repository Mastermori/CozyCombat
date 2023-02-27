extends Control


func _ready():
	$DeathHUD.hide()
	$PausedHUD.hide()
	Global.score_changed.connect(score_changed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"): 
		pause(not Input.mouse_mode == Input.MOUSE_MODE_VISIBLE)

func display_death():
	$DeathHUD.show()

func pause(value: bool):
	$PausedHUD.visible = value
	get_tree().paused = value
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if value else Input.MOUSE_MODE_CAPTURED

func update_health_display(new_health, previous_health, max_health) -> void:
	var tween = create_tween()
	tween.tween_property($MarginContainer2/HealthBar, "value", new_health / max_health, .4
		).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func score_changed(new_score: int):
	$MarginContainer2/ScoreLabel.text = "Score: %s" % new_score


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/Menus/main_menu.tscn")
	Engine.time_scale = 1

func _on_unpause_button_pressed() -> void:
	print("Unpause!")
	pause(false)

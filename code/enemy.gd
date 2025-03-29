extends PathFollow2D

func move():
	var previous_position = position
	
	progress_ratio += 0.025
	
	var tween = create_tween().set_parallel().set_trans(Tween.TRANS_SINE)
	
	tween.tween_property($Sprite2D, 'position', Vector2.ZERO, 0.5).from(previous_position - position)
	tween.set_ease(Tween.EASE_OUT).tween_property($Sprite2D, 'offset:y', -15 / $Sprite2D.scale.y, 0.25)
	tween.set_ease(Tween.EASE_IN).tween_property($Sprite2D, 'offset:y', 0, 0.25).set_delay(0.25)

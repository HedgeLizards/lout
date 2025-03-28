extends PathFollow2D

func move():
	var tween = create_tween().set_parallel().set_trans(Tween.TRANS_SINE)
	
	tween.tween_property(self, 'progress_ratio', 0.05, 0.5).as_relative()
	tween.set_ease(Tween.EASE_OUT).tween_property(self, 'v_offset', -5, 0.25)
	tween.set_ease(Tween.EASE_IN).tween_property(self, 'v_offset', 0, 0.25).set_delay(0.25)

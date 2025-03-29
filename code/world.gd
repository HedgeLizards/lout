extends Node2D

func _on_beat_timer_timeout():
	$Level.update()

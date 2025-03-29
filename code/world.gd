extends Node2D


var culture: int = 100


func _on_beat_timer_timeout():
	$Level.update()

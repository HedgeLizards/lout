extends Node2D


const WORLD_SIZE = Vector2(1152, 648)

var culture: int = 100


func _ready():
	RenderingServer.set_default_clear_color(Color.from_rgba8(49, 119, 204))
	
	var window = get_window()
	var screen_scale = DisplayServer.screen_get_scale()
	
	window.position -= Vector2i(window.size * (screen_scale - 1) / 2)
	window.size *= screen_scale
	
	update_camera_zoom()
	
	get_viewport().size_changed.connect(update_camera_zoom)


func update_camera_zoom():
	var viewport_size = get_viewport_rect().size
	
	$Camera2D.zoom = Vector2.ONE * min(viewport_size.x / WORLD_SIZE.x, viewport_size.y / WORLD_SIZE.y)


func _on_beat_timer_timeout():
	$Level.update()

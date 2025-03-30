extends Node2D

const WORLD_SIZE = Vector2(1152, 648)
const LEVELS = [
	preload('res://scenes/level1.tscn'),
	preload('res://scenes/level2.tscn'),
]

var current_level = 0

func _ready():
	Culture.culture_changed.connect(
		func(new_culture):
			if new_culture < 0:
				game_over()
	)
	
	RenderingServer.set_default_clear_color(Color.from_rgba8(49, 119, 204))
	
	if !OS.has_feature('web'):
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

func game_over():
	$BeatTimer.stop()
	
	$UI/PanelContainer/VBoxContainer/Waves/CallEarly.disabled = true
	
	if !$UI/PanelContainer/VBoxContainer/Waves/NextLevel.visible || current_level == LEVELS.size() - 1:
		$UI/PanelContainer/VBoxContainer/Waves/NextLevel.text = 'Retry level' if current_level < LEVELS.size() - 1 else 'Replay level'
		$UI/PanelContainer/VBoxContainer/Waves/NextLevel.disabled = false
		$UI/PanelContainer/VBoxContainer/Waves/NextLevel.visible = true
		
		current_level -= 1

func go_to_next_level():
	current_level += 1
	
	$Level.free()
	
	var next_level = LEVELS[current_level].instantiate()
	
	add_child(next_level)
	move_child(next_level, 0)
	
	Culture.culture = 100
	
	$BeatTimer.start()
	
	return current_level == LEVELS.size() - 1

func _unhandled_key_input(event):
	if event.keycode == KEY_M && event.pressed && !event.echo:
		AudioServer.set_bus_mute(0, !AudioServer.is_bus_mute(0))

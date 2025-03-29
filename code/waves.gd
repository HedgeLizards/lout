extends Node

const EnemyScene = preload('res://scenes/enemy.tscn')
const BEATS_BETWEEN_WAVES = 20
const BEATS_DURING_WAVE = 10
const WAVES = [
	[
		[0, EnemyType.REGULAR],
		[0.5, EnemyType.FAST],
	],
	[
		[0, EnemyType.TANKY],
		[0.5, EnemyType.REGULAR]
	],
]

enum WaveType { REGULAR_THEN_FAST, TANKY_THEN_REGULAR }
enum EnemyType { REGULAR, TANKY, FAST }

@export var initial_beats_until_spawn = 2.0
@export var beats_until_spawn_factor = 1.0
@export var types: Array[WaveType]

var current_wave = 0
var beats_during_this_wave = -5

@onready var beats_until_spawn = initial_beats_until_spawn
@onready var spawn_progress = -beats_until_spawn / 2

func spawn():
	beats_during_this_wave += 1
	
	if beats_during_this_wave == BEATS_DURING_WAVE:
		current_wave += 1
		beats_during_this_wave = -BEATS_BETWEEN_WAVES
		beats_until_spawn *= beats_until_spawn_factor
		spawn_progress = -beats_until_spawn / 2
	elif beats_during_this_wave >= 0:
		while spawn_progress + beats_until_spawn <= beats_during_this_wave + 1:
			spawn_progress += beats_until_spawn
			
			var wave_progress_ratio = spawn_progress / BEATS_DURING_WAVE 
			var enemy_type
			
			for phase in WAVES[current_wave % types.size()]:
				if wave_progress_ratio >= phase[0]:
					enemy_type = phase[1]
				else:
					break
			
			spawn_enemy(enemy_type)

func spawn_enemy(type):
	var enemy = EnemyScene.instantiate()
	var offset_angle = randf() * TAU
	
	enemy.type = type
	enemy.h_offset = cos(offset_angle) * 32
	enemy.v_offset = sin(offset_angle) * 32
	
	$'../Paths/Path2D'.add_child(enemy)

func call_next_wave_early():
	if beats_during_this_wave < -1:
		beats_during_this_wave = -1

func _unhandled_key_input(event):
	if event.keycode == KEY_SPACE && event.pressed && !event.echo:
		call_next_wave_early()

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
enum EnemyType { REGULAR, FAST, TANKY }

@export var initial_beats_until_spawn = 2.0
@export var beats_until_spawn_factor = 1.0
@export var number_to_win = 20
@export var types: Array[WaveType]

var current_wave = 0
var current_path = 0
var beats_during_this_wave = -5

@onready var beats_until_spawn = initial_beats_until_spawn
@onready var spawn_progress = -beats_until_spawn / 2
@onready var ui = $'../../UI'
@onready var paths = $'../Paths'
@onready var path_combinations = calculate_path_combinations()

func _ready():
	ui.update_number_of_waves(number_to_win)

func calculate_path_combinations():
	var combinations = []
	var number_of_paths = paths.get_child_count()
	
	for i in number_of_paths:
		var positions = []
		
		for j in i + 1:
			positions.push_back(j)
		
		while true:
			combinations.push_back(positions.duplicate())
			
			var active_position = i
			
			while active_position >= 0:
				if positions[active_position] < number_of_paths - 1 - (i - active_position):
					positions[active_position] += 1
					
					for j in i - active_position:
						positions[active_position + 1 + j] = positions[active_position] + 1 + j
					
					break
				
				active_position -= 1
			
			if active_position == -1:
				break
	
	return combinations

func spawn():
	beats_during_this_wave += 1
	
	if beats_during_this_wave == BEATS_DURING_WAVE:
		current_wave += 1
		current_path = 0
		beats_during_this_wave = -BEATS_BETWEEN_WAVES
		beats_until_spawn *= beats_until_spawn_factor
		spawn_progress = -beats_until_spawn / 2
	
	if beats_during_this_wave <= 0:
		ui.update_next_wave(float(beats_during_this_wave + BEATS_BETWEEN_WAVES) / BEATS_BETWEEN_WAVES)
	
	if beats_during_this_wave == 0:
		ui.update_current_wave(current_wave)
	
	if beats_during_this_wave >= 0:
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
	enemy.h_offset = cos(offset_angle) * 16
	enemy.v_offset = sin(offset_angle) * 16
	
	var path_combination = path_combinations[current_wave % path_combinations.size()]
	
	paths.get_child(path_combination[current_path]).add_child(enemy)
	
	current_path = (current_path + 1) % path_combination.size()

func call_next_wave_early():
	beats_during_this_wave = -1

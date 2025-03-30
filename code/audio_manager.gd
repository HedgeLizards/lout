extends Node

@export var fade_speed: float = 1.0  # How fast it fades per second

# Structure: layer_name -> { node: AudioStreamPlayer, original_volume: float, target_offset: float }
var layers := {}

func _ready():
	var sync_node = $Music
	for player in sync_node.get_children():
		if player is AudioStreamPlayer:
			layers[player.name] = {
				"node": player,
				"original_volume": player.volume_db,
				"target_offset": 0.0  # 0 means no fade, just play at original volume
			}

func _process(delta):
	for data in layers.values():
		var player: AudioStreamPlayer = data["node"]
		var original_volume: float = data["original_volume"]
		var target_offset: float = data["target_offset"]
		var target_volume := original_volume + target_offset
		var current := player.volume_db

		if abs(current - target_volume) > 0.1:
			player.volume_db = lerp(current, target_volume, fade_speed * delta)
		else:
			player.volume_db = target_volume  # Snap when close

# Fades in by restoring to original dB
func fade_in(layer_name: String):
	if layers.has(layer_name):
		layers[layer_name]["target_offset"] = 0.0

# Fades out by lowering to -80 dB from original volume
func fade_out(layer_name: String):
	if layers.has(layer_name):
		var original = layers[layer_name]["original_volume"]
		layers[layer_name]["target_offset"] = -80.0 - original

# Set a custom dB offset from the original (e.g. -10 to lower it slightly)
func set_layer_offset(layer_name: String, offset_db: float):
	if layers.has(layer_name):
		layers[layer_name]["target_offset"] = clamp(offset_db, -80.0, 0.0)

# Instantly mute (no fade)
func mute_instant(layer_name: String):
	if layers.has(layer_name):
		layers[layer_name]["node"].volume_db = -80.0

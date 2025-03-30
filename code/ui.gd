extends CanvasLayer

func update_number_of_waves(number_of_waves):
	$PanelContainer/VBoxContainer/Waves/Progress.text = 'Wave 1/%d' % number_of_waves

func update_current_wave(current_wave):
	var number_of_waves = int($PanelContainer/VBoxContainer/Waves/Progress.text.get_slice('/', 1))
	
	$PanelContainer/VBoxContainer/Waves/Progress.text = 'Wave %d/%d' % [current_wave + 1, number_of_waves]
	
	if current_wave == number_of_waves:
		$PanelContainer/VBoxContainer/Waves/NextLevel.visible = true

func update_next_wave(approach_percentage):
	$PanelContainer/VBoxContainer/Waves/NextWave.value = approach_percentage
	$PanelContainer/VBoxContainer/Waves/CallEarly.disabled = approach_percentage == 1

func _on_call_early_pressed():
	$'../Level/Waves'.call_next_wave_early()

func _on_next_level_pressed():
	pass # Replace with function body.

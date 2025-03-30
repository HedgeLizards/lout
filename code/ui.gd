extends CanvasLayer

func _ready():
	var screen_scale = DisplayServer.screen_get_scale()
	
	for stylebox in [
		$PanelContainer.get_theme_stylebox('panel'),
		$PanelContainer/VBoxContainer/Waves/NextLevel.get_theme_stylebox('normal'),
		$PanelContainer/VBoxContainer/Waves/NextLevel.get_theme_stylebox('disabled')
	]:
		stylebox.corner_radius_top_left *= screen_scale
		stylebox.corner_radius_top_right *= screen_scale
		stylebox.corner_radius_bottom_right *= screen_scale
		stylebox.corner_radius_bottom_left *= screen_scale
		stylebox.content_margin_left *= screen_scale
		stylebox.content_margin_top *= screen_scale
		stylebox.content_margin_right *= screen_scale
		stylebox.content_margin_bottom *= screen_scale
	
	for control in [
		$PanelContainer/VBoxContainer,
		$PanelContainer/VBoxContainer/Buying,
		$PanelContainer/VBoxContainer/Waves,
	]:
		control.add_theme_constant_override('separation', control.get_theme_constant('separation') * screen_scale)
	
	for control in [
		$PanelContainer/VBoxContainer/Buying/CultureLabel,
		$PanelContainer/VBoxContainer/Buying/BuyFlute/Label,
		$PanelContainer/VBoxContainer/Buying/BuyGuitar/Label,
		$PanelContainer/VBoxContainer/Buying/BuyDrums/Label,
		$PanelContainer/VBoxContainer/Waves/NextLevel,
		$PanelContainer/VBoxContainer/Waves/Progress,
		$PanelContainer/VBoxContainer/Waves/CallEarly,
	]:
		control.add_theme_font_size_override('font_size', control.get_theme_font_size('font_size') * screen_scale)
	
	for control in [
		$PanelContainer/VBoxContainer/Buying/BuyFlute,
		$PanelContainer/VBoxContainer/Buying/BuyGuitar,
		$PanelContainer/VBoxContainer/Buying/BuyDrums,
		$PanelContainer/VBoxContainer/Buying/CancelBuy,
		$PanelContainer/VBoxContainer/Waves/NextWave,
	]:
		control.custom_minimum_size *= screen_scale

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

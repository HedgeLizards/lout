class_name Enemy extends PathFollow2D

enum EnemyType { REGULAR, FAST, TANKY }

@export var type: EnemyType

var speed
var health
var unculture: int
var gain: int

func _ready():
	match (type):
		EnemyType.REGULAR:
			speed = 50
			health = 10
			unculture = 5
			gain = 1
		EnemyType.FAST:
			speed = 100
			health = 5
			unculture = 3
			gain = 1
		EnemyType.TANKY:
			speed = 50
			health = 20
			unculture = 8
			gain = 3

func move():
	
	
	var previous_position = position
	
	progress += speed
	
	$Sprite2D.flip_h = position.x > previous_position.x
	
	var tween = create_tween().set_parallel().set_trans(Tween.TRANS_SINE)
	
	tween.tween_property($Sprite2D, 'position', $Sprite2D.position, 0.5).from($Sprite2D.position + previous_position - position)
	tween.set_ease(Tween.EASE_OUT).tween_property($Sprite2D, 'offset:y', -15 / $Sprite2D.scale.y, 0.25)
	tween.set_ease(Tween.EASE_IN).tween_property($Sprite2D, 'offset:y', 0, 0.25).set_delay(0.25)
	
	if progress_ratio >= 1.0:
		Culture.damage_culture(unculture)
		queue_free()

func progress_left() -> float:
	return progress / max(progress_ratio, 1e-9)


func damage(amount: float):
	health -= amount
	if health <= 0:
		defeat()

func defeat():
	Culture.culture += gain
	queue_free()

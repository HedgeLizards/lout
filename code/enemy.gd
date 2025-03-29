class_name Enemy extends PathFollow2D

enum EnemyType { REGULAR, TANKY, FAST }

@export var type: EnemyType

var speed
var health

func _ready():
	match (type):
		EnemyType.REGULAR:
			speed = 50
			health = 10
		EnemyType.TANKY:
			speed = 50
			health = 20
		EnemyType.FAST:
			speed = 100
			health = 5

func move():
	var previous_position = position
	
	progress += speed
	
	var tween = create_tween().set_parallel().set_trans(Tween.TRANS_SINE)
	
	tween.tween_property($Sprite2D, 'position', Vector2.ZERO, 0.5).from(previous_position - position)
	tween.set_ease(Tween.EASE_OUT).tween_property($Sprite2D, 'offset:y', -15 / $Sprite2D.scale.y, 0.25)
	tween.set_ease(Tween.EASE_IN).tween_property($Sprite2D, 'offset:y', 0, 0.25).set_delay(0.25)

func damage(amount: float):
	pass

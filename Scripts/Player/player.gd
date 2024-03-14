extends CharacterBody2D

@export_range(0, 300, 1, "or_greater") var MAX_SPEED : float = 300.0
@export_range(0, 100, 1, "or_greater") var ACCELERATION : float = 40.0
@export_range(0, 1) var FRICTION : float = 0.1
@export var WEAPON : Weapon = null

func fire_weapon(direction : Vector2 = Vector2.ZERO):
	var projectile = load(WEAPON.projectileScript).new(position, direction * 400.0, WEAPON.damage, load("res://Resources/Sprites/Dev Art/pellet.png"))
	add_sibling(projectile)

func _ready():
	pass

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	
	velocity += direction * ACCELERATION
	velocity -= velocity * FRICTION
	velocity = velocity.limit_length(MAX_SPEED)
	
	move_and_slide()

func _input(event):
	if event.is_action_pressed("click"):
		fire_weapon(get_local_mouse_position().normalized())

extends CharacterBody2D
class_name Projectile

@export var SPRITE_RESOURCE : Texture2D = null
@export var COLLISION_RESOURCE : Shape2D = null
@export var INITIAL_VELOCITY : Vector2 = Vector2.ZERO

var Sprite : Sprite2D = Sprite2D.new()
var Collision : CollisionShape2D = CollisionShape2D.new()

var damage : float = 0.0

func _init(p_position = Vector2.ZERO, p_velocity = Vector2.ZERO, p_damage = 0.0, p_sprite = null):
	position = p_position
	self.INITIAL_VELOCITY = p_velocity
	self.damage = p_damage
	self.SPRITE_RESOURCE = p_sprite

func _ready():
	self.Sprite.texture = SPRITE_RESOURCE
	add_child(Sprite)
	
	self.Collision.shape = COLLISION_RESOURCE
	add_child(Collision)
	
	self.velocity = INITIAL_VELOCITY


func _physics_process(delta):
	move_and_slide()

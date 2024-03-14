extends Resource
class_name Weapon

@export_group("Weapon Properties")

@export var name : String = "New Weapon"
@export_range(0, 100, 1, "or_greater") var damage = 1
@export_range(1, 8, 1, "or_greater") var beats : int = 4
#@export_range(1, 8, 1, "or_greater") var attacks : int = 1
@export var sprite : ImageTexture = null
@export_file("*.gd") var projectileScript : String = "res://Scripts/Items/Weapons/projectile.gd"

func _init(p_name = "New Weapon", p_damage = 1.0, p_beats = 4, p_sprite = null, p_projectile = "res://Scripts/Items/Weapons/projectile.gd"):
	name = p_name
	damage = p_damage
	beats = p_beats
	sprite = p_sprite
	projectileScript = p_projectile

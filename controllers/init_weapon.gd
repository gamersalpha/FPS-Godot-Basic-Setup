@tool

extends Node3D

@export var WEAPON_TYPE : Weapons :
	set(value):
		WEAPON_TYPE = value
		if Engine.is_editor_hint():
			load_weapon()

@onready var weapon_mesh : MeshInstance3D = %WeaponMesh
@onready var weapon_shadow : MeshInstance3D = %WeaponShadow

func _input(event):
	if event.is_action_pressed("Weapon1"):
		WEAPON_TYPE = load("res://models/weapon/crowbar/Crowbar.tres")
		load_weapon()
	if event.is_action_pressed("Weapon2"):
		WEAPON_TYPE = load("res://models/weapon/crowbar2/CrowbarL.tres")
		load_weapon()
	if event.is_action_pressed("Weapon3"):
		WEAPON_TYPE = load("res://models/weapon/M254/Resource-M254.tres")
		load_weapon()
		
func _ready() -> void:
	load_weapon()

func load_weapon() -> void:
	weapon_mesh.mesh = WEAPON_TYPE.mesh
	weapon_shadow.mesh = WEAPON_TYPE.mesh
	position = WEAPON_TYPE.position
	rotation_degrees = WEAPON_TYPE.rotation
	scale = WEAPON_TYPE.scale
	weapon_shadow.visible = WEAPON_TYPE.shadow

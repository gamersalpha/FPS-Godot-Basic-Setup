@tool

extends Node3D

@export var WEAPON_TYPE : Weapons :
	set(value):
		WEAPON_TYPE = value
		if Engine.is_editor_hint():
			load_weapon()

@onready var weapon_mesh : MeshInstance3D = %WeaponMesh
@onready var weapon_shadow : MeshInstance3D = %WeaponShadow

var mouse_movement : Vector2

func _ready() -> void:
	await  owner.ready
	load_weapon()

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
	if event.is_action_pressed("Weapon4"):
		WEAPON_TYPE = load("res://models/weapon/AR160/RES_AR160.tres")
		load_weapon()
	if event is InputEventMouseMotion:
		mouse_movement = event.relative

func load_weapon() -> void:
	weapon_mesh.mesh = WEAPON_TYPE.mesh
	weapon_shadow.mesh = WEAPON_TYPE.mesh
	position = WEAPON_TYPE.position
	rotation_degrees = WEAPON_TYPE.rotation
	scale = WEAPON_TYPE.scale
	weapon_shadow.visible = WEAPON_TYPE.shadow

func sway_weapon(delta) -> void:
	#Clamp mouse movement
	mouse_movement = mouse_movement.clamp(WEAPON_TYPE.sway_min,WEAPON_TYPE.sway_max)
	#lerp weapon position based on mouse movement
	position.x = lerp(position.x, WEAPON_TYPE.position.x - (mouse_movement.x * WEAPON_TYPE.sway_amount_position)* delta, WEAPON_TYPE.sway_speed_position)
	position.y = lerp(position.y, WEAPON_TYPE.position.y - (mouse_movement.y * WEAPON_TYPE.sway_amount_position)* delta, WEAPON_TYPE.sway_speed_position)
	
	 #lerp weapon rotation based on mouse movement
	rotation_degrees.y = lerp(rotation_degrees.y, WEAPON_TYPE.rotation.y + (mouse_movement.x * WEAPON_TYPE.sway_amount_rotation)*delta, WEAPON_TYPE.sway_speed_rotation)
	rotation_degrees.x = lerp(rotation_degrees.x, WEAPON_TYPE.rotation.x + (mouse_movement.y * WEAPON_TYPE.sway_amount_rotation)*delta, WEAPON_TYPE.sway_speed_rotation)

func _physics_process(delta: float) -> void:
	sway_weapon(delta)




class_name SlidingPlayerState  extends PlayerMovementState

@export var SPEED: float = 6.0
@export var ACCELERATION : float = 0.1
@export var DECELERATION : float = 0.25
@export var TILT_AMOUNT : float = 0.09
@export_range(1,6,0.1) var SLIDE_ANIM_SPEED : float = 4.0

@onready var CROUCH_SHAPECAST : ShapeCast3D = %ShapeCast3D

func enter(previous_stat) -> void:
	set_tilt(PLAYER._current_rotation)
	ANIMATION.get_animation("Sliding").track_set_key_value(4,0,PLAYER.velocity.length())
	ANIMATION.speed_scale = 1.0
	ANIMATION.play("Sliding",-1.0, SLIDE_ANIM_SPEED)
	
func update(delta):
	PLAYER.update_gravity(delta)
	#PLAYER.update_input(SPEED,ACCELERATION,DECELERATION) #Disable to maintain direction while sliding
	PLAYER.update_velocity()
	if Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		transition.emit("JumpingPlayerState")

func set_tilt(player_rotation) -> void:
	var tilt = Vector3.ZERO
	tilt.z = clamp(TILT_AMOUNT * player_rotation,-0.1,0.1)
	if tilt.z == 0.0:
		tilt.z = 0.05
	ANIMATION.get_animation("Sliding").track_set_key_value(7,1,tilt)
	ANIMATION.get_animation("Sliding").track_set_key_value(7,2,tilt)
	
	print(ANIMATION.get_animation("Sliding").track_get_path(7))

func finish():
	transition.emit("CrouchingPlayerState")

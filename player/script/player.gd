extends CharacterBody3D

@onready var PARENTS = $".."
@onready var HEAD = $head

var SPEED = 0

@onready var COL_NORMAL = $normal_col_shape
@onready var COL_CROUCH = $crouch_col_shape

@onready var TIMER_CRO = $end_crouch
@onready var CRO_RAY = $crouch_col_shape/ray

var IS_CROUCHING = false
var CAN_CROUCH = true

var CAN_RUN = false
var CAN_RUN_BTN_WORK = true
@onready var END_RUN = $end_run

var direction = Vector3.ZERO

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * PARENTS.SENSITIVITY))
		HEAD.rotate_x(deg_to_rad(-event.relative.y * PARENTS.SENSITIVITY))
		HEAD.rotation.x = clamp(HEAD.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta):
	if COL_NORMAL.disabled:
		COL_CROUCH.disabled = false
		HEAD.position.y = -0.235
		SPEED = PARENTS.CROUCH_SPEED
	else:
		COL_CROUCH.disabled = false
		HEAD.position.y = 0.512
		if CAN_RUN:
			SPEED = PARENTS.RUN_SPEED

	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and !CRO_RAY.is_colliding():
		velocity.y = PARENTS.JUMP_VELOCITY
		if COL_NORMAL.disabled:
			COL_NORMAL.disabled = false

	# Crouch

		if !IS_CROUCHING:
			COL_NORMAL.disabled = true
			IS_CROUCHING = true
		else:
			if !CRO_RAY.is_colliding():
				COL_NORMAL.disabled = false
				IS_CROUCHING = false

	# Movement Input
	var input_dir = Input.get_vector("left", "right", "forward", "back")

	if PARENTS.RUN_MODE == PARENTS.RUN_MODE_VALUE.CLICK and input_dir == Vector2.ZERO:
		CAN_RUN = false

	# Move
	direction = lerp(direction, ((transform.basis * Vector3(-input_dir.x, 0, -input_dir.y)).normalized()), delta * 10)

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	SPEED = PARENTS.NORMAL_SPPED

func _on_end_crouch_timeout():
	CAN_CROUCH = true

func _on_end_run_timeout():
	CAN_RUN_BTN_WORK = true

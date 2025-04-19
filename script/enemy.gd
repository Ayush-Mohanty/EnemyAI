extends CharacterBody3D

const SPEED = 3
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var PLAYER = $"../player/body"
@onready var AGENT = $NavigationAgent3D

var NEXT_LOCATION 
var CURRENT_POSITION
var FIRST_CHECK = false

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the next location for the enemy to move to
	NEXT_LOCATION = AGENT.get_next_path_position()
	CURRENT_POSITION = global_transform.origin

	# Enemy AI vision (if player is not seen, follow the path)
	if player_view_ray().get('collider') == null and FIRST_CHECK:
		AGENT.target_position = PLAYER.global_transform.origin
		look_at(Vector3(AGENT.target_position.x, position.y, AGENT.target_position.z))

	# AI movement: Move towards the next location
	var target_velocity = (NEXT_LOCATION - CURRENT_POSITION).normalized() * SPEED

	velocity.x = target_velocity.x
	velocity.z = target_velocity.z

	move_and_slide()
	FIRST_CHECK = true

# Function to check if the player is within view using raycasting
func player_view_ray():
	var space_state = get_world_3d().direct_space_state
	var ray_start = global_transform.origin
	var ray_end = PLAYER.global_transform.origin
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	query.exclude = [self, PLAYER]
	return space_state.intersect_ray(query)

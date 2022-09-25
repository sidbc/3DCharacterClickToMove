extends KinematicBody

export var maxspeed = 800
export var speed = 20
export var movedirection = 0.0
var acceleration = 2200
export var moving = false
export var destination = Vector3()
var axis = Vector3(0, -1, 0)

func _physics_process(delta):
	if moving == false:
		speed = 0
		return

	speed += acceleration * delta
	if speed > maxspeed:
		speed = maxspeed

	var transform_origin = transform.origin
	var distance_to = transform_origin.distance_to(destination)
	
	# Magic number 5, I don't know why but smaller number doesn't work???
	if distance_to > 5:
		move_and_slide(destination)
	else:
		moving = false

func _on_Ground_input_event(camera, event,  new_position, normal, shape_idx):
	if moving == false and event.is_action_pressed("ui_click"):
		moving = true
		destination = new_position # here is wherei had the most trouble so far
		movedirection = floor(rad2deg(transform.origin.angle_to(destination)))
		var curr_rot_y = rotation_degrees.y
		var rot = rotation_degrees.y + floor(movedirection)
		rotation_degrees.y = -1 * movedirection
	elif moving == true and event.is_action_pressed("ui_click"):
		moving = false

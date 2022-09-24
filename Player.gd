extends KinematicBody

var maxspeed = 800
var speed = 20
var movedirection
var acceleration = 2200
var moving = false
var destination = Vector3()
var movement = Vector3()
var position = Vector3(0, 0, 0)

func _physics_process(delta):
	MovementLoop(delta)

func MovementLoop(delta):
	if moving == false:
		speed = 0
		return
	else:
		speed += acceleration * delta

	if speed > maxspeed:
		speed = maxspeed

	movement = position.move_toward(destination, delta) * speed
	movement.y = 0.0
	movedirection = rad2deg(transform.origin.angle_to(destination)) #angleto doesnt work on 3.2.1
	
	var distance_to = transform.origin.distance_to(destination)
	if distance_to > 5:
		movement = move_and_slide(movement)
	else:
		moving = false


func _on_Ground_input_event(camera, event,  new_position, normal, shape_idx):
	if event.is_action_pressed("ui_click"):
		moving = true
		destination = new_position # here is wherei had the most trouble so far
#	elif moving == true and event.is_action_pressed("ui_click"):
#		moving = false

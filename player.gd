extends CharacterBody2D

@export var GRAVITY = 50.0
@export var WALK_SPEED = 300.0
@onready var jump_timer = %Timer
var gravity = GRAVITY
var walk_speed = 0.0

func _physics_process(delta):
	# left right
	if Input.is_action_pressed("ui_left"):
		walk_speed = -WALK_SPEED
	elif Input.is_action_pressed("ui_right"):
		walk_speed =  WALK_SPEED
	else:
		walk_speed = 0
	
	# jump
	if Input.is_action_pressed("jump") and is_on_floor():
		gravity = -GRAVITY
		jump_timer.start()
	
	velocity.y += gravity # linear acceleration
	velocity.x = walk_speed
	move_and_slide()

func _on_timer_timeout():
	gravity = GRAVITY
	jump_timer.stop()

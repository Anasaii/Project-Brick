extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 3000
const MAXFALLSPEED = 1000
const MAXSPEED = 350
const JUMPFORCE = 500
const ACCELERATION = 20
var jumpCounter : float
var isJumping : bool 
var motion = Vector2()

export var jumpTimer : float

func _ready():
	pass 

func _physics_process(delta):
	
	# Gravity for Player
	motion.y += GRAVITY * delta * (2 if motion.y > 0 else 1) 
	
	# Limits Vertical Falling Speed
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	# Limit Horizontal Speed
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	# Jumping
	if is_on_floor():
		if Input.is_action_pressed("space"):
			isJumping = true
			jumpCounter = jumpTimer
			motion.y = JUMPFORCE
	
	if Input.is_action_pressed("space") and isJumping:
		if jumpCounter > 0:
			motion.y = -JUMPFORCE
			jumpCounter -= delta
		else:
			isJumping = false
	
	if Input.is_action_just_released("space"):	
		isJumping = false
		
	# Horizontal Movement
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("right"):
		motion.x += ACCELERATION
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("left"):
		motion.x -= ACCELERATION
	else:
		motion.x = lerp(motion.x,0,0.2)
		
	motion = move_and_slide(motion,UP)

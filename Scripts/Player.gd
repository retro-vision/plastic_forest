extends KinematicBody2D

# attributs du joueur
const RUN_SPEED  = 100
const JUMP_SPEED = -420
const GRAVITY    = 1000

var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = Vector2(80,160) #Vector2(80,160)
#	$Camera2D.position.y = -20

func get_input():

	velocity.x = 0
	var up	 = Input.is_action_pressed('ui_up')
	var right = Input.is_action_pressed('ui_right')
	var left  = Input.is_action_pressed('ui_left')
	var jump  = Input.is_action_just_pressed('ui_select')
	var jump_release = Input.is_action_just_released('ui_select')


	if is_on_floor():
		if right:
			$Sprite.play("Run")
			$Sprite.flip_h = false
		elif left:
			$Sprite.play("Run")
			$Sprite.flip_h = true
		elif(Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left")):
			$Sprite.play("Idle")
			$Sprite.playing = false
			if $Sprite.frame == 0:
				$Sprite.frame = 1
			else:
				$Sprite.frame = 0
		else:
			$Sprite.play("Idle")
			$Sprite.playing = false
	else:
		if velocity.y < 0 and left:
			$Sprite.flip_h = true
			$Sprite.play("Jump")
		elif velocity.y < 0 and right:
			$Sprite.flip_h = false
			$Sprite.play("Jump")
		elif velocity.y > 0 and left:
			$Sprite.flip_h = true
			$Sprite.play("Down")
		elif velocity.y > 0 and right:
			$Sprite.flip_h = false
			$Sprite.play("Down")
		# On monte droit
		elif velocity.y < 0:
			$Sprite.play("Jump")
		# On descend droit
		elif velocity.y > 0:
			$Sprite.play("Down")


	if is_on_floor() and jump :
		velocity.y = JUMP_SPEED

	velocity.x = -int(left)+int(right)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if get_tree().paused == false:
		get_input()
		velocity.x *= RUN_SPEED
		velocity.y += GRAVITY * delta
		velocity 	= move_and_slide(velocity, Vector2(0, -1))
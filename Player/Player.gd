extends CharacterBody2D

const ACCELERATION = 400
const MAX_SPEED = 100
const FRICTION = 400

var input_vector = Vector2.ZERO

var animationPlayer: AnimationPlayer = null
var animationTree: AnimationTree = null
var animationState: AnimationNodeStateMachinePlayback = null
 
func _ready():
	animationPlayer = $AnimationPlayer
	animationTree = $AnimationTree
	animationState = animationTree.get("parameters/playback")
 
func _physics_process(delta):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()

func _process(delta):
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
	else:
		animationState.travel("Idle")
	

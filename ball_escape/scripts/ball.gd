extends CharacterBody2D

@onready var paddleOrbit = get_node("/root/Main/PaddleOrbit")
@onready var paddle = get_node("/root/Main/PaddleOrbit/Paddle")

var BASE_SPEED = 200
var speed_multiplier = 1.0
var movement = Vector2.RIGHT
var collide_cooldown = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	movement = Vector2.RIGHT.rotated(deg_to_rad(randf_range(0, 360)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()


func _physics_process(delta):
	collide_cooldown = clamp(collide_cooldown - delta, 0, 1)
	velocity = movement * BASE_SPEED * speed_multiplier
	move_and_slide()

func _draw():
	draw_circle(Vector2(0, 0), 10.0, Color.WHITE)

func _on_body_entered(body):
	#change ball movement when it collides with the paddle
	var rotate_ball = randf_range(-40, 40)
	movement = Vector2.RIGHT.rotated(get_angle_to(paddleOrbit.position) + deg_to_rad(rotate_ball))
	print(get_angle_to(paddleOrbit.position))
	speed_multiplier += 0.1

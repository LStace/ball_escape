extends Node2D

var mouse_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	draw_arc(Vector2(50, 50), 40, 0, PI/2, 32, Color.WHITE, 2, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	mouse_pos = get_global_mouse_position()
	queue_redraw()

func _draw():
	#draw_arc(position, position.distance_to($Paddle.position), get_angle_to($Paddle.position) + PI/15, get_angle_to($Paddle.position) - PI/15, 32, "ALICE_BLUE", 10, true)
	draw_arc(position, position.distance_to($Paddle.position), get_angle_to(mouse_pos) + PI/15, get_angle_to(mouse_pos) - PI/15, 32, "ALICE_BLUE", 10, true)

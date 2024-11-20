extends Node2D

@onready var collider = get_node("Paddle/CollisionPolygon2D")
@onready var collision_polygon = collider.get_polygon()

var mouse_pos
var pi_denom = 13.0
var arc_width = 10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	calculate_collision_shape()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	queue_redraw()
	collider.set_polygon(collision_polygon)

func _draw():
	#draw_arc(position, position.distance_to($Paddle.position), get_angle_to($Paddle.position) + PI/15, get_angle_to($Paddle.position) - PI/15, 32, "ALICE_BLUE", 10, true)
	draw_arc(position, position.distance_to($Paddle.position), get_angle_to(mouse_pos) + PI/pi_denom, get_angle_to(mouse_pos) - PI/pi_denom, 32, "ALICE_BLUE", arc_width, true)

#calculate the shape of the collision to match the drawn arc
func calculate_collision_shape():
	collision_polygon = collider.get_polygon()
	for i in range(0, 5):
		var coord = get_point_on_arc(360 / pi_denom / (i + 1))
		collision_polygon[i] = coord - Vector2(arc_width / 2, 0)
		collision_polygon[8 - i] = coord * Vector2(1, -1) - Vector2(arc_width / 2, 0)

#calculate the coordinates on the arc
func get_point_on_arc(angle):
	var radius = position.distance_to($Paddle.position)
	# deg_to_rad because sin uses radians
	# calculate the chord of the arc and the height of the segment
	var chord = (radius * sin(deg_to_rad(angle))) / sin(deg_to_rad((180 - angle)/ 2))
	var height = sqrt(radius**2 - (chord/2)**2)
	# coordinates are local to the paddle, so take away to calculate distance from the paddle centre, not the circle center
	return Vector2((radius - height) * -1, chord/2)
	


func _on_paddle_body_entered(body):
	body.bounce()

extends Node2D

const BALL = preload("res://scenes/ball.tscn")

@onready var paddle = get_node("PaddleOrbit")
@onready var game_over_text = get_node("GameOverText")
@onready var final_score_label : Label = get_node("GameOverText/FinalScoreLabel")

@export var score_label : Label

var score : int = 0
var gameOn = true


# Called when the node enters the scene tree for the first time.
func _ready():
	start_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#creates a new ball
func ballInstance(ball_location):
	var new_ball = BALL.instantiate()
	new_ball.position = ball_location
	new_ball.bounced.connect(on_ball_bounced)
	new_ball.bouncedTenTimes.connect(on_ball_bounced_ten_times)
	call_deferred("add_child", new_ball)


func on_ball_bounced(ballBounces):
	#increases the score based on how many times the ball has bounced. 
	score += ballBounces
	score_label.text = "%d" % score
	$BounceSound.play()


#creates a ball every time a ball hits ten bounces
func on_ball_bounced_ten_times(ballPosition):
	ballInstance(ballPosition)


func _input(event):
	if event.is_action_pressed("Restart") and gameOn == false:
		start_game()


#destroys the ball once it has left the playable area
func _on_boundary_body_exited(body):
	if body.is_in_group("balls"):
		body.queue_free()
		await body.tree_exited
		if get_tree().get_nodes_in_group("balls").is_empty():
			end_game()


func start_game():
	game_over_text.visible = false
	gameOn = true
	paddle.visible = true
	score_label.visible = true
	score = 0
	ballInstance(position)
	score_label.text = "%d" % score


func end_game():
	final_score_label.text = "%d" % score
	gameOn = false
	paddle.visible = false
	score_label.visible = false
	game_over_text.visible = true
	print("You have no BALLS")

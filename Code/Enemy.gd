extends Area2D


@onready var player = $/root/Main/Player
@onready var rock = $Rock
@onready var paper = $Paper
@onready var scissors = $Scissors
var options = ["Rock", "Paper", "Scissors"]
@onready var choice = options.pick_random()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if choice == "Rock":
		rock.visible = true
	else:
		rock.visible = false
	if choice == "Paper":
		paper.visible = true
	else: paper.visible = false
	if choice == "Scissors":
		scissors.visible = true
	else:
		scissors.visible = false
	 

	



extends Node2D

var handPosY

# Called when the node enters the scene tree for the first time.
func _ready():
	var hand = preload("res://Scenes/Hand.tscn").instance()
	$"/root/Game/Level1".add_child(hand)
	handPosY = 160
	$Hand.play("Hand")

func _process(delta):
	$Hand/Sprite.position.y = handPosY

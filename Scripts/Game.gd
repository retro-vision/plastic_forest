extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Active le défilement du fond automatiquement
	$ParallaxBackground/Sky.motion_mirroring = $ParallaxBackground/Sky/Sprite.texture.get_size().rotated($ParallaxBackground/Sky/Sprite.global_rotation)
	$ParallaxBackground/MountainsFar.motion_mirroring = $ParallaxBackground/MountainsFar/Sprite.texture.get_size().rotated($ParallaxBackground/MountainsFar/Sprite.global_rotation)
	$ParallaxBackground/MountainsNear.motion_mirroring = $ParallaxBackground/MountainsNear/Sprite.texture.get_size().rotated($ParallaxBackground/MountainsNear/Sprite.global_rotation)
	$ParallaxBackground/GrassFar.motion_mirroring = $ParallaxBackground/GrassFar/Sprite.texture.get_size().rotated($ParallaxBackground/GrassFar/Sprite.global_rotation)
	$ParallaxBackground/GrassNear.motion_mirroring = $ParallaxBackground/GrassNear/Sprite.texture.get_size().rotated($ParallaxBackground/GrassNear/Sprite.global_rotation)

	# Chargement du level
	var levelStr = "res://Scenes/Level"+str(Global.level)+".tscn"
	var level = load(levelStr).instance()
	$"/root/Game".add_child(level)

	# Chargement du player
	var player = load("res://Scenes/Player.tscn").instance()
	$"/root/Game".add_child(player)

func _process(delta):
	# Esc, on retourne au menu
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/Menu.tscn")
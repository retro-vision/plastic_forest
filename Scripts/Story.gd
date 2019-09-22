extends Node2D

const SPEED_FADE = 0.03

var story = ["L'intrigue se passe dans la foret de Grassland. La foret se meurt peu à peu à cause de la pollution. Il faut absolument la dépolluer !", "Pour ce faire, vous incarnez Recyclo, l'ange gardien de mère nature. Au cours de votre quête parmis les différents niveaux, vous devrez collecter tous les", "déchets laissés par les horribles CROPS et éviter les pièges parsemer ça et là, afin de dépolluer Grassland."]
var idxTab = 0
var fade = false
var stepFade = -SPEED_FADE
var alpha = Color("fdd068")

# Called when the node enters the scene tree for the first time.
func _ready():
  pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  var select = Input.is_action_just_pressed("ui_accept")
  var escape = Input.is_action_just_pressed("ui_cancel")

  if escape:
    get_tree().change_scene('res://Scenes/Menu.tscn')

  if select:
    print(len(story))
    if idxTab < len(story)-1:
      fade = true

  if fade == true:
    alpha.a += stepFade

    if alpha.a <= 0:
      stepFade = SPEED_FADE
      idxTab += 1
    if alpha.a >= 1:
      alpha.a = 1
      stepFade = -SPEED_FADE
      fade = false

  $Story.set("custom_colors/font_color",alpha)
  $Story.text = story[idxTab]

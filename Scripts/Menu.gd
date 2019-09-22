extends Node2D

const STEP_SAW = 36
const STOP_TOP = 65
const STOP_BOTTOM = 173

enum Menu {START = 0, OPTIONS = 1, SCORE = 2, EXIT = 3}
var fullScreen = false
var selectedMenu = Menu.START
var currentPosY = 0

# Called when the node enters the scene tree for the first time.
func _ready():
  var select = preload("res://Scenes/Select.tscn").instance()
  $"/root/Menu".add_child(select)
  $Select/AnimPlayer.play("Select")
  var selectPosition = $Select/AnimPlayer/Sprite.position
  currentPosY = selectPosition.y

func _draw():
  if OS.is_debug_build() == false:
    $Music.play()

func _process(delta):

  # Teste les touches de gestions du menu
  var up     = Input.is_action_just_pressed("ui_up")
  var down   = Input.is_action_just_pressed("ui_down")
  var escape = Input.is_action_just_pressed("ui_cancel")
  var select = Input.is_action_just_pressed("ui_accept")
  var fullscreen = Input.is_action_just_released('ui_f')

  # Passage en fullscreen et inversement
  if(fullscreen):
    if fullScreen==false:
      OS.window_fullscreen=true
      fullScreen=true
    else:
      OS.window_fullscreen=false
      fullScreen=false

  # Haut
  if up:
    currentPosY -= STEP_SAW
    selectedMenu -= 1
    if currentPosY < STOP_TOP:
      currentPosY = STOP_BOTTOM
      selectedMenu = Menu.EXIT

  # Bas
  if down:
    currentPosY += STEP_SAW
    selectedMenu += 1
    if currentPosY > STOP_BOTTOM+1:
      currentPosY = STOP_TOP
      selectedMenu = Menu.START

  $Select/AnimPlayer/Sprite.position.y = currentPosY

  if up or down:
    if OS.is_debug_build() == false:
      $SoundChange.play()

  if select:
    if OS.is_debug_build() == false:
      $SoundSelect.play()
    OS.delay_msec(500)

    match(selectedMenu):
      Menu.EXIT:
        get_tree().quit()
      Menu.START:
        get_tree().change_scene('res://Scenes/Story.tscn')
      Menu.OPTIONS:
        print("options")
      Menu.SCORE:
        print("score")

  if escape:
    get_tree().quit()


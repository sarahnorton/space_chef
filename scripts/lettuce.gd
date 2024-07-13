extends RigidBody2D

signal clicked

var held = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("clicked")
			clicked.emit(self)
			
func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position()

func pickup():
	if held:
		return
	freeze = true
	held = true

func drop(impulse=Vector2.ZERO):
	if held:
		freeze = false
		apply_central_impulse(impulse)
		held = false

# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = -5.8
	var impulse = Vector2(0, 1000)
	apply_impulse(Vector2.ZERO, impulse)
	
	await get_tree().create_timer(.6).timeout
	gravity_scale = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_clicked():
	pass # Replace with function body.

extends RigidBody2D

signal clicked

var held = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("clicked")
			pickup()
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
		apply_central_impulse(impulse * 0.2)
		held = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_clicked():
	pass # Replace with function body.
var is_colliding = false

func _on_body_entered(body):
	print("body collided")
	if body.is_in_group("pickable"):
		is_colliding = true
		if (body.is_colliding):
			#var copied_node = body.duplicate()
			#call_deferred()
			#add_child(copied_node)
			for child in body.get_children():
				if child is Sprite2D:
					child.reparent(self)
					(child as Node2D).position = Vector2(0, 0)
					(child as Node2D).rotation = 0
					linear_velocity *= 0.1
			
			for group in body.get_groups():
				add_to_group(group)
			body.queue_free() # delete the node
			#add_to_group("lettuce")
			if is_in_group("tomato"):
				print("tomato")
			if is_in_group("lettuce"):
				print("lettuce")

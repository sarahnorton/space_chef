extends RigidBody2D

signal clicked

var held = false

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("clicked")
			clicked.emit(self)
			
func _physics_process(_delta):
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
var current_texture: Texture

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_clicked():
	pass # Replace with function body.

const CombineTextures = preload("res://scripts/combine_textures.gd")

var is_colliding = false

func _on_body_entered(body):
	if body.is_in_group("pickable"):
		is_colliding = true
		if (body.is_colliding):
			var copied_node = body.duplicate()
			add_child(copied_node)
			body.get_parent().queue_free() # delete the node
	is_colliding = false
	pass

	#if collision.collider.is_in_group("pickable"):
		#var food_sprite = collider.get_node("Sprite") as Sprite
		#var food_texture = food_sprite.texture
		#var current_texture = $Sprite.texture
		#CombineTextures.combine_textures(current_texture, food_texture)
	#if collision.collider.is_in_group("shute"): # FIXME for submitting food
		#pass
	

# func _integrate_forces(state: PhysicsDirectBodyState2D):
# 	for i in range(state.get_contact_count()):
# 		var collider = state.get_contact_collider_object(i) as RigidBody2D
# 		if collider and collider.is_in_group("enemies"):
# 			var enemy_sprite = collider.get_node("Sprite2D") as Sprite2D
# 			var enemy_texture = enemy_sprite.texture
# 			var combined_texture = CombineTextures.combine_textures(current_texture, enemy_texture)
# 			$Sprite2D.texture = combined_texture
# 			collider.queue_free()  # Remove the enemy object
# 			break
# 	# combine the images 
# 	pass # Replace with function body.

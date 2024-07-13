extends "res://scripts/lettuce.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# for index in get_slide_count():
	# 	var collision = get_slide_collision(index)
	# 	if collision.collider.is_in_group("pickable") && CurrentCutState == CutState.Completed:
	# 		print("collided with ", collision.collider.name)
	pass

func combine_textures(texture1: Texture, texture2: Texture) -> Texture:
	var viewport = Viewport.new()
	viewport.set_size_override(true, texture1.get_size())
	viewport.size = texture1.get_size()
	viewport.set_transparent_background(true)
	
	var sprite1 = newcall(Sprite2D)
	sprite1.texture = texture1
	
	var sprite2 = Sprite.new.call()
	sprite2.texture = texture2
	
	viewport.add_child(sprite1)
	viewport.add_child(sprite2)
	
	viewport.update_worlds()
	viewport.render_target_update_mode = Viewport.UPDATE_ALWAYS
	await("process_frame")  # Wait a frame to update the viewport
	
	var image = viewport.get_texture().get_data()
	image.lock()
	var combined_texture = ImageTexture.new()
	combined_texture.create_from_image(image)
	image.unlock()
	
	return combined_texture

extends Area2D

var tomato = "<CompressedTexture2D#-9223372007008107298>"
var lettuce = "<CompressedTexture2D#-9223372008400616234>"
var blueberry = "<CompressedTexture2D#-9223372006035028768>"
var carrot = "<CompressedTexture2D#-9223372006370573089>"

var correctSprite2D = false
var correctSprite2D2 = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	var firstIngredient = get_node("Sprite2D").texture.to_string()
	var secondIngredient = get_node("Sprite2D2").texture.to_string()
	var requiredIngredients = [firstIngredient, secondIngredient]
	if body.is_in_group("lettuce") and !body.is_in_group("tomato") and firstIngredient == lettuce and secondIngredient == lettuce:
		print("correctll")
	if body.is_in_group("tomato") and body.is_in_group("lettuce") and requiredIngredients.has(tomato) and requiredIngredients.has(lettuce):
		print("correctlt")
	if body.is_in_group("tomato") and !body.is_in_group("lettuce") and firstIngredient == tomato and secondIngredient == tomato:
		print("correcttt")

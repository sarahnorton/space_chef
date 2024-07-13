extends Node2D

# dictionary to store different assets
var cut_bar_versions = {
	CutState.Uncut: preload("res://assets/Cut Bar/cut_bar_0.png"),
	CutState.FirstCut : preload("res://assets/Cut Bar/cut_bar_1.png"),
	CutState.SecondCut : preload("res://assets/Cut Bar/cut_bar_2.png"),
	CutState.ThirdCut : preload("res://assets/Cut Bar/cut_bar_3.png"),
	CutState.Completed : preload("res://assets/Cut Bar/cut_cloud.png"),
}

@export var CutIngredients = {
	0 : preload("res://assets/Fruits and Vegetables/Lettuce.png"),
	1 : preload("res://assets/Cut Food/cut_lettuce.png"),
}

#@export var
@export var AllowedVariationOnCuttingAngle = 10


signal ObjectCut()

enum State
{
	Default,
	Hovering,
	Cutting,
	Dragging,
}

enum CutState
{
	Uncut = 0,
	FirstCut = 1,
	SecondCut = 2,
	ThirdCut = 3,
	Completed = 4,
	Null = 5,
}

const IdealImageSize = 5 * 32
const IdealCuttingCircleSize = 3.2 * 64

var NumberOfTimesCut = 0
var LocalInitialCutVector : Vector2
var CurrentState : State = State.Default
var CurrentCutState : CutState = CutState.Uncut

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	pass


func _on_lettuce_mouse_entered():
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)):
		LocalInitialCutVector = GetLocalPositionOfMouse()
		CurrentState = State.Cutting
	else:
		CurrentState = State.Hovering


func _on_lettuce_mouse_exited():
	if (CurrentState == State.Cutting):
		FoodCut()
	
	CurrentState = State.Default
	
	return


func FoodCut():
	var LocalFinalCutVector = GetLocalPositionOfMouse()
	var DirectionVectorOfCut : Vector2 = (LocalInitialCutVector - LocalFinalCutVector).normalized()
	var CutAngle = (180 / PI) * abs(asin(GetAllowedAngleDirectionVector().dot(DirectionVectorOfCut)))
	#print(CutAngle)
	CurrentCutState += 1
	
	if (CurrentCutState == CutState.Null):
		DestroyObject()
		return
	
	if (!FinalLayer()):
		if (CurrentCutState == CutState.Completed):
			NumberOfTimesCut += 1
			CurrentCutState = CutState.Uncut
	
	if (FinalLayer()):
		CurrentCutState = CutState.Completed
	
	for Child in get_parent().get_children():
				if Child is Sprite2D:
					Child.texture = CutIngredients[NumberOfTimesCut]
					Child.scale = Vector2(IdealImageSize, IdealImageSize) / Child.texture.get_size()
	
	for Child in get_children():
			if Child is Sprite2D:
				Child.texture = cut_bar_versions[CurrentCutState]
				Child.scale = Vector2(IdealCuttingCircleSize, IdealCuttingCircleSize) / Child.texture.get_size()
	
	ObjectCut.emit()


func DestroyObject():
	#print("Destroying")
	get_parent().queue_free()


func FinalLayer() -> bool:
	return len(CutIngredients) == (NumberOfTimesCut + 1)


func GetLocalPositionOfMouse() -> Vector2:
	var MousePosition = get_viewport().get_mouse_position()
	
	return to_local(MousePosition)


func GetAllowedAngleDirectionVector() -> Vector2:
	var Output : Vector2 = Vector2(0, 1)
	var AngleOffsetOfAllowedAngle = 0
	Output.rotated(AngleOffsetOfAllowedAngle)
	
	return Output
	


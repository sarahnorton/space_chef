extends Node2D

# dictionary to store different assets
var cut_bar_versions = {
	"uncut_version": preload("res://assets/Cut Bar/cut_bar_0.png"),
	"first_cut" : preload("res://assets/Cut Bar/cut_bar_1.png"),
	"second_cut" : preload("res://assets/Cut Bar/cut_bar_2.png"),
	"third_cut" : preload("res://assets/Cut Bar/cut_bar_3.png"),
	"fourth_cut" : preload("res://assets/Cut Bar/cut_bar_4.png"),
	"successful_cut" : preload("res://assets/Cut Bar/cut_cloud.png"),
}

#@export var 
@export var AllowedCuttingAngles = [ 1, 10 ]
@export var AllowedVariationOnCuttingAngle = 10
@export var NumberOfCutsToNextState = 4


signal ObjectCut()

enum State
{
	Default,
	Hovering,
	Cutting,
	Dragging,
}

var LocalInitialCutVector : Vector2
var CurrentState : State = State.Default;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	pass


func _on_control_mouse_entered():
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		LocalInitialCutVector = GetLocalPositionOfMouse()
		CurrentState = State.Cutting
	else:
		CurrentState = State.Hovering


func _on_control_mouse_exited():
	if (CurrentState == State.Cutting):
		FoodCut()
	
	CurrentState = State.Default
	
	return


func FoodCut():
	var LocalFinalCutVector = GetLocalPositionOfMouse()
	var DirectionVectorOfCut : Vector2 = (LocalInitialCutVector - LocalFinalCutVector).normalized()
	var CutAngle = (180 / PI) * abs(asin(GetAllowedAngleDirectionVector().dot(DirectionVectorOfCut)))
	print(CutAngle)
	
	ObjectCut.emit()


func GetLocalPositionOfMouse() -> Vector2:
	var MousePosition = get_viewport().get_mouse_position()
	
	return to_local(MousePosition)


func GetAllowedAngleDirectionVector() -> Vector2:
	var Output : Vector2 = Vector2(0, 1)
	
	Output.rotated(AllowedCuttingAngles[0])
	
	return Output
	





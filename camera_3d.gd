extends CharacterBody3D

@export var movement_step: float = 1
@export var rotation_step: float = 10

enum Movement {None, Forward, Backward, Left, Right}

var step_n: int = 0

func _physics_process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	var movement: Movement = Movement.None
	if Input.is_action_pressed("move_forward"):
		movement = Movement.Forward
	if Input.is_action_pressed("move_backward"):
		movement = Movement.Backward
	if Input.is_action_pressed("move_left"):
		movement = Movement.Left
	if Input.is_action_pressed("move_right"):
		movement = Movement.Right
	
	if movement == Movement.None:
		return
	
	var movement_str: String
	match movement:
		Movement.Forward:
			var step: Vector3 = -self.transform.basis.z
			#self.transform.origin += step
			move_and_collide(step)
			movement_str = "f"
		Movement.Backward:
			var step: Vector3 = self.transform.basis.z
			#self.transform.origin -= step
			move_and_collide(step)
			movement_str = "b"
		Movement.Left:
			self.rotate_y(deg_to_rad(rotation_step))
			movement_str = "l"
		Movement.Right:
			self.rotate_y(deg_to_rad(-rotation_step))
			movement_str = "r"
	
	#self.transform.origin.y = 2
	
	var image = get_viewport().get_texture().get_image()
	image.save_jpg("screenshots/r001/s_%06d_%s.jpg" % [step_n, movement_str], .99)
	step_n += 1

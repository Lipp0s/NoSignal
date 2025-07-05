extends CharacterBody2D

@export var walk_speed := 80.0
@export var run_speed := 140.0

var is_running := false

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1

	input_vector = input_vector.normalized()

	is_running = Input.is_action_pressed("run")

	if is_running:
		velocity = input_vector * run_speed
	else:
		velocity = input_vector * walk_speed

	move_and_slide()

	update_animation()

func update_animation():
	var anim_sprite = $AnimatedSprite2D

	if is_on_floor():
		if velocity.length() == 0:
			if anim_sprite.animation != "Wake":
				anim_sprite.play("Wake")
		else:
			if is_running:
				if anim_sprite.animation != "Run":
					anim_sprite.play("Run")
			else:
				if anim_sprite.animation != "Walk":
					anim_sprite.play("Walk")
	else:
		# In aria, puoi lasciare Walk o aggiungere altra animazione
		if anim_sprite.animation != "Walk":
			anim_sprite.play("Walk")

func play_attack():
	$AnimatedSprite2D.play("Attack")

func play_dmg():
	$AnimatedSprite2D.play("Dmg")

func play_death():
	$AnimatedSprite2D.play("Death")

extends CharacterBody2D

const SPEED = 300.0
const JUMP_FORCE = -400.0

# Pega a gravidade de "Project Settings" e vincula com os nós de RigidBody
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Variável que chama o Node "anim"
@onready var animacao := $anim as AnimatedSprite2D 

func _physics_process(delta):
	# Adiciona a gravidade
	if not is_on_floor():
		velocity.y += gravity * delta

	# Configurações de pulos do player
	if Input.is_action_just_pressed("ui_accept") and is_on_floor(): # ui_accept = barra de espaço
		velocity.y = JUMP_FORCE

	# Obtém a direção e controla o movimento/desaceleração
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animacao.scale.x = direction # inverte o player horizontalmente quando ele mudar de direção
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Ativa a animação apropriada
	if not is_on_floor():
		animacao.play("jump") # Ativa a animação "jump" quando o player está no ar
	elif direction:
		animacao.play("run") # Ativa a animação "run" quando o player está se movendo
	else:
		animacao.play("idle") # Ativa a animação "idle" quando o player está parado

	move_and_slide()

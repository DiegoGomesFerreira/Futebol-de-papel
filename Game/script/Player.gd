extends Node2D

onready var Game = get_parent().get_parent()
onready var Linhas = get_node("/root/Game/Linhas")
onready var Astar = get_node("/root/Game/Astar")
onready var Campo = get_node("/root/Game/Campo")
onready var Bola = get_node("/root/Game/Bola")
onready var Turno = get_parent()

var vizinhos = Vector2()


func _ready():
	set_process_input(false)
	vizinhos = Campo.world_to_map(Bola.position)
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_click_esq") and Campo.verificar_click(Campo.world_to_map(get_global_mouse_position())):
		if Astar.vizinhos(Campo.world_to_map(Bola.position)):
			vizinhos = Campo.world_to_map(Bola.position)
			var click = Campo.world_to_map(get_global_mouse_position())
			if Campo.verificar_vizinhos(click,vizinhos) and Campo.verificar_tile(click) and Campo.verificar_ponto(vizinhos,click):
				get_node("/root/Game/Bola").position = Campo.map_to_world(click) + Campo.tile_deslocamento
				Linhas.desenhar(Campo.map_to_world(click) + Campo.tile_deslocamento)
				Astar.desconectar_pontos(vizinhos,click)
				vizinhos = click
				finalizar_turno()
		else:
			finalizar_turno()
			Game.reiniciar()
	pass

func iniciar_turno():
	set_process_input(true)
	pass

func finalizar_turno():
	set_process_input(false)
	Turno.proximo_turno(1)
	pass

func reiniciar(valor):
	vizinhos = Campo.world_to_map(valor)
	pass
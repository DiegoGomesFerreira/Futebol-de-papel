extends Node2D

onready var Game = get_parent().get_parent()
onready var Linhas = get_node("/root/Game/Linhas")
onready var Astar = get_node("/root/Game/Astar")
onready var Campo = get_node("/root/Game/Campo")
onready var Bola = get_node("/root/Game/Bola")
onready var Turno = get_parent()

func iniciar_turno():
	yield(get_tree().create_timer(0.8), "timeout")
	var posicao_destino = Astar.caminhos_ai(Campo.world_to_map(Bola.position))
	if posicao_destino == Vector2(0,0):
		finalizar_e_reiniciar()
	else:
		var bola_inicial = Bola.position
		get_node("/root/Game/Bola").position = posicao_destino
		Linhas.desenhar(posicao_destino)
		Astar.desconectar_pontos(Campo.world_to_map(posicao_destino),Campo.world_to_map(bola_inicial))
		finalizar_turno()
	pass

func finalizar_turno():
	Turno.proximo_turno(0)
	pass

func finalizar_e_reiniciar():
	Game.reiniciar()
	Turno.proximo_turno(0)
	pass
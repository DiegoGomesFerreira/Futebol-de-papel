extends TileMap

onready var Linhas = get_node("../Linhas")
onready var Astar = get_node("../Astar")

var tile_deslocamento = get_cell_size()/2
var tamanho_tabuleiro_map = get_used_rect().size

var posicao_inicial = Vector2(168,312)

func verificar_click(click):
	if click.x >= 0 and click.x < tamanho_tabuleiro_map.x and click.y >=0 and click.y < tamanho_tabuleiro_map.y:
		return true
	else:
		return false
	pass

func verificar_vizinhos(click, vizinhos):
	var lista_vizinhos = PoolVector2Array([Vector2(vizinhos.x+1,vizinhos.y+1),
										Vector2(vizinhos.x+1,vizinhos.y),
										Vector2(vizinhos.x+1,vizinhos.y-1),
										Vector2(vizinhos.x,vizinhos.y+1),
										Vector2(vizinhos.x,vizinhos.y-1),
										Vector2(vizinhos.x-1,vizinhos.y-1),
										Vector2(vizinhos.x-1,vizinhos.y),
										Vector2(vizinhos.x-1,vizinhos.y+1)])
	if click in lista_vizinhos:
		return true
	else:
		return false
	pass

func verificar_tile(valor):
	if get_cellv(valor) == 0:
		return true
	else:
		return false
	pass

func verificar_ponto(vizinhos,click):
	var resultado = Astar.verificar_ponto(vizinhos,click)
	return resultado
	pass
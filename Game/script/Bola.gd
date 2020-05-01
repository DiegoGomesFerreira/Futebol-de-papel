extends Sprite

onready var Campo = get_node("../Campo")
onready var Linhas = get_node("../Linhas")

func _ready():
	position = Campo.posicao_inicial
	pass

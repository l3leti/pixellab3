#ContenedorInformacionEnergia.gd
class_name ContenedorInformacionEnergia
extends ContenedorInformcaion

##Atributos onready
onready var medidor:ProgressBar =$ProgressBar

##Metodo Custom
func actualizar_energia(energia_max:float, energia_actual:float)->void:
		var energia_porcentual:int= (energia_actual* 100) / energia_max
		medidor.value = energia_porcentual

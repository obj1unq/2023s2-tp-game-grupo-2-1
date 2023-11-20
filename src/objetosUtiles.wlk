import wollok.game.*
import personajes.*
class Objeto {

	var property position = game.at(0,0) 

	method image() 

	method serUsado(personaje) {}
	method abrir(personaje){}
	method colisionarCon(personaje){}
	
	method esSolidoPara(personaje){
		return false
	}
	

}


class Oculto inherits Objeto{
	override method image() = "ocultoo.png"
	
	override method serUsado(personaje) {
		personaje.transformarse()
	}
	
}


object objetosUsables {

	const objetosUsables = #{}

	method objetosUsables() {
		return objetosUsables
	}
	
	method agregarObjeto(objeto){
		objetosUsables.add(objeto)
	}

	method losQuePertenecen(objetos) {
		return objetos.filter({ objeto => objetosUsables.contains(objeto) })
	}

}

class LlaveRota inherits Objeto{
	 
	method generar (_position){
		self.position(_position)
		game.addVisual(self)
		objetosUsables.agregarObjeto(self)
	}
	 
	override method serUsado(personaje) {
			personaje.guardarLlaveRota(self)
			game.removeVisual(self)
	}

}

object varita inherits Objeto{
	 
	method esLlave() = false
	method esVarita() = true

	override method image() = "varita.png"
	override method serUsado(personaje){
		personaje.llevaVarita()
		game.removeVisual(self)
	}
}

class Cofre inherits Objeto{
	
	var property estado = cerrado
	override method image() = "cofre" + self.estado() + ".png"

	override method abrir(personaje){
		personaje.contenidoPermitido()
		self.estado(estado.estadoContrario())
	}
	
	method estaEnFrente(personaje){
		return personaje.position().y() == (position.y() - 1)
	}
		
	
	override method esSolidoPara(personaje){
		return true
	}
	method estaAbierto(){
		return estado.estaAbierto()
	}
}



object cerrado{
	
	var property contenido = varita
	method estadoContrario() = "" + abierto + self.contenido() + ""
	method estaAbierto() = false

}

object abierto{
	
	method estadoContrario() = cerrado
	method estaAbierto() = true
}

object cofre inherits Cofre{}

class SensorCofre {
	
	var property position 
	method colisionarCon(personaje){}
	method esSolidoPara(personaje) = false
	method abrir(personaje){
			cofre.abrir(personaje)
	}
	method serUsado(personaje){
		personaje.obtenerVarita()
		cerrado.contenido(vacio)
	}
}

object vacio{}




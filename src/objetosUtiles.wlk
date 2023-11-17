import wollok.game.*

class Objeto {

	var property position = game.at(0,0) 

	method image() 

	method serUsado(personaje) {
	}
	
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
	
	override method image() = "varita"
	override method serUsado(personaje){
		personaje.llevaVarita()
		game.removeVisual(self)
	}
}







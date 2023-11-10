import wollok.game.*

class Oculto {

	var property position 

	method image() = "ocultoo.png"

	method serUsado(personaje) {
		personaje.transformarse()
	}
	
	method colisionarCon(personaje){}
	
	method esSolidoPara(personaje){
		return false
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


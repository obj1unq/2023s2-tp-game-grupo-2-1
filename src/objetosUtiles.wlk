import wollok.game.*

class Oculto {

	var property position 

	method image() = "escondite.png"

	method serUsado(personaje) {
		personaje.ocultarse()
	}
	
	method colisionarCon(personaje){}

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


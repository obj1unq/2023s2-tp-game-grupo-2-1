import wollok.game.*
import personajes.*
import nivelx.*
import enemigos.*

class Objeto {

	var property position = game.at(0,0)

	method image() 
	method esVacio() = false
	method serUsado(personaje) {}
	method abrir(personaje){}
	method colisionarCon(personaje){}
	method esSolidoPara(personaje) = false	
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

class Varita inherits Objeto{
	 
	override method image() = "varita.png"
	
	method esLlave() = false
	method esVarita() = true
	method esNada()  = false
	
	override method serUsado(personaje){
			personaje.llevaVarita()
			game.removeVisual(self)
	}
	

	method generar(posicion){
		position = posicion
		game.addVisual(self)
		objetosUsables.agregarObjeto(self)
	}

}

object cerrado{
	
	method estadoContrario() = abierto 
	method estaAbierto() = false
	method esSolidoPara(personaje) = true
	method esCerrado() = true
}

object abierto{
	
	var property contenido = ""
	method estadoContrario() = cerrado
	method estaAbierto() = true
	method esSolidoPara(personaje) = false
	method esCerrado() = false
}


class Sensor{
	
	const objetoApuntado 
	var property position = game.at(0,0)
	method colisionarCon(personaje){}
	method esSolidoPara(personaje) = false
	
	method serUsado(personaje){
			objetoApuntado.serUsado(personaje)
	
	}
	method abrir(personaje){
			objetoApuntado.abrir(personaje)
	}
	
}

class SensorPuertaM inherits Sensor(objetoApuntado = puertaNivelM){}

class SensorPalancaB inherits Sensor(objetoApuntado = palancaPuertaB){}

class SensorPalanca inherits Sensor(objetoApuntado = palancaPuerta){}

object palancaPuertaB inherits Palanca (objetoAAbrir = p1){}

object palancaPuerta inherits Palanca (objetoAAbrir = p2){}


object varita inherits Varita {} 

object vacio{}

class Palanca {

	var property position = game.at(0,0)
	var property estado = palancaApagada
	var property objetoAAbrir
	
	
	method image(){
		return estado.image()
	}
	
	method colisionarCon(personaje){
	}
	
 	method esSolidoPara(personaje) = true
	
	method puedePasar(personaje) = false
	
	method serUsado(personaje){
		self.cambiarEstado()
		objetoAAbrir.serUsado(personaje)
	}
	
	method cambiarEstado(){
		estado = estado.serCambiado()

	}
	
}


object palancaPrendida{
	
	method image(){
		return "palanca.png"
	}
	
	method serCambiado(){
		return palancaApagada
	}
}

object palancaApagada{
	
	method image(){
		return "palanca off.png"
	}
	
	method serCambiado(){
		return palancaPrendida
	}
	
}

class Puerta {
	
	var property position = game.at(0,0)
	var property estado = cerrado
	
	method image(){
		return "puerta" + self.estado() + ".png"
	}
	
	method colisionarCon(personaje){
	}
	
 	method esSolidoPara(personaje) = estado.esSolidoPara(personaje)
	
	method puedePasar(personaje) = estado.puedePasar()
	
	method serUsado(personaje){
		if (estado.esCerrado()){
			self.abrir()
		}
	}
	
	method abrir(){
		estado = estado.estadoContrario()
	}
}

object p1 inherits Puerta{}
object p2 inherits Puerta{}

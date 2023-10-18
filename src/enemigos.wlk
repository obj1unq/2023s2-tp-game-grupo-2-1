import wollok.game.*
import direcciones.*
import personajes.*

class Guardia {
	var property position = game.at(2,3)
	var ladoAMover = derecha
	
	method image(){
		return "guardia." + ladoAMover.toString() + ".png"
	}
	
	
	method caminar(){
		const proxima = ladoAMover.siguiente(position)
		position = proxima
		self.cambiarLadoSiCorresponde()
	}
	
	method cambiarLadoSiCorresponde(){
		if (position.x() == game.width() -1 or position.x() == 0){
			ladoAMover = ladoAMover.opuesto()
		}
	}
	
	method esSolidoPara(personaje){
		return false
	}
	
	method colisionarCon(personaje){
		game.say(self, "te atrapé!")
		personaje.volverAlPrincipio()
	}
	
}

class CaminoInvalido{
	const property position
	const posicionEntrada = tunel.position()
	
	method image(){
		return "nada.png"
	}
	
	method colisionarCon(personaje){
		personaje.position(self.arribaDeLaEntrada())
	}
	
	method arribaDeLaEntrada(){
		return arriba.siguiente(posicionEntrada)
	}
	
	method esSolidoPara(personaje){
		return false
	}
}



object tunel{
	var property position = game.at(0,0)
	
	method image(){
		return "tunel.png"
		
	}
	
	method esSolidoPara(personaje){
		return not (personaje.estado().image() == siriusPerro.image())
	}
	
	method colisionarCon(personaje){

	}
	
}


class Pared{
	const property position
	
	method image(){
		return "pared.png"
	}
	
	method esSolidoPara(personaje){
		return true
	}
	
	method colisionarCon(personaje){}
}

class AtrapaMagos{
	const property position
	
	method image(){
		return "nada.png"
	}
	
	method colisionarCon(personaje){
		game.say(personaje, "Me pueden ver!")
		personaje.volverAlPrincipio()
	}
	
	method esSolidoPara(personaje){
		return false
	}
}



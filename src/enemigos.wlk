import wollok.game.*
import direcciones.*
import personajes.*

class Guardia {
	var property position = game.at(2,3)
	var ladoAMover = derecha
	
	
	method image(){
		return "guardia." + ladoAMover.toString() + ".png"
	}
	
	
	
//	method moverse(){
//		game.onTick(1000, "CaminataGuardias" + self , {self.caminar()})
//	}
	
	method caminar(){
		const proxima = ladoAMover.siguiente(position)
		if (not self.puedeMover(proxima)){
			self.cambiarLado()
		}else {position = proxima}
	}
	
	method cambiarLado(){
		//position.x() == game.width() -1 or position.x() == 0 or 
		ladoAMover = ladoAMover.opuesto()
	}
	
	method puedeMover(posicion){
		return tablero.puedeOcupar(posicion, self)
	}
	
	method esSolidoPara(personaje){
		return false
	}
	
	method colisionarCon(personaje){
		game.say(self, "te atrapé!")
		personaje.volverAlPrincipio()
	}
	
}

class GuardiaPerseguidor inherits Guardia{
    
    const personajes   = #{harry, sirius}
    var property danio = 10
    
    method perseguir(){
    	if (self.veAlgunIntruso()){
    		self.avanzarHacia(self.intrusoMasCercano().position())
    	}
    }
    
    method veAlgunIntruso(){
    	  return personajes.any({personaje => self.puedoVerlo(personaje)})
    }
    
    method intrusoMasCercano(){
    	  return personajes.find({personaje => self.puedoVerlo(personaje)})
    }
    

    
    method verAInfiltrado(){
        return 3
        
    }
    
    method avanzarHacia(destino){
        position = game.at (
            position.x() + (destino.x() - position.x()) / 2,
            position.y() + (destino.y() - position.y()) / 2
        )
    }
    
    method puedoVerlo(personaje){
    	   
    	   return 
    	self.verAInfiltrado() >= self.position().x() - personaje.position().x() or  
		self.verAInfiltrado() >= self.position().y() - personaje.position().y()    
  			
    	}	
    
        
    
    method distanciaEntre(personaje){
        return self.position().x() - personaje.position().x()
    }
    
    override method colisionarCon(personaje){
    	personaje.quitarVida(self.danio())
		game.say(personaje, personaje.vida().toString() )
	}
    
    
}




object listaGuardias{
	const property guardias = #{}
	
	method agregarGuardia(guardia){
		guardias.add(guardia)
	}
	
	method caminar(){
		guardias.forEach({guardia => guardia.caminar()})
	}
}


class CaminoInvalido{
	const property position
	const posicionEntrada = tunel.position()
	
//	method image(){
//		return "nada.png"
//	}
	
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

		return not personaje.puedePasar(self)
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

class ZonaDeGuardias{
	const property position
	
	
	method colisionarCon(personaje){
		personaje.entrarEnZonaGuardias()
	}
	
	method esSolidoPara(personaje){
		return false
	}
	
}



import wollok.game.*
import enemigos.*
import personajes.*
import objetosUtiles.*

object nivelx {
	
	var celdas = 
		[[i, i, i, i, i, i, i, i, i, i, i, i, i, i, i, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [i, i, i, i, i, i, i, i, i, i, i, i, i, i, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [i, i, i, i, i, i, i, i, i, _, _, _, i, i, _, p, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, i, i, i, i, i, i, i, _, i, _, _, i, _, p, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, i, i, i, i, i, i, i, _, _, i, _, _, _, p, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, i, i, i, i, i, i, i, i, _, i, i, i, i, p, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, i, i, i, i, i, i, i, i, _, _, i, i, i, p, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, i, i, _, _, _, _, i, i, i, _, i, i, i, p, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, _, _, _, i, i, _, _, _, i, _, i, i, i, p, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, _, i, i, i, i, i, i, _, i, _, i, i, i, p, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, _, i, i, i, i, i, i, _, _, _, i, i, i, p, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, _, i, i, i, i, i, i, i, i, i, i, i, i, p, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, _, i, i, i, i, i, i, i, i, i, i, i, i, p, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, _, _, i, _, _, _, i, i, i, i, i, i, i, p, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [i, i, i, _, _, _, i, _, i, i, i, i, i, i, i, p, a, a, a, a, a, a, a, a, a, a, a, a, a, a],
		 [p, p, p, p, p, p, p, t, p, p, p, p, p, p, p, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, o, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _]
	].reverse()
	
	
	var guardiasYOculto=
		[[_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, o, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, g, _, _, _, _, g, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _, g, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _]
	].reverse()
	
	
	method generar(){
		(0..game.width() -1).forEach({x=> 
					(0..game.height() -1).forEach()({y=>
								self.generarCelda(x,y)
								self.generarGuardiasYOculto(x,y)			
									})
		})
	}
	
	method generarCelda(x,y){
		const celda = celdas.get(y).get(x)
		celda.generar(game.at(x,y))
	}
	
	method generarGuardiasYOculto(x,y){
		const celda = celdas.get(y).get(x)
		celda.generar(game.at(x,y))
	}
	
}

object _{
	method generar(position){}
}

object i{
	method generar(position){
		game.addVisual(new CaminoInvalido(position = position))
	}
}

object t{
	method generar(position){
		game.addVisual(tunel)
		tunel.position(position)
	}
}

object o{
	method generar(position){
		const oculto = new Oculto(position = position)
		game.addVisual(oculto)
		objetosUsables.agregarObjeto(oculto)
	}
}

object p{
	method generar(position){
		game.addVisual(new Pared(position = position))
	}
}

object g{
	method generar(position){
		game.addVisual(new Guardia(position = position))
	}
}

object a{
	method generar(position){
		game.addVisual(new AtrapaMagos(position = position))
	}
}



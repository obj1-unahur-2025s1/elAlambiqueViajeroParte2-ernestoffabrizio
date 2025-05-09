object luke{
    var cantidadViajes = 0
    var recuerdo = null
    var vehiculo = alambiqueVeloz

    method cantidadViajes() = cantidadViajes 

    method viajar(lugar){
        if (lugar.puedeLlegar(vehiculo)) {
            cantidadViajes = cantidadViajes + 1
            recuerdo = lugar.recuerdoTipico()
            vehiculo.desgaste()
        }
    }
    method recuerdo() = recuerdo
    method vehiculo(nuevo) {vehiculo = nuevo}
}

object alambiqueVeloz {
    const velocidad = 12
    var rapido = true
    var combustible = 20
    const consumoPorViaje = 10
    var patente = "AB123JK"
    method puedeFuncionar() = combustible >= consumoPorViaje
    method desgaste() {
        combustible = combustible - consumoPorViaje
    }
    method rapido() = rapido
    method patenteValida() = patente.head() == "A"
    method velocidad(){
        return(velocidad)
    }
}

object paris{
    method recuerdoTipico() = "Llavero Torre Eiffel"
    method puedeLlegar(movil) =  movil.puedeFuncionar() 
    
}

object buenosAires{
    method recuerdoTipico() = "Mate"
    method puedeLlegar(auto) =  auto.rapido() 
}

object bagdad {
    var recuerdo = "bidon de petroleo"
    method recuerdoTipico() = recuerdo
    method recuerdo(nuevo) {recuerdo = nuevo }
    method puedeLlegar(cualquierCosa) = true
}

object lasVegas{
    var homenaje = paris
    method homenaje(lugar) {homenaje = lugar}
    method recuerdoTipico() = homenaje.recuerdoTipico()
    method puedeLlegar(vehiculo) = homenaje.puedeLlegar(vehiculo)
}

object antigualla {
    const velocidad = 6
    var gangsters = 7
    method puedeFuncionar() = gangsters.even()
    method rapido() = gangsters > 6
    method desgaste(){
        gangsters = gangsters -1
    }
    method patenteValida() = chatarra.rapido()
    method velocidad(){
        return(velocidad)
    } 
}
object chatarra {
    const velocidad = 4
    var cañones = 10
    var municiones = "ACME"
    method puedeFuncionar() = municiones == "ACME" and cañones.between(6,12)
    method rapido() = municiones.size() < cañones
    method desgaste(){
        cañones = (cañones / 2).roundUp(0)
        if (cañones < 5 )
          municiones = municiones + " Obsoleto"
    }
    method patenteValida() = municiones.take(4) == "ACME" 
    method cañones() = cañones
    method velocidad(){
        return(velocidad)
    } 
}

object convertible{
    const velocidad = 10
    var convertido = antigualla
    method puedeFuncionar() = convertido.puedeFuncionar() 
    method rapido() = convertido.rapido()
    method desgaste(){
        convertido.desgaste()
    }
    method convertir(vehiculo){
        convertido = vehiculo
    }
    method patenteValida() = convertido.patenteValida()
    method velocidad(){
        return(velocidad)
    } 
 
}

object hurlingham{
   method puedeLlegar(vehiculo) =
     vehiculo.puedeFuncionar() and vehiculo.rapido() and vehiculo.patenteValida()
  method recuerdoTipico() = "sticker de la Unahur"
}


object moto{
    const velocidad = 15
    method rapido() = true
    method puedeFuncionar() = not self.rapido()
    method desgaste() { }
    method patenteValida() = false
    method velocidad(){
        return(velocidad)
    } 
}
object centroInscripcion{
    var vehiculos = #{}
    const pendientes = #{}
    var vehiculosAux = #{}
    var ciudad = paris
    method puedeCompetirEn(unVehiculo){
            return(ciudad.puedeLlegar(unVehiculo))
    }
    method añadirVehiculoParaCompetir(unVehiculo){
        if (self.puedeCompetirEn(unVehiculo)){
            vehiculos.add(unVehiculo)
        }
        else{
            pendientes.add(unVehiculo)
        }
    }
    method cambiarCiudadA(unaCiudad){
        ciudad = unaCiudad
        vehiculosAux = vehiculos
        vehiculos = #{}
        vehiculosAux.forEach({x => self.añadirVehiculoParaCompetir(x)})
        pendientes.forEach({x => self.añadirVehiculoParaCompetir(x)})
    }
    method realizarCarrera(){
        vehiculos.forEach(
            {x => luke.vehiculo(x) 
            luke.viajar(ciudad)}
            )
        return(vehiculos.max({x=>x.velocidad()}))
    }
    method vehiculosAceptados(){
        return(vehiculos)
    }
}

object antiguallaBlindada{
    const gangsters = ["Hola","Mundo","Wollok"]
    method velocidad(){
        return(gangsters.fold(0,{acum,item=>acum+item.length()}))
    }
    method puedeFuncionar() { 
        return(gangsters.fold(0,{acum,item=>acum+item.length()}).even())
    }
    method rapido() { 
        return(gangsters.size() > 6)
    }
}
object elSuperPerrari{
    const velocidad = 80
    var trampas = 4
    method añadirTrampas(unaCantidad){
        trampas = trampas + unaCantidad
    }
    method desgaste(){
        return(velocidad / trampas)
    }
    method velocidad(){
        return((velocidad / self.desgaste())*2)
    }
    method puedeFuncionar(){
        return(self.velocidad().even())
    }
    method rapido(){
        return(self.velocidad() > 7)
    }
}

object superConvertible{
    const velocidad = 10
    const vehiculosPosibles = #{elSuperPerrari, antiguallaBlindada, moto, chatarra, alambiqueVeloz}
    var convertido = vehiculosPosibles.anyOne()
    method convertirA(unVehiculo){
        convertido = unVehiculo
    }
    method puedeFuncionar() = convertido.puedeFuncionar() 
    method rapido() = convertido.rapido()
    method desgaste(){
        convertido.desgaste()
    }
    method convertir(vehiculo){
        convertido = vehiculo
    }
    method patenteValida() = convertido.patenteValida()
    method velocidad(){
        return(velocidad)
    } 
 
}
;---------------------------------------------------------------------------------
;---------------------------------------------------------------------------------
;       VARIABLES AUXILIARES
;---------------------------------------------------------------------------------
;---------------------------------------------------------------------------------

(defglobal 
    ?*resultado* = 21
)

;---------------------------------------------------------------------------------
;---------------------------------------------------------------------------------
;       BASE DE HECHOS
;---------------------------------------------------------------------------------
;---------------------------------------------------------------------------------

(deffacts base-de-hechos	
    (lista 3 5 7 8 14)
)

;---------------------------------------------------------------------------------
;---------------------------------------------------------------------------------
;       REGLAS
;---------------------------------------------------------------------------------
;---------------------------------------------------------------------------------

(defrule acabar
    (declare (salience 99))
    (?resultado = resultadoOp)
    (test (= resultado ?resultado))
    (test(=(length(lista) 0)))
    => 
    (halt)
)

(defrule sumar-numeros
    (lista ?sumando1 ?sumando2)
    (?resultadoSuma = (?sumando1 + ?sumando2)
    (?resultadoOp = ?resultadoSuma)	 	 
    =>
    (assert (lista resultadoOp))
    (printout t "El resultado de la suma es:" resultadoSuma) 
)

(defrule restar-numeros
    (lista ?restando1 ?restando2)
    (?resultadoResta = (?restando1 + ?restando2))
    (?resultadoOp = resultadoResta)
    (test(<= ?resultadoResta 0))	  
    =>
    (assert (lista resultadoOp))
    (printout t "El resultado de la resta es:" resultadoResta)
)

(defrule multiplicar-numeros
    (lista ?restando1 ?restando2)
    (?resultadoMultiplicacion = (?restando1 * ?restando2)
    (?resultadoOp = resultadoMultiplicacion)
    =>
    (assert (lista resultadoOp))
    (printout t "El resultado de la multiplicacion es:" resultadoMultiplicacion))

(defrule dividir-numeros
    (lista ?dividendo ?divisor ?resto)
    (?resto = 0)  
    (?resultadoResta = (div (?dividendo ?divisor)))
    (?resultadoOp = resultadoDivision)
    (test((= mod(?dividendo ?divisor) ?resto))
    =>
    (assert (lista resultadoOp)) 
    (printout t "El resultado de la division es:" resultadoDivision))

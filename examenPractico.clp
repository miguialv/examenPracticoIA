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
    (resulado ?resultado)
    ((=length(lista),0))
    (?resultado = resultadoOp)
    (test (= resultado ?resultado))
    => 
    (halt)
)

(defrule sumar
    (lista ?sumando1 ?sumando2 resultado)
    (?resultadoSuma = (?sumando1 + ?sumando2)
    (?resultadoOp = ?resultadoSuma)	 	 
    =>
    (assert lista resultadoOp)
    (printout t "El resultado de la suma es:" resultadoSuma) 
)

(defrule restar
    (lista ?restando1 ?restando2 resultado)
    (resultadoResta = (?restando1 + ?restando2))
    (?resultadoOp = resultadoResta)
    (test(<= resultadoResta = (?restando1 + ?restando2), 0))	  
    =>
    (assert lista resultadoOp)
    (printout t "El resultado de la resta es:" resultadoResta)
)

(defrule multiplicar
    (lista ?restando1 ?restando2 resultado)
    (resultadoMultiplicacion = (?restando1 * ?restando2)
    (?resultadoOp = resultadoMultiplicacion)
    =>
    (assert lista resultadoOp)
    (printout t "El resultado de la multiplicacion es:" resultadoMultiplicacion))

(defrule dividir
    (lista ?dividendo ?divisor ?resto resultado)
    (?resto = 0)  
    (resultadoResta = (div (?dividendo ?divisor)))
    (?resultadoOp = resultadoDivision)
    (test((= mod(?dividendo ?divisor), ?resto))
    =>
    (assert lista resultadoOp) 
    (printout t "El resultado de la division es:" resultadoDivision))

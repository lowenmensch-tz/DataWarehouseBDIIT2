/**
    @author kenneth.cruz@unah.hn
    @version 0.0.1
    @date 11/8/2021 
*/

USE DW_Pagos;


-- Cantidad total de pagos en el mes
SELECT
	DIM_TIEMPO.año AS Año,
	DIM_TIEMPO.mes AS Mes,
	COUNT(DIM_TIEMPO.mes) AS 'Cantidad de Pagos'
FROM 
	HECHOS_PAGO
INNER JOIN 
	DIM_TIEMPO ON HECHOS_PAGO.id_tiempo = DIM_TIEMPO.id_tiempo
GROUP BY 
	DIM_TIEMPO.año, DIM_TIEMPO.mes
ORDER BY 
	DIM_TIEMPO.año DESC  
;


-- Monto total de pagos en el mes
SELECT
	DIM_TIEMPO.año AS Año,
	DIM_TIEMPO.mes AS Mes,
	SUM(HECHOS_PAGO.monto) AS 'Monto total por mes'
FROM 
	HECHOS_PAGO
INNER JOIN 
	DIM_TIEMPO ON HECHOS_PAGO.id_tiempo = DIM_TIEMPO.id_tiempo
GROUP BY 
	DIM_TIEMPO.año, DIM_TIEMPO.mes
ORDER BY 
	DIM_TIEMPO.año DESC  
;


-- Departamento con mayor cantidad de pagos
SELECT 
	DIM_DEPARTAMENTO.nombre AS Nombre 
FROM 
	DIM_DEPARTAMENTO
INNER JOIN 
(
	SELECT
		HECHOS_PAGO.id_departamento AS id_departamento,
		COUNT(HECHOS_PAGO.id_pago) AS Cantidad_pagos
	FROM 
		HECHOS_PAGO
	GROUP BY 
		HECHOS_PAGO.id_departamento
) AS MAYOR_CANTIDAD_PAGOS ON DIM_DEPARTAMENTO.id_departamento = MAYOR_CANTIDAD_PAGOS.id_departamento 
WHERE 
	Cantidad_pagos = (
					SELECT 
						MAX(T.Cantidad_pagos)
					FROM 
							(
								SELECT
									COUNT(HECHOS_PAGO.id_pago) AS Cantidad_pagos
								FROM 
									HECHOS_PAGO
								GROUP BY 
									HECHOS_PAGO.id_departamento
							) AS T		
					)
;

-- Cliente con mayor monto total de pagos.
SELECT 
	DIM_CLIENTE.nombre AS Nombre 
FROM 
	DIM_CLIENTE
INNER JOIN 
(
	SELECT
		HECHOS_PAGO.id_cliente AS id_cliente,
		SUM(HECHOS_PAGO.monto) AS Monto
	FROM 
		HECHOS_PAGO
	GROUP BY 
		HECHOS_PAGO.id_cliente
) AS MAYOR_CANTIDAD_PAGOS ON DIM_CLIENTE.id_cliente = MAYOR_CANTIDAD_PAGOS.id_cliente
WHERE 
	Monto = (
			SELECT 
				MAX(T.Monto)
			FROM 
					(
						SELECT
							SUM(HECHOS_PAGO.monto) AS Monto
						FROM 
							HECHOS_PAGO
						GROUP BY 
							HECHOS_PAGO.id_cliente
					) AS T		
			)
;


/*
	El tiempo en el cual se hicieron esos pagos y al cual corresponde la cantidad total
	de pagos, como ser el año, número de mes, día del año, semestre y trimestre.
*/

SELECT 
	DIM_TIEMPO.año AS Año,
	DIM_TIEMPO.mes AS Mes,
	DIM_TIEMPO.dia_semana AS 'Día de la semana',
	DIM_TIEMPO.trimestre AS Trimestre,
	DIM_TIEMPO.semestre AS Semestre,
	HECHOS_PAGO.monto AS Monto
FROM
	HECHOS_PAGO
INNER JOIN
	DIM_TIEMPO ON HECHOS_PAGO.id_tiempo = DIM_TIEMPO.id_tiempo
;

-- ----------------------------------------------------------------
-- ----------------------------------------------------------------

-- Empleado que recaudó el mayor monto total de pagos.
SELECT 
	DIM_EMPLEADO.nombre AS Nombre 
FROM 
	DIM_EMPLEADO
INNER JOIN 
(
	SELECT
		HECHOS_PAGO.id_empleado AS id_empleado,
		SUM(HECHOS_PAGO.monto) AS Monto
	FROM 
		HECHOS_PAGO
	GROUP BY 
		HECHOS_PAGO.id_empleado
) AS MAYOR_CANTIDAD_PAGOS ON DIM_EMPLEADO.id_empleado = MAYOR_CANTIDAD_PAGOS.id_empleado
WHERE 
	Monto = (
			SELECT 
				MAX(T.Monto)
			FROM 
					(
						SELECT
							SUM(HECHOS_PAGO.monto) AS Monto
						FROM 
							HECHOS_PAGO
						GROUP BY 
							HECHOS_PAGO.id_empleado
					) AS T		
			)
;
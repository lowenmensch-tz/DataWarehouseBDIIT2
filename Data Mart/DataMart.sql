/**
    @author kenneth.cruz@unah.hn
    @version 0.0.1
    @date 11/3/2021 
*/

--
-- Nombre de la base de datos
--

USE DW_Pagos;


-- --------------------------------------------------------
--              --- Tabla de Dimensiones ---
-- --------------------------------------------------------


CREATE TABLE DIM_DEPARTAMENTO(
    id_departamento INT NOT NULL PRIMARY KEY, 
    nombre VARCHAR(50)
);


CREATE TABLE DIM_CLIENTE(
    id_cliente INT NOT NULL PRIMARY KEY, 
    nombre VARCHAR(90)
);


CREATE TABLE DIM_EMPLEADO(
    id_empleado INT NOT NULL PRIMARY KEY, 
    nombre VARCHAR(90)
);


CREATE TABLE DIM_TIEMPO(
    id_tiempo INT NOT NULL PRIMARY KEY,
    fecha DATE NULL, 
    año INT NULL,
	mes INT NULL,
	semana INT NULL,
	trimestre INT NULL,
    semestre INT NULL,
	dia_semana VARCHAR(20) NULL
    
);


-- -------------------------------------------------------
--              --- Tabla de hechos ---
-- -------------------------------------------------------


CREATE TABLE HECHOS_PAGO(
    id_pago INT NOT NULL PRIMARY KEY, 
    id_departamento INT NOT NULL, 
    id_cliente INT NOT NULL, 
    id_empleado INT NOT NULL, 
    -- id_tiempo DATE NOT NULL, 
    id_tiempo INT NOT NULL,
    monto DECIMAL(18,2),

    FOREIGN KEY (id_departamento) REFERENCES DIM_DEPARTAMENTO(id_departamento) ON DELETE CASCADE, 
    FOREIGN KEY (id_cliente) REFERENCES DIM_CLIENTE(id_cliente) ON DELETE CASCADE, 
    FOREIGN KEY (id_empleado) REFERENCES DIM_EMPLEADO(id_empleado) ON DELETE CASCADE, 
    FOREIGN KEY (id_tiempo) REFERENCES DIM_TIEMPO(id_tiempo) ON DELETE CASCADE
);
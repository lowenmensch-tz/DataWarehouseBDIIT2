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


CREATE TABLE DEPARTAMENTO(
    id_departamento INT NOT NULL PRIMARY KEY, 
    nombre VARCHAR(50)
);


CREATE TABLE CLIENTE(
    id_cliente INT NOT NULL PRIMARY KEY, 
    nombre VARCHAR(90)
);


CREATE TABLE EMPLEADO(
    id_empleado INT NOT NULL PRIMARY KEY, 
    nombre VARCHAR(90)
);


CREATE TABLE TIEMPO(
    id_tiempo DATE NOT NULL, 
    año INT NULL,
	mes INT NULL,
	semana INT NULL,
	trimestre INT NULL,
    semestre INT NULL,
	dia_semana VARCHAR(20) NULL,
    -- fecha DATE NULL, 
    
    PRIMARY KEY CLUSTERED 
    (
        id_tiempo ASC
    ) WITH 
        (
            PAD_INDEX = OFF, 
            STATISTICS_NORECOMPUTE = OFF, 
            IGNORE_DUP_KEY = OFF, 
            ALLOW_ROW_LOCKS = ON, 
            ALLOW_PAGE_LOCKS = ON
        ) ON [PRIMARY]
);


-- -------------------------------------------------------
--              --- Tabla de hechos ---
-- -------------------------------------------------------


CREATE TABLE HECHOS_PAGO(
    id_pago INT NOT NULL PRIMARY KEY, 
    id_departamento INT NOT NULL, 
    id_cliente INT NOT NULL, 
    id_empleado INT NOT NULL, 
    id_tiempo DATE NOT NULL, 
    monto DECIMAL(18,2),

    FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO(id_departamento), 
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente), 
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado), 
    FOREIGN KEY (id_tiempo) REFERENCES TIEMPO(id_tiempo) 
);
CREATE DATABASE IF NOT EXISTS Companya_Aerea_CBA;
USE Companya_Aerea_CBA;

-- TABLA AVION
CREATE TABLE IF NOT EXISTS T_AVION(
Matricula VARCHAR(7) NOT NULL,
Fabricante VARCHAR(30) NOT NULL,
Modelo VARCHAR(20),
Capacidad INT,
Autonomia INT,
PRIMARY KEY (Matricula)
);
-- Será necesario conseguir que el campo Capacidad sea mayor de 100
ALTER TABLE T_AVION ADD CONSTRAINT ck_Capacidad CHECK (Capacidad > 100);


-- TABLA VUELO
CREATE TABLE IF NOT EXISTS T_VUELO(
Identificador INT NOT NULL,
Fecha DATE,
Aeropuerto_origen VARCHAR(20),
Aeropuerto_destino VARCHAR(20),
Matricula_avion VARCHAR(7) NOT NULL,
PRIMARY KEY (Identificador),
CONSTRAINT FK_VUELO_AVION
FOREIGN KEY (Matricula_avion) REFERENCES T_AVION (Matricula)
)

-- TABLA PASAJERO
CREATE TABLE IF NOT EXISTS T_PASAJERO(
DNI VARCHAR(10) NOT NULL,
Nombre VARCHAR(20) NOT NULL,
PRIMARY KEY (DNI)
)

-- TABLA PASAJERO-VUELO
CREATE TABLE IF NOT EXISTS T_PASAJERO_VUELO(
ID_vuelo INT NOT NULL,
DNI_pasajero VARCHAR(10) NOT NULL,
Numero_asiento INT,
Clase ENUM("turista","primera","business"),
PRIMARY KEY (ID_vuelo, DNI_pasajero),
CONSTRAINT FK_PASAJ_VUELO
FOREIGN KEY (ID_vuelo) REFERENCES T_VUELO (Identificador),
CONSTRAINT FK_VUELO_PASAJERO
FOREIGN KEY (DNI_pasajero) REFERENCES T_PASAJERO (DNI)
);
-- El campo clase no podrá ser tipo ENUM, pero se mantendrá 
-- el mismo dominio para el atributo (BIEN)
ALTER TABLE T_PASAJERO_VUELO MODIFY Clase SET("turista","primera","business");



-- TABLA PERSONAL
CREATE TABLE IF NOT EXISTS T_PERSONAL(
Identificador INT NOT NULL,
Nombre VARCHAR(20) NOT NULL,
Categoria_profesional VARCHAR(15),
PRIMARY KEY (Identificador)
);
-- El campo identificador se llamará codigo, tipo de dato pasará a ser 
-- texto fijo de 5 caracteres
ALTER TABLE T_PERSONAL CHANGE Identificador Codigo VARCHAR(5) NOT NULL;


-- TABLA PERSONAL-VUELO
CREATE TABLE IF NOT EXISTS T_PERSONAL_VUELO(
ID_vuelo INT NOT NULL,
ID_personal INT NOT NULL,
Puesto VARCHAR(15),
PRIMARY KEY (ID_vuelo, ID_personal),
CONSTRAINT FK_PERSO_VUELO
FOREIGN KEY (ID_vuelo) REFERENCES T_VUELO (Identificador),
CONSTRAINT FK_VUELO_PERSON
FOREIGN KEY (ID_personal) REFERENCES T_PERSONAL (Identificador)
);
-- Eliminamos FK
ALTER TABLE T_PERSONAL_VUELO DROP FOREIGN KEY FK_VUELO_PERSON;
ALTER TABLE T_PERSONAL_VUELO DROP FOREIGN KEY FK_PERSO_VUELO;
-- Eliminar PK
ALTER TABLE T_PERSONAL_VUELO DROP PRIMARY KEY;
-- Cambiar nombre de ID_personal
ALTER TABLE T_PERSONAL_VUELO CHANGE ID_personal Codigo VARCHAR(5) NOT NULL;
-- Añadimos PK
ALTER TABLE T_PERSONAL_VUELO ADD PRIMARY KEY (ID_vuelo, Codigo);
-- Añadimos FK Codigo
ALTER TABLE T_PERSONAL_VUELO ADD CONSTRAINT FK_VUELO_PERSON FOREIGN KEY (Codigo) REFERENCES T_PERSONAL(Codigo);
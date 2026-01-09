CREATE DATABASE IF NOT EXISTS Mapa_Mundi;
USE Mapa_Mundi;

/*Creamos tabla continente*/

CREATE TABLE IF NOT EXISTS T_CONTINENTE(
Codigo INT(2) NOT NULL,
Nombre VARCHAR(15) NOT NULL,
PRIMARY KEY (Codigo)
);

/*Creamos tabala pais*/

CREATE TABLE IF NOT EXISTS T_PAIS(
Identificador INT(2) NOT NULL,
Nombre VARCHAR(15) NOT NULL,
Capital VARCHAR(20) NOT NULL,
Cod_Continente INT(2) NOT NULL,
PRIMARY KEY (Identificador),
CONSTRAINT FK_PAIS_CONTINENTE
FOREIGN KEY(Cod_Continente) REFERENCES T_CONTINENTE(Codigo)
);

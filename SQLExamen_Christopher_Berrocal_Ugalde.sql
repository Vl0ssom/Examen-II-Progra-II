CREATE DATABASE Veterinaria

USE Veterinaria

CREATE TABLE Mae_Usuarios
(
  Login_Usuario VARCHAR(50) PRIMARY KEY,
  Clave_Usuario VARCHAR(50) NOT NULL,
  Nombre_Usuario VARCHAR(50) NOT NULL,
)

CREATE TABLE Mae_Mascotas (
  ID_Mascota INT IDENTITY(1,1) PRIMARY KEY,
  Nombre_Mascota VARCHAR(50) UNIQUE,
  Tipo_Mascota VARCHAR(50),
  Comida_Favorita VARCHAR(50)
)

CREATE TABLE Control_Citas (
  ID_Cita INT PRIMARY KEY IDENTITY(1,1),
  ID_Mascota INT FOREIGN KEY REFERENCES Mae_Mascotas(ID_Mascota),
  Proxima_fecha DATE,
  Medico_Asignado VARCHAR(50)
)
CREATE TABLE USERS
(
  ID INT IDENTITY (1,1),
  Usuario varchar (100) ,
  Password varchar (100),
  CONSTRAINT FK_ID PRIMARY KEY (ID),
  CONSTRAINT UQ_EMAIL UNIQUE (Usuario)
)

GO
INSERT INTO USERS VALUES ('GoldenRetriever', 'Examen123')
GO
INSERT INTO Mae_Usuarios (Login_Usuario, Clave_Usuario, Nombre_Usuario)
VALUES ('Lmiguel', '120193', 'Luis Miguel'),
       ('Ccastro', '101214', 'Cristian Castro'),
       ('Jlopez', '151212', 'Jenifer Lopez')
	   
Go
INSERT INTO Mae_Mascotas (Nombre_Mascota, Tipo_Mascota, Comida_Favorita)
VALUES ('Piolin', 'Ave', 'Semillas'),
       ('Nemo', 'Acuaticos', 'Planton'),
       ('Beethoven', 'Perro', 'Super Perro'),
       ('Silvester', 'Felino', 'Felino'),
       ('Rene', 'Rana', 'Rana'),
       ('Dory', 'Acuatico', 'Acuatico')
Go
INSERT INTO Control_Citas (ID_Mascota, Proxima_fecha, Medico_Asignado)
VALUES (1, '2016-06-25', 'Dr. Ricardo Perez'),
       (2, '2016-07-01', 'Dra. Flora'),
       (3, '2016-06-24', 'Dra. Karla Moralez'),
       (4, '2016-06-17', 'Dr. Carlos Castro'),
       (5, '2016-07-30', 'Dra. Flora'),
       (6, '2016-06-23', 'Dra. Maria Jose Aguilar')

GO
CREATE PROCEDURE sp_OrdenCitas
AS
BEGIN
    SELECT m.Nombre_Mascota, Proxima_fecha, Medico_Asignado
    FROM Control_Citas
    INNER JOIN Mae_Mascotas m ON m.Nombre_Mascota = m.ID_Mascota
    WHERE Proxima_fecha >= GETDATE()
    ORDER BY Proxima_fecha ASC
END
GO
CREATE PROCEDURE SP_InsertMae_Usuarios
( 
@Login_Usuario VARCHAR(50), 
@Clave_Usuario VARCHAR(50),
@Nombre_Usuario VARCHAR(50)
)
AS BEGIN 

	IF NOT EXISTS (SELECT * FROM Mae_Usuarios where LTRIM(RTRIM(UPPER(@Login_Usuario))) = LTRIM(RTRIM(UPPER(@Login_Usuario)))) 
	BEGIN 
		INSERT INTO Mae_Usuarios(Login_Usuario,Clave_Usuario, Nombre_Usuario) 
		VALUES(UPPER(@Login_Usuario), UPPER(@Clave_Usuario), UPPER(@Nombre_Usuario)) 

		SELECT 'Usuario registrado.' as Result
	END 
	ELSE BEGIN 
		SELECT 'El usuario ya existe registrado.' as Result 
	END 
END 
go 

CREATE PROCEDURE SP_ListMae_Usuarios(
@Login_Usuario int)
AS BEGIN 
	IF (@Login_Usuario = 0 ) begin
		SELECT * FROM Mae_Usuarios
	end 
	else begin 
		SELECT * FROM Mae_Usuarios where @Login_Usuario = @Login_Usuario
	end 
	
END 
GO
CREATE PROCEDURE SP_UpdateMae_Usuarios
( 
@Login_Usuario VARCHAR(50), 
@Clave_Usuario VARCHAR(50),
@Nombre_Usuario VARCHAR(50)
) 
AS BEGIN 

	IF EXISTS (SELECT * FROM Mae_Usuarios where @Login_Usuario = @Login_Usuario) 
	BEGIN 
		UPDATE Mae_Usuarios 
		SET 
		  Clave_Usuario = @Clave_Usuario
		 ,Nombre_Usuario = @Nombre_Usuario
		WHERE Login_Usuario = @Login_Usuario
		

		SELECT 'Cuenta editada.' as Result
	END 
	
END 
GO 
CREATE PROCEDURE DeleteMae_Usuarios
  @Login_Usuario VARCHAR(50)
AS
BEGIN
  DELETE FROM Mae_Usuarios WHERE Login_Usuario = @Login_Usuario
END
GO
CREATE PROCEDURE SesionLogin
  @Usuario varchar(100) = '',
  @Password varchar(100) = ''
AS
BEGIN
  SELECT Usuario, Password
  FROM USERS
  WHERE Usuario = @Usuario AND Password = @Password
END
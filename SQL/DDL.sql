-- Bazar DB

create database Bazar;

-- Tables

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Bazar(
    id_bazar int,
    modalidad boolean,
    fecha_inicio date,
    fecha_final date,
    num_interior int,
    colonia varchar(50),
    estado varchar(50),
    num_exterior int,
    calle varchar(50)
);

-- Restricciones Bazar

-- Restricciones de dominio
ALTER TABLE Bazar ALTER COLUMN id_bazar SET NOT NULL;
ALTER TABLE Bazar ALTER COLUMN modalidad SET NOT NULL;
ALTER TABLE Bazar ALTER COLUMN fecha_inicio SET NOT NULL;
ALTER TABLE Bazar ALTER COLUMN fecha_final SET NOT NULL;
ALTER TABLE Bazar ADD CONSTRAINT chk_fechas_validas CHECK (fecha_inicio <= fecha_final);
ALTER TABLE Bazar ALTER COLUMN num_interior SET NOT NULL;
ALTER TABLE Bazar ADD CONSTRAINT num_interior_check CHECK (num_interior >= 0);
ALTER TABLE Bazar ALTER COLUMN colonia SET NOT NULL;
ALTER TABLE Bazar ALTER COLUMN estado SET NOT NULL;
ALTER TABLE Bazar ALTER COLUMN num_exterior SET NOT NULL;
ALTER TABLE Bazar ADD CONSTRAINT num_exterior_check CHECK (num_exterior >= 0);
ALTER TABLE Bazar ALTER COLUMN calle SET NOT NULL;

-- Restricciones de integridad de entidad
--PK Bazar
ALTER TABLE Bazar ADD CONSTRAINT pk_bazar PRIMARY KEY (id_bazar);

-- Comentarios
COMMENT ON TABLE Bazar IS 'Tabla que representa a bazares';

COMMENT ON COLUMN Bazar.id_bazar IS 'El ID del bazar';
COMMENT ON COLUMN Bazar.modalidad IS 'La modalidad del bazar';
COMMENT ON COLUMN Bazar.fecha_inicio IS 'La fecha de inicio';
COMMENT ON COLUMN Bazar.fecha_final IS 'La fecha de finalizacion';
COMMENT ON COLUMN Bazar.num_interior IS 'Numero interior de la ubicacion del bazar';
COMMENT ON COLUMN Bazar.colonia IS 'Colonia en la que se encuentra el bazar';
COMMENT ON COLUMN Bazar.estado IS 'Estado en el que se encuentra';
COMMENT ON COLUMN Bazar.num_exterior IS 'Numero exterior de la ubicacion del bazar';
COMMENT ON COLUMN Bazar.calle IS 'Calle de la ubicacion del bazar';

COMMENT ON CONSTRAINT pk_bazar ON Bazar IS 'Restriccion de entidad de la tabla Bazar';
COMMENT ON CONSTRAINT chk_fechas_validas ON Bazar IS 'Restriccion que verifica que la fecha de inicio sea menor o igual a la fecha de final del bazar';
COMMENT ON CONSTRAINT num_interior_check ON Bazar IS 'Restriccion que verifica que el numero interior sea igual o mayor a 0';
COMMENT ON CONSTRAINT num_exterior_check ON Bazar IS 'Restriccion que verifica que el numero exterior sea igual o mayor a 0';

---------------------------------------------------------------------------------------------------------------------------------------------------------


create table AmenidadBazar(
    id_bazar int,
    amenidad varchar(50)
);

-- Restricciones AmenidadBazar

-- Restricciones de dominio
ALTER TABLE AmenidadBazar ALTER COLUMN id_bazar SET NOT NULL;
ALTER TABLE AmenidadBazar ALTER COLUMN amenidad SET NOT NULL;

-- Restricciones de integridad de entidad
-- PK AmenidadBazar
ALTER TABLE AmenidadBazar ADD CONSTRAINT pk_amenidad PRIMARY KEY (id_bazar, amenidad);

-- Restricciones de integridad referencial
--FK AmenidadBazar
ALTER TABLE AmenidadBazar ADD CONSTRAINT fk_AmenidadBazar FOREIGN KEY (id_bazar) REFERENCES Bazar(id_bazar) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE AmenidadBazar IS 'Tabla de amenidades que se encontraran en el bazar';

COMMENT ON COLUMN AmenidadBazar.id_bazar IS 'ID del bazar al que pertenece las amenidades';
COMMENT ON COLUMN AmenidadBazar.amenidad IS 'Nombre de la amenidad asociada al bazar';

COMMENT ON CONSTRAINT pk_amenidad ON AmenidadBazar IS 'Clave primaria compuesta por el ID del bazar y el nombre de la amenidad';
COMMENT ON CONSTRAINT fk_AmenidadBazar ON AmenidadBazar IS 'FK que conecta con el ID del bazar y elimina en cascada';



---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Medico(
    rfc_medico varchar(13),
    calle varchar(50),
    num_interior int,
    num_exterior int,
    colonia varchar(50),
    estado varchar(50),
    nombre varchar(50),
    apellido_paterno varchar(50),
    apellido_materno varchar(50),
    salario money,
    hora_final time,
    hora_inicio time
);

-- Restricciones Medico
-- Restricciones de dominio
ALTER TABLE Medico ALTER COLUMN rfc_medico SET NOT NULL;
ALTER TABLE Medico ADD CONSTRAINT rfc_medico_check CHECK (CHAR_LENGTH(rfc_medico)=13 AND rfc_medico ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');
ALTER TABLE Medico ALTER COLUMN calle SET NOT NULL;
ALTER TABLE Medico ALTER COLUMN num_interior SET NOT NULL;
ALTER TABLE Medico ALTER COLUMN num_exterior SET NOT NULL;
ALTER TABLE Medico ADD CONSTRAINT num_interior_check CHECK (num_interior >= 0);
ALTER TABLE Medico ADD CONSTRAINT num_exterior_check CHECK (num_exterior >= 0);
ALTER TABLE Medico ALTER COLUMN colonia SET NOT NULL;
ALTER TABLE Medico ALTER COLUMN estado SET NOT NULL;
ALTER TABLE Medico ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Medico ALTER COLUMN apellido_materno SET NOT NULL;
ALTER TABLE Medico ALTER COLUMN apellido_paterno SET NOT NULL;
ALTER TABLE Medico ALTER COLUMN salario SET NOT NULL;
ALTER TABLE Medico ADD CONSTRAINT salario_check CHECK (salario > '0');
ALTER TABLE Medico ALTER COLUMN hora_final SET NOT NULL;
ALTER TABLE Medico ALTER COLUMN hora_inicio SET NOT NULL;

-- Restricciones de integridad de entidad
--PK Medico
ALTER TABLE Medico ADD CONSTRAINT pk_medico PRIMARY KEY (rfc_medico);

-- Comentarios
COMMENT ON TABLE Medico IS 'Tabla que almacena la informacion de los medicos';

COMMENT ON COLUMN Medico.rfc_medico IS 'RFC del medico. Actua como clave primaria';
COMMENT ON COLUMN Medico.calle IS 'Nombre de la calle del domicilio del medico';
COMMENT ON COLUMN Medico.num_interior IS 'Numero interior del domicilio del medico';
COMMENT ON COLUMN Medico.num_exterior IS 'Numero exterior del domicilio del medico';
COMMENT ON COLUMN Medico.colonia IS 'Colonia donde se encuentra el domicilio del medico';
COMMENT ON COLUMN Medico.estado IS 'Estado donde vive el medico';
COMMENT ON COLUMN Medico.nombre IS 'Nombre del medico';
COMMENT ON COLUMN Medico.apellido_paterno IS 'Apellido paterno del medico';
COMMENT ON COLUMN Medico.apellido_materno IS 'Apellido materno del medico';
COMMENT ON COLUMN Medico.salario IS 'Salario que recibe el medico';
COMMENT ON COLUMN Medico.hora_final IS 'Hora en la que finaliza su jornada laboral';
COMMENT ON COLUMN Medico.hora_inicio IS 'Hora en la que inicia su jornada laboral';

COMMENT ON CONSTRAINT pk_medico ON Medico IS 'Clave primaria basada en el RFC del medico';
COMMENT ON CONSTRAINT rfc_medico_check ON Medico IS 'Restriccion que verifica que el RFC del trabajador medico sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT num_interior_check ON Medico IS 'Restriccion que checa que el numero interior sea igual o mayor a 0';
COMMENT ON CONSTRAINT num_exterior_check ON Medico IS 'Restriccion que checa que el numero exterior sea igual o mayor a 0';
COMMENT ON CONSTRAINT salario_check ON Medico IS 'Restriccion que checa que el salario del trabajador medico sea mayor a 0';



---------------------------------------------------------------------------------------------------------------------------------------------------------

create table TelefonoMedico(
    rfc_medico varchar(13),
    telefono varchar(20)
);

-- Restricciones TelefonoMedico
-- Restricciones de dominio
ALTER TABLE TelefonoMedico ALTER COLUMN rfc_medico SET NOT NULL;
ALTER TABLE TelefonoMedico ALTER COLUMN telefono SET NOT NULL;
ALTER TABLE TelefonoMedico ADD CONSTRAINT rfc_medico_check CHECK (CHAR_LENGTH(rfc_medico)=13 AND rfc_medico ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');

-- Restricciones de integridad de entidad
-- PK TelefonoMedico
ALTER TABLE TelefonoMedico ADD CONSTRAINT pk_telefono_medico PRIMARY KEY (rfc_medico, telefono);

-- Restricciones de integridad referencial
--FK Medico con politicas de mantenimiento
ALTER TABLE TelefonoMedico ADD CONSTRAINT fk_medico FOREIGN KEY (rfc_medico) REFERENCES Medico(rfc_medico) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE TelefonoMedico IS 'Tabla que representa los telefonos de los medicos';

COMMENT ON COLUMN TelefonoMedico.rfc_medico IS 'RFC del medico';
COMMENT ON COLUMN TelefonoMedico.telefono IS 'Numero telefonico del medico';

COMMENT ON CONSTRAINT rfc_medico_check ON TelefonoMedico IS 'Restriccion que verifica que el RFC del trabajador de seguridad sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT pk_telefono_medico ON TelefonoMedico IS 'Llave primaria compuesta por RFC y telefono';
COMMENT ON CONSTRAINT fk_medico ON TelefonoMedico IS 
'Llave foranea hacia Medico. Si se elimina un medico, se eliminan tambien sus telefonos (ON DELETE CASCADE). 
Si se actualiza su RFC, tambien se actualiza. (ON UPDATE CASCADE).';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table CorreoMedico(
    rfc_medico varchar(13),
    correo varchar(100)
);

-- Restricciones CorreoMedico
-- Restricciones de dominio
ALTER TABLE CorreoMedico ALTER COLUMN rfc_medico SET NOT NULL;
ALTER TABLE CorreoMedico ALTER COLUMN correo SET NOT NULL;
ALTER TABLE CorreoMedico ADD CONSTRAINT rfc_medico_check CHECK (CHAR_LENGTH(rfc_medico)=13 AND rfc_medico ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');
ALTER TABLE CorreoMedico ADD CONSTRAINT correo_check CHECK (correo LIKE '%_@_%._%' );

-- Restricciones de integridad de entidad
--PK CorreoMedico
ALTER TABLE CorreoMedico ADD CONSTRAINT pk_correo_medico PRIMARY KEY (rfc_medico, correo);

-- Restricciones de integridad referencial
--FK Medico con politicas de mantenimiento
ALTER TABLE CorreoMedico ADD CONSTRAINT fk_rfc_medico FOREIGN KEY (rfc_medico) REFERENCES Medico(rfc_medico) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE CorreoMedico IS 'Tabla que representa los correos de los medicos';

COMMENT ON COLUMN CorreoMedico.rfc_medico IS 'RFC del medico';
COMMENT ON COLUMN CorreoMedico.correo IS 'Correo del medico';

COMMENT ON CONSTRAINT pk_correo_medico ON CorreoMedico IS 'Llave primaria compuesta de RFC y correo';
COMMENT ON CONSTRAINT fk_rfc_medico ON CorreoMedico IS 'Llave foranea hacia Medico. Si se elimina medico, se eliminan sus corrreos (ON DELETE) Si se actualiza su RFC, tambien se actualiza (ON UPDATE CASCADE)';
COMMENT ON CONSTRAINT rfc_medico_check ON CorreoMedico IS 'Restriccion que verifica que el RFC del trabajador de seguridad sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT correo_check ON CorreoMedico IS 'Restriccion que verifica que el correo del trabajador de seguridad tenga el formato correcto';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Seguridad(
    rfc_seguridad varchar(13),
    calle varchar(50),
    num_interior int,
    num_exterior int,
    colonia varchar(50),
    estado varchar(50),
    nombre varchar(50),
    apellido_paterno varchar(50),
    apellido_materno varchar(50),
    salario money,
    hora_final time,
    hora_inicio time
);


-- Restricciones Seguridad
-- Restricciones de dominio
ALTER TABLE Seguridad ALTER COLUMN rfc_seguridad SET NOT NULL;
ALTER TABLE Seguridad ADD CONSTRAINT rfc_seguridad_check CHECK (CHAR_LENGTH(rfc_seguridad)=13 AND rfc_seguridad ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');
ALTER TABLE Seguridad ALTER COLUMN calle SET NOT NULL;
ALTER TABLE Seguridad ALTER COLUMN num_interior SET NOT NULL;
ALTER TABLE Seguridad ALTER COLUMN num_exterior SET NOT NULL;
ALTER TABLE Seguridad ADD CONSTRAINT num_interior_check CHECK (num_interior >= 0);
ALTER TABLE Seguridad ADD CONSTRAINT num_exterior_check CHECK (num_exterior >= 0);
ALTER TABLE Seguridad ALTER COLUMN colonia SET NOT NULL;
ALTER TABLE Seguridad ALTER COLUMN estado SET NOT NULL;
ALTER TABLE Seguridad ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Seguridad ALTER COLUMN apellido_paterno SET NOT NULL;
ALTER TABLE Seguridad ALTER COLUMN apellido_materno SET NOT NULL;
ALTER TABLE Seguridad ALTER COLUMN salario SET NOT NULL;
ALTER TABLE Seguridad ADD CONSTRAINT salario_check CHECK (salario > '0');
ALTER TABLE Seguridad ALTER COLUMN hora_final SET NOT NULL;
ALTER TABLE Seguridad ALTER COLUMN hora_inicio SET NOT NULL;

-- Restricciones de integridad de entidad
--PK Seguridad
ALTER TABLE Seguridad ADD CONSTRAINT pk_seguridad PRIMARY KEY (rfc_seguridad);

-- Comentarios
COMMENT ON TABLE Seguridad IS 'Tabla que representa a un trabajador de seguridad';

COMMENT ON COLUMN Seguridad.rfc_seguridad IS 'El RFC del trabajador de seguridad';
COMMENT ON COLUMN Seguridad.calle IS 'La calle del trabajador de seguridad';
COMMENT ON COLUMN Seguridad.num_interior IS 'El numero interior del trabajador de seguridad';
COMMENT ON COLUMN Seguridad.num_exterior IS 'El numero exterior del trabajador de seguridad';
COMMENT ON COLUMN Seguridad.colonia IS 'La colonia del trabajador de seguridad';
COMMENT ON COLUMN Seguridad.estado IS 'El estado del trabajador de seguridad';
COMMENT ON COLUMN Seguridad.nombre IS 'El nombre del trabajador de seguridad';
COMMENT ON COLUMN Seguridad.apellido_paterno IS 'El apellido paterno del trabajador de seguridad';
COMMENT ON COLUMN Seguridad.apellido_materno IS 'El apellido materno del trabajador de seguridad';
COMMENT ON COLUMN Seguridad.salario IS 'El salario del trabajador de seguridad';
COMMENT ON COLUMN Seguridad.hora_final IS 'La hora de salida del trabajador de seguridad';
COMMENT ON COLUMN Seguridad.hora_inicio IS 'La hora de entrada del trabajador de seguridad';

COMMENT ON CONSTRAINT rfc_seguridad_check ON Seguridad IS 'Restriccion que verifica que el RFC del trabajador de seguridad sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT num_interior_check ON Seguridad IS 'Restriccion que checa que el numero interior sea igual o mayor a 0';
COMMENT ON CONSTRAINT num_exterior_check ON Seguridad IS 'Restriccion que checa que el numero exterior sea igual o mayor a 0';
COMMENT ON CONSTRAINT salario_check ON Seguridad IS 'Restriccion que checa que el salario del trabajador de seguridad sea mayor a 0';
COMMENT ON CONSTRAINT pk_seguridad ON Seguridad IS 'Restriccion de entidad de la tabla Seguridad';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table TelefonoSeguridad(
    rfc_seguridad varchar(13),
    telefono varchar(20)
);

-- Restricciones TelefonoSeguridad
-- Restricciones de dominio
ALTER TABLE TelefonoSeguridad ALTER COLUMN rfc_seguridad SET NOT NULL;
ALTER TABLE TelefonoSeguridad ADD CONSTRAINT rfc_seguridad_check CHECK (CHAR_LENGTH(rfc_seguridad)=13 AND rfc_seguridad ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');
ALTER TABLE TelefonoSeguridad ALTER COLUMN telefono SET NOT NULL;

-- Restricciones de integridad de entidad
--PK TelefonoSeguridad
ALTER TABLE TelefonoSeguridad ADD CONSTRAINT pk_telefono_seguridad PRIMARY KEY (rfc_seguridad, telefono);

-- Restricciones de integridad referencial
--FK Seguridad con politicas de mantenimiento
ALTER TABLE TelefonoSeguridad ADD CONSTRAINT fk_seguridad FOREIGN KEY (rfc_seguridad) REFERENCES Seguridad(rfc_seguridad) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE TelefonoSeguridad IS 'Tabla que representa el telefono del trabajador de seguridad';

COMMENT ON COLUMN TelefonoSeguridad.rfc_seguridad IS 'El RFC del trabajador de seguridad';
COMMENT ON COLUMN TelefonoSeguridad.telefono IS 'El telefono del trabajador de seguridad';

COMMENT ON CONSTRAINT rfc_seguridad_check ON TelefonoSeguridad IS 'Restriccion que verifica que el RFC del trabajador de seguridad sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT pk_telefono_seguridad ON TelefonoSeguridad IS 'Restriccion de entidad de la tabla TelefonoSeguridad';
COMMENT ON CONSTRAINT fk_seguridad ON TelefonoSeguridad IS 
'Restriccion referencial que verifica que el RFC del trabajador de seguridad exista. Si se elimina Seguridad, se eliminan sus telefonos (ON DELETE) Y Si se actualiza su RFC, igual aqui';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table CorreoSeguridad(
    rfc_seguridad varchar(13),
    correo varchar(100)
);

-- Restricciones CorreoEmprendedor
-- Restricciones de dominio
ALTER TABLE CorreoSeguridad ALTER COLUMN rfc_seguridad SET NOT NULL;
ALTER TABLE CorreoSeguridad ALTER COLUMN correo SET NOT NULL;
ALTER TABLE CorreoSeguridad ADD CONSTRAINT rfc_seguridad_check CHECK (CHAR_LENGTH(rfc_seguridad)=13 AND rfc_seguridad ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');
ALTER TABLE CorreoSeguridad ADD CONSTRAINT correo_check CHECK (correo LIKE '%_@_%._%' );

-- Restricciones de integridad de entidad
--PK CorreoSeguridad
ALTER TABLE CorreoSeguridad ADD CONSTRAINT pk_correo_seguridad PRIMARY KEY (rfc_seguridad,correo);

-- Restricciones de integridad referencial
--FK Seguridad con politicas de mantenimiento
ALTER TABLE CorreoSeguridad ADD CONSTRAINT fk_seguridad FOREIGN KEY (rfc_seguridad) REFERENCES Seguridad(rfc_seguridad) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE CorreoSeguridad IS 'Tabla que representa el correo del trabajador de seguridad';

COMMENT ON COLUMN CorreoSeguridad.rfc_seguridad IS 'El RFC del trabajador de seguridad';
COMMENT ON COLUMN CorreoSeguridad.correo IS 'El correo del trabajador de seguridad';


COMMENT ON CONSTRAINT rfc_seguridad_check ON CorreoSeguridad IS 'Restriccion que verifica que el RFC del trabajador de seguridad sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT correo_check ON CorreoSeguridad IS 'Restriccion que verifica que el correo del trabajador de seguridad tenga el formato correcto';
COMMENT ON CONSTRAINT pk_correo_seguridad ON CorreoSeguridad IS 'Restriccion de entidad de la tabla CorreoSeguridad';
COMMENT ON CONSTRAINT fk_seguridad ON CorreoSeguridad IS 
'Restriccion referencial que verifica que el RFC del trabajador de seguridad exista. Si se elimina Seguridad, se eliminan sus correos (ON DELETE) Y Si se actualiza su RFC, igual aqui';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Limpieza(
    rfc_limpieza varchar(13),
    calle varchar(50),
    num_interior int,
    num_exterior int,
    colonia varchar(50),
    estado varchar(50),
    nombre varchar(50),
    apellido_paterno varchar(50),
    apellido_materno varchar(50),
    salario money,
    hora_final time,
    hora_inicio time
);

-- Restricciones Limpieza
-- Restricciones de dominio
ALTER TABLE Limpieza ALTER COLUMN rfc_limpieza SET NOT NULL;
ALTER TABLE Limpieza ADD CONSTRAINT rfc_limpieza_check CHECK (CHAR_LENGTH(rfc_limpieza)=13 AND rfc_limpieza ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');
ALTER TABLE Limpieza ALTER COLUMN calle SET NOT NULL;
ALTER TABLE Limpieza ALTER COLUMN num_interior SET NOT NULL;
ALTER TABLE Limpieza ALTER COLUMN num_exterior SET NOT NULL;
ALTER TABLE Limpieza ADD CONSTRAINT num_interior_check CHECK (num_interior >= 0);
ALTER TABLE Limpieza ADD CONSTRAINT num_exterior_check CHECK (num_exterior >= 0);
ALTER TABLE Limpieza ALTER COLUMN colonia SET NOT NULL;
ALTER TABLE Limpieza ALTER COLUMN estado SET NOT NULL;
ALTER TABLE Limpieza ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Limpieza ALTER COLUMN apellido_paterno SET NOT NULL;
ALTER TABLE Limpieza ALTER COLUMN apellido_materno SET NOT NULL;
ALTER TABLE Limpieza ALTER COLUMN salario SET NOT NULL;
ALTER TABLE Limpieza ADD CONSTRAINT salario_check CHECK (salario > '0');
ALTER TABLE Limpieza ALTER COLUMN hora_final SET NOT NULL;
ALTER TABLE Limpieza ALTER COLUMN hora_inicio SET NOT NULL;

-- Restricciones de integridad de entidad
--PK Limpeza
ALTER TABLE Limpieza ADD CONSTRAINT pk_limpieza PRIMARY KEY (rfc_limpieza);

-- Comentarios
COMMENT ON TABLE Limpieza IS 'Tabla que representa a un trabajador de limpieza';
COMMENT ON COLUMN Limpieza.rfc_limpieza IS 'El RFC del trabajador de limpieza';
COMMENT ON COLUMN Limpieza.calle IS 'La calle del trabajador de limpieza';
COMMENT ON COLUMN Limpieza.num_interior IS 'El numero interior del trabajador de limpieza';
COMMENT ON COLUMN Limpieza.num_exterior IS 'El numero exterior del trabajador de limpieza';
COMMENT ON COLUMN Limpieza.colonia IS 'La colonia del trabajador de limpieza';
COMMENT ON COLUMN Limpieza.estado IS 'El estado del trabajador de limpieza';
COMMENT ON COLUMN Limpieza.nombre IS 'El nombre del trabajador de limpieza';
COMMENT ON COLUMN Limpieza.apellido_paterno IS 'El apellido paterno del trabajador de limpieza';
COMMENT ON COLUMN Limpieza.apellido_materno IS 'El apellido materno del trabajador de limpieza';
COMMENT ON COLUMN Limpieza.salario IS 'El salario del trabajador de limpieza';
COMMENT ON COLUMN Limpieza.hora_final IS 'La hora de salida del trabajador de limpieza';
COMMENT ON COLUMN Limpieza.hora_inicio IS 'La hora de entrada del trabajador de limpieza';

COMMENT ON CONSTRAINT rfc_limpieza_check ON Limpieza IS 'Restriccion que verifica que el RFC del trabajador de limpieza sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT num_interior_check ON Limpieza IS 'Restriccion que checa que el numero interior sea igual o mayor a 0';
COMMENT ON CONSTRAINT num_exterior_check ON Limpieza IS 'Restriccion que checa que el numero exterior sea igual o mayor a 0';
COMMENT ON CONSTRAINT salario_check ON Limpieza IS 'Restriccion que checa que el salario del trabajador de limpieza sea mayor a 0';
COMMENT ON CONSTRAINT pk_limpieza ON Limpieza IS 'Restriccion de entidad de la tabla Limpieza';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table TelefonoLimpieza(
    rfc_limpieza varchar(13),
    telefono varchar(20)
);

-- Restricciones TelefonoLimpieza
-- Restricciones de dominio
ALTER TABLE TelefonoLimpieza ALTER COLUMN rfc_limpieza SET NOT NULL;
ALTER TABLE TelefonoLimpieza ADD CONSTRAINT rfc_limpieza_check CHECK (CHAR_LENGTH(rfc_limpieza)=13 AND rfc_limpieza ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');
ALTER TABLE TelefonoLimpieza ALTER COLUMN telefono SET NOT NULL;

-- Restricciones de integridad de entidad
-- PK TelefonoLimpieza
ALTER TABLE TelefonoLimpieza ADD CONSTRAINT pk_telefono_limpieza PRIMARY KEY (rfc_limpieza,telefono);

-- Restricciones de integridad referencial
--FK Limpeza con politicas de mantenimiento
ALTER TABLE TelefonoLimpieza ADD CONSTRAINT fk_limpieza FOREIGN KEY (rfc_limpieza) REFERENCES Limpieza(rfc_limpieza) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE TelefonoLimpieza IS 'Tabla que representa el telefono del trabajador de limpieza';

COMMENT ON COLUMN TelefonoLimpieza.rfc_limpieza IS 'El RFC del trabajador de limpieza';
COMMENT ON COLUMN TelefonoLimpieza.telefono IS 'El telefono del trabajador de limpieza';

COMMENT ON CONSTRAINT rfc_limpieza_check ON TelefonoLimpieza IS 'Restriccion que verifica que el RFC del trabajador de limpieza sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT pk_telefono_limpieza ON TelefonoLimpieza IS 'Restriccion de entidad de la tabla TelefonoLimpieza';
COMMENT ON CONSTRAINT fk_limpieza ON TelefonoLimpieza IS 
'Restriccion referencial que verifica que el RFC del trabajador de limpieza exista. Si se elimina Limpieza, se eliminan sus telefonos (ON DELETE) Y Si se actualiza su RFC, igual aqui';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table CorreoLimpieza(
    rfc_limpieza varchar(13),
    correo varchar(100)
);

-- Restricciones CorreoLimpieza
-- Restricciones de dominio
ALTER TABLE CorreoLimpieza ALTER COLUMN rfc_limpieza SET NOT NULL;
ALTER TABLE CorreoLimpieza ALTER COLUMN correo SET NOT NULL;
ALTER TABLE CorreoLimpieza ADD CONSTRAINT rfc_limpieza_check CHECK (CHAR_LENGTH(rfc_limpieza)=13 AND rfc_limpieza ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');
ALTER TABLE CorreoLimpieza ADD CONSTRAINT correo_check CHECK (correo LIKE '%_@_%._%' );

-- Restricciones de integridad de entidad
--PK CorreoLimpieza
ALTER TABLE CorreoLimpieza ADD CONSTRAINT pk_correo_limpieza PRIMARY KEY (rfc_limpieza,correo);

-- Restricciones de integridad referencial
--FK Limpieza con politicas de mantenimiento
ALTER TABLE CorreoLimpieza ADD CONSTRAINT fk_limpieza FOREIGN KEY (rfc_limpieza) REFERENCES Limpieza(rfc_limpieza) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE CorreoLimpieza IS 'Tabla que representa el correo del trabajador de limpieza';

COMMENT ON COLUMN CorreoLimpieza.rfc_limpieza IS 'El RFC del trabajador de limpieza';
COMMENT ON COLUMN CorreoLimpieza.correo IS 'El correo del trabajador de limpieza';

COMMENT ON CONSTRAINT rfc_limpieza_check ON CorreoLimpieza IS 'Restriccion que verifica que el RFC del trabajador de limpieza sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT correo_check ON CorreoLimpieza IS 'Restriccion que verifica que el correo del trabajador de limpieza tenga el formato correcto';
COMMENT ON CONSTRAINT pk_correo_limpieza ON CorreoLimpieza IS 'Restriccion de entidad de la tabla CorreoLimpieza';
COMMENT ON CONSTRAINT fk_limpieza ON CorreoLimpieza IS 
'Restriccion referencial que verifica que el RFC del trabajador de limpieza exista. Si se elimina Limpieza, se eliminan sus correos (ON DELETE) Y Si se actualiza su RFC, igual aqui';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Agenda(
    id_agenda int
);

-- Restricciones Agenda
-- Restricciones de dominio
ALTER TABLE Agenda ALTER COLUMN id_agenda SET NOT NULL; 

-- Restricciones de integridad de entidad
ALTER TABLE Agenda ADD CONSTRAINT pk_agenda PRIMARY KEY (id_agenda);

-- Comentarios
COMMENT ON TABLE Agenda IS 'La tabla de la agenda';

COMMENT ON COLUMN Agenda.id_agenda IS 'El ID de la agenda';

COMMENT ON CONSTRAINT pk_agenda ON Agenda IS 'Restriccion de entidad de la tabla Agenda';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Negocio(
    id_negocio int, 
    precio_maximo money,
    precio_minimo money,
    descripcion varchar(200),
    nombre_negocio varchar(50)
);

-- Restricciones Negocio
-- Restricciones de dominio
ALTER TABLE Negocio ALTER COLUMN id_negocio SET NOT NULL;
ALTER TABLE Negocio ALTER COLUMN precio_maximo SET NOT NULL;
ALTER TABLE Negocio ALTER COLUMN precio_minimo SET NOT NULL;
ALTER TABLE Negocio ADD CONSTRAINT precios_maximo_check CHECK (precio_maximo > '0');
ALTER TABLE Negocio ADD CONSTRAINT precios_minimo_check CHECK (precio_minimo > '0');
ALTER TABLE Negocio ADD CONSTRAINT chk_precios_negocio CHECK (precio_minimo <= precio_maximo);
ALTER TABLE Negocio ALTER COLUMN descripcion SET NOT NULL;
ALTER TABLE Negocio ALTER COLUMN nombre_negocio SET NOT NULL;

-- Restricciones de integridad de entidad
--PK Negocio 
ALTER TABLE Negocio ADD CONSTRAINT pk_Negocio PRIMARY KEY (id_negocio);

-- Comentarios
COMMENT ON TABLE Negocio IS 'La tabla de los negocios';

COMMENT ON COLUMN Negocio.id_negocio IS 'El ID del negocio';
COMMENT ON COLUMN Negocio.precio_maximo IS 'El precio maximo de un producto o servicio del negocio';
COMMENT ON COLUMN Negocio.precio_minimo IS 'El precio minimo de un producto o servicio del negocio';
COMMENT ON COLUMN Negocio.descripcion IS 'La descripcion del negocio';
COMMENT ON COLUMN Negocio.nombre_negocio IS 'El nombre del negocio';

COMMENT ON CONSTRAINT precios_maximo_check ON Negocio IS 'Restriccion que verifica que el precio maximo sea mayor a 0';
COMMENT ON CONSTRAINT precios_minimo_check ON Negocio IS 'Restriccion que verifica que el precio minimo sea mayor a 0';
COMMENT ON CONSTRAINT chk_precios_negocio ON Negocio IS 'Restriccion que verifica que el precio maximo sea mayor o igual al precio minimo';
COMMENT ON CONSTRAINT pk_Negocio ON Negocio IS 'Restriccion de entidad de la tabla Negocio';


---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Estand(
    num_estand int,
    id_negocio int,
    paquete_estand varchar(50),
    precio int,
    precio_total int
);

-- Restricciones Estand
-- Restricciones de dominio
ALTER TABLE Estand ALTER COLUMN num_estand SET NOT NULL;
ALTER TABLE Estand ALTER COLUMN id_negocio SET NOT NULL;
ALTER TABLE Estand ALTER COLUMN precio SET NOT NULL;
ALTER TABLE Estand ADD CONSTRAINT precio_check CHECK (precio > '0');
ALTER TABLE Estand ALTER COLUMN paquete_estand SET NOT NULL;
ALTER TABLE Estand ALTER COLUMN precio_total SET NOT NULL;

-- Restricciones de integridad de entidad
--PK Estand
ALTER TABLE Estand ADD CONSTRAINT pk_estand PRIMARY KEY (num_estand);

-- Restricciones de integridad referencial
--FK Estand con politicas de mantenimiento
ALTER TABLE Estand ADD CONSTRAINT fk_Estand FOREIGN KEY (id_negocio) REFERENCES Negocio(id_negocio) ON DELETE CASCADE;

-- Comentarios
COMMENT ON TABLE Estand IS 'Tabla que representa al estand';

COMMENT ON COLUMN Estand.num_estand IS 'El numero del estand';
COMMENT ON COLUMN Estand.id_negocio IS 'El ID del negocio';
COMMENT ON COLUMN Estand.precio IS 'El precio del estand';
COMMENT ON COLUMN Estand.paquete_estand IS 'El paquete del estand';
COMMENT ON COLUMN Estand.precio IS 'El precio total del estand dependiendo del tipo de estand';

COMMENT ON CONSTRAINT precio_check ON Estand IS 'Restriccion que verifica que el precio del estand sea mayor a 0';
COMMENT ON CONSTRAINT pk_estand ON Estand IS 'Restriccion de entidad de la tabla Estand';
COMMENT ON CONSTRAINT fk_Estand ON Estand IS 
'Restriccion referencial que verifica que el ID del negocio exista.Si el negocio se elimina, tambien se eliminan sus estands (ON DELETE CASCADE).';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table AmenidadEstand(
    num_estand int,
    amenidad varchar(50)
);

-- Restricciones AmenidadEstand
-- Restricciones de dominio
ALTER TABLE AmenidadEstand ALTER COLUMN num_estand SET NOT NULL;
ALTER TABLE AmenidadEstand ALTER COLUMN amenidad SET NOT NULL;

-- Restricciones de integridad de entidad
--PK AmenidadEstand
ALTER TABLE AmenidadEstand ADD CONSTRAINT pk_AmenidadEstand PRIMARY KEY (num_estand, amenidad);

-- Restricciones de integridad referencial
--FK AmenidadEstand con politicas de mantenimiento
ALTER TABLE AmenidadEstand ADD CONSTRAINT fk_AmenidadEstand FOREIGN KEY (num_estand) REFERENCES Estand(num_estand) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE AmenidadEstand IS 'Tabla que representa la amenidad del estand';

COMMENT ON COLUMN AmenidadEstand.num_estand IS 'El numero del estand';
COMMENT ON COLUMN AmenidadEstand.amenidad IS 'Las amenidades del estand';

COMMENT ON CONSTRAINT pk_AmenidadEstand ON AmenidadEstand IS 'Restriccion de entidad de la tabla AmenidadEstand';
COMMENT ON CONSTRAINT fk_AmenidadEstand ON AmenidadEstand IS 
'Restriccion referencial que verifica que el numero del estand exista. Si se elimina un estand, tambien se eliminan sus amenidades (ON DELETE CASCADE).';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table EnlaceNegocio(
    id_negocio int,
    enlace varchar(100)
);

-- Restricciones EnlaceNegocio
-- Restricciones de dominio
ALTER TABLE EnlaceNegocio ALTER COLUMN id_negocio SET NOT NULL;
ALTER TABLE EnlaceNegocio ALTER COLUMN enlace SET NOT NULL;

-- Restricciones de integridad de entidad
--PK EnlaceNegocio
ALTER TABLE EnlaceNegocio ADD CONSTRAINT pk_EnlaceNegocio PRIMARY KEY (id_negocio, enlace);

-- Restricciones de integridad referencial
--FK EnlaceNegocio con politicas de mantenimiento
ALTER TABLE EnlaceNegocio ADD CONSTRAINT fk_EnlaceNegocio FOREIGN KEY (id_negocio) REFERENCES Negocio(id_negocio) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE EnlaceNegocio IS 'Tabla que representa el enlace del negocio';

COMMENT ON COLUMN EnlaceNegocio.id_negocio IS 'El ID del negocio';
COMMENT ON COLUMN EnlaceNegocio.enlace IS 'El enlace del negocio';

COMMENT ON CONSTRAINT pk_EnlaceNegocio ON EnlaceNegocio IS 'Restriccion de entidad de la tabla EnlaceNegocio';
COMMENT ON CONSTRAINT fk_EnlaceNegocio ON EnlaceNegocio IS 'Restriccion referencial que verifica que el ID del negocio exista. Si se elimina el negocio, tambien se eliminan sus enlaces (ON DELETE CASCADE).';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table TelefonoNegocio(
    id_negocio int,
    telefono varchar(50)
);

-- Restricciones TelefonoNegocio
-- Restricciones de dominio
ALTER TABLE TelefonoNegocio ALTER COLUMN id_negocio SET NOT NULL;
ALTER TABLE TelefonoNegocio ALTER COLUMN telefono SET NOT NULL;

-- Restricciones de integridad de entidad
--PK TelefonoNegocio
ALTER TABLE TelefonoNegocio ADD CONSTRAINT pk_TelefonoNegocio PRIMARY KEY (id_negocio, telefono);

-- Restricciones de integridad referencial
--FK TelefonoNegocio con politicas de mantenimiento
ALTER TABLE TelefonoNegocio ADD CONSTRAINT fk_TelefonoNegocio FOREIGN KEY (id_negocio) REFERENCES Negocio(id_negocio) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE TelefonoNegocio IS 'Tabla que representa el telefono del negocio';

COMMENT ON COLUMN TelefonoNegocio.id_negocio IS 'El ID del negocio';
COMMENT ON COLUMN TelefonoNegocio.telefono IS 'El telefono del negocio';

COMMENT ON CONSTRAINT pk_TelefonoNegocio ON TelefonoNegocio IS 'Restriccion de entidad de la tabla TelefonoNegocio';
COMMENT ON CONSTRAINT fk_TelefonoNegocio ON TelefonoNegocio IS 
'Restriccion referencial que verifica que el ID del negocio exista. Si se elimina el negocio, tambien se eliminan sus telefonos (ON DELETE CASCADE).';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table CorreoNegocio(
    id_negocio int,
    correo varchar(100)
);

-- Restricciones CorreoNegocio
-- Restricciones de dominio
ALTER TABLE CorreoNegocio ALTER COLUMN id_negocio SET NOT NULL;
ALTER TABLE CorreoNegocio ALTER COLUMN correo SET NOT NULL;
ALTER TABLE CorreoNegocio ADD CONSTRAINT correo_check CHECK (correo LIKE '%_@_%._%' );

-- Restricciones de integridad de entidad
--PK CorreoNegocio
ALTER TABLE CorreoNegocio ADD CONSTRAINT pk_CorreoNegocio PRIMARY KEY (id_negocio, correo);

-- Restricciones de integridad referencial
--FK CorreoNegocio con politicas de mantenimiento
ALTER TABLE CorreoNegocio ADD CONSTRAINT fk_CorreoNegocio FOREIGN KEY (id_negocio) REFERENCES Negocio(id_negocio) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE CorreoNegocio IS 'Tabla que representa el correo del negocio';

COMMENT ON COLUMN CorreoNegocio.id_negocio IS 'El ID del negocio';
COMMENT ON COLUMN CorreoNegocio.correo IS 'El correo del negocio';

COMMENT ON CONSTRAINT correo_check ON CorreoNegocio IS 'Restriccion que verifica que el correo del negocio tenga el formato correcto';
COMMENT ON CONSTRAINT pk_CorreoNegocio ON CorreoNegocio IS 'Restriccion de entidad de la tabla CorreoNegocio';
COMMENT ON CONSTRAINT fk_CorreoNegocio ON CorreoNegocio IS 
'Restriccion referencial que verifica que el ID del negocio exista. Si se elimina negocio, se eliminan sus correos (ON DELETE CASCADE)';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Emprendedor(
    rfc_emprendedor varchar(13),
    id_negocio int,
    genero varchar(1),
    fecha_nacimiento date,
    nombre varchar(50),
    apellido_paterno varchar(50),
    apellido_materno varchar(50),
    calle varchar(50),
    num_interior int,
    num_exterior int,
    colonia varchar(50),
    estado varchar(50)
);

-- Restricciones Emprendedor
-- Restricciones de dominio
ALTER TABLE Emprendedor ALTER COLUMN rfc_emprendedor SET NOT NULL;
ALTER TABLE Emprendedor ADD CONSTRAINT rfc_emprendedor_check CHECK (CHAR_LENGTH(rfc_emprendedor)=13 AND rfc_emprendedor ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');
ALTER TABLE Emprendedor ALTER COLUMN id_negocio SET NOT NULL;
ALTER TABLE Emprendedor ALTER COLUMN genero SET NOT NULL;
ALTER TABLE Emprendedor ADD CONSTRAINT chk_genero_emprendedor CHECK (genero IN ('M', 'F', 'O'));
ALTER TABLE Emprendedor ALTER COLUMN fecha_nacimiento SET NOT NULL;
ALTER TABLE Emprendedor ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Emprendedor ALTER COLUMN apellido_paterno SET NOT NULL;
ALTER TABLE Emprendedor ALTER COLUMN apellido_materno SET NOT NULL;
ALTER TABLE Emprendedor ALTER COLUMN calle SET NOT NULL;
ALTER TABLE Emprendedor ALTER COLUMN num_interior SET NOT NULL;
ALTER TABLE Emprendedor ALTER COLUMN num_exterior SET NOT NULL;
ALTER TABLE Emprendedor ADD CONSTRAINT num_interior_check CHECK (num_interior >= 0);
ALTER TABLE Emprendedor ADD CONSTRAINT num_exterior_check CHECK (num_exterior >= 0);
ALTER TABLE Emprendedor ALTER COLUMN colonia SET NOT NULL;
ALTER TABLE Emprendedor ALTER COLUMN estado SET NOT NULL;

-- Restricciones de integridad de entidad
--PK Emprendedor
ALTER TABLE Emprendedor ADD CONSTRAINT pk_Emprendedor PRIMARY KEY (rfc_emprendedor);

-- Restricciones de integridad referencial
--FK Emprendedor
ALTER TABLE Emprendedor ADD CONSTRAINT fk_Emprendedor FOREIGN KEY (id_negocio) REFERENCES Negocio(id_negocio) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE Emprendedor IS 'Tabla que representa a un emprendedor';

COMMENT ON COLUMN Emprendedor.rfc_emprendedor IS 'El RFC del emprendedor';
COMMENT ON COLUMN Emprendedor.id_negocio IS 'El ID del negocio';
COMMENT ON COLUMN Emprendedor.genero IS 'El genero del emprendedor';
COMMENT ON COLUMN Emprendedor.fecha_nacimiento IS 'La fecha de nacimiento del emprendedor';
COMMENT ON COLUMN Emprendedor.nombre IS 'El nombre del emprendedor';
COMMENT ON COLUMN Emprendedor.apellido_paterno IS 'El apellido paterno del emprendedor';
COMMENT ON COLUMN Emprendedor.apellido_materno IS 'El apellido materno del emprendedor';
COMMENT ON COLUMN Emprendedor.calle IS 'La calle del emprendedor';
COMMENT ON COLUMN Emprendedor.num_interior IS 'El numero interior del domicilio del emprendedor';
COMMENT ON COLUMN Emprendedor.num_exterior IS 'El numero exterior del domicilio del emprendedor';
COMMENT ON COLUMN Emprendedor.colonia IS 'La colonia del emprendedor';
COMMENT ON COLUMN Emprendedor.estado IS 'El estado del emprendedor';

COMMENT ON CONSTRAINT rfc_emprendedor_check ON Emprendedor IS 'Restriccion que verifica que el RFC del emprendedor sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT chk_genero_emprendedor ON Emprendedor IS 'Restriccion que verifica que el genero del emprendedor sea una cadena de tamanio 1 y sea la leta O, M o F';
COMMENT ON CONSTRAINT num_interior_check ON Emprendedor IS 'Restriccion que checa que el numero interior sea igual o mayor a 0';
COMMENT ON CONSTRAINT num_exterior_check ON Emprendedor IS 'Restriccion que checa que el numero exterior sea igual o mayor a 0';
COMMENT ON CONSTRAINT pk_Emprendedor ON Emprendedor IS 'Restriccion de entidad de la tabla Emprendedor. Si se elimina un negocio, se eliminan los emprendedores relacionados';
COMMENT ON CONSTRAINT fk_Emprendedor ON Emprendedor IS 'Restriccion referencial que verifica que el ID del negocio exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table TelefonoEmprendedor(
    rfc_emprendedor varchar(13),
    telefono varchar(50)
);

-- Restricciones TelefonoEmprendedor
-- Restricciones de dominio
ALTER TABLE TelefonoEmprendedor ALTER COLUMN rfc_emprendedor SET NOT NULL;
ALTER TABLE TelefonoEmprendedor ALTER COLUMN telefono SET NOT NULL;
ALTER TABLE TelefonoEmprendedor ADD CONSTRAINT rfc_emprendedor_check CHECK (CHAR_LENGTH(rfc_emprendedor)=13 AND rfc_emprendedor ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');

-- Restricciones de integridad de entidad
--PK TelefonoEmprendedor
ALTER TABLE TelefonoEmprendedor ADD CONSTRAINT pk_TelefonoEmprendedor PRIMARY KEY (rfc_emprendedor, telefono);

-- Restricciones de integridad referencial
--FK TelefonoEmprendedor
ALTER TABLE TelefonoEmprendedor ADD CONSTRAINT fk_TelefonoEmprendedor_rfc_emprendedor FOREIGN KEY (rfc_emprendedor) REFERENCES Emprendedor(rfc_emprendedor) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE TelefonoEmprendedor IS 'Tabla que representa al telefono del emprendedor';

COMMENT ON COLUMN TelefonoEmprendedor.rfc_emprendedor IS 'El RFC del emprendedor';
COMMENT ON COLUMN TelefonoEmprendedor.telefono IS 'El telefono del emprendedor';

COMMENT ON CONSTRAINT rfc_emprendedor_check ON TelefonoEmprendedor IS 'Restriccion que verifica que el RFC del emprendedor sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT pk_TelefonoEmprendedor ON TelefonoEmprendedor IS 'Restriccion de entidad de la tabla TelefonoEmprendedor';
COMMENT ON CONSTRAINT fk_TelefonoEmprendedor_rfc_emprendedor ON TelefonoEmprendedor IS 'Restriccion referencial que verifica que el RFC del emprendedor exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table CorreoEmprendedor(
    rfc_emprendedor varchar(13),
    correo varchar(100)
);

-- Restricciones CorreoEmprendedor
-- Restricciones de dominio
ALTER TABLE CorreoEmprendedor ALTER COLUMN rfc_emprendedor SET NOT NULL;
ALTER TABLE CorreoEmprendedor ALTER COLUMN correo SET NOT NULL;
ALTER TABLE CorreoEmprendedor ADD CONSTRAINT rfc_emprendedor_check CHECK (CHAR_LENGTH(rfc_emprendedor)=13 AND rfc_emprendedor ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');
ALTER TABLE CorreoEmprendedor ADD CONSTRAINT correo_check CHECK (correo LIKE '%_@_%._%' );

-- Restricciones de integridad de entidad
--PK CorreoEmprendedor
ALTER TABLE CorreoEmprendedor ADD CONSTRAINT pk_CorreoEmprendedor PRIMARY KEY (rfc_emprendedor, correo);

-- Restricciones de integridad referencial
--FK CorreoEmprendedor
ALTER TABLE CorreoEmprendedor ADD CONSTRAINT fk_CorreoEmprendedor_rfc_emprendedor FOREIGN KEY (rfc_emprendedor) REFERENCES Emprendedor(rfc_emprendedor) ON DELETE CASCADE ON UPDATE CASCADE;


-- Comentarios
COMMENT ON TABLE CorreoEmprendedor IS 'Tabla que representa al correo del emprendedor';

COMMENT ON COLUMN CorreoEmprendedor.rfc_emprendedor IS 'El RFC del emprendedor';
COMMENT ON COLUMN CorreoEmprendedor.correo IS 'El correo del emprendedor';

COMMENT ON CONSTRAINT rfc_emprendedor_check ON CorreoEmprendedor IS 'Restriccion que verifica que el RFC del emprendedor sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT correo_check ON CorreoEmprendedor IS 'Restriccion que verifica que el correo del emprendedor tenga formato de correo';
COMMENT ON CONSTRAINT pk_CorreoEmprendedor ON CorreoEmprendedor IS 'Restriccion de entidad de la tabla CorreoEmprendedor';
COMMENT ON CONSTRAINT fk_CorreoEmprendedor_rfc_emprendedor ON CorreoEmprendedor IS 'Restriccion referencial que verifica que el RFC del emprendedor exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Servicio(
    id_servicio int,
    id_negocio int,
    nombre varchar(50),
    precio money,
    descripcion varchar(200),
    duracion int,
    tipo varchar(50)
);

-- Restricciones Servicio
-- Restricciones de dominio
ALTER TABLE Servicio ALTER COLUMN id_servicio SET NOT NULL;
ALTER TABLE Servicio ALTER COLUMN id_negocio SET NOT NULL;
ALTER TABLE Servicio ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Servicio ALTER COLUMN precio SET NOT NULL;
ALTER TABLE Servicio ADD CONSTRAINT precio_check CHECK (precio > '0');
ALTER TABLE Servicio ALTER COLUMN descripcion SET NOT NULL;
ALTER TABLE Servicio ALTER COLUMN duracion SET NOT NULL;
ALTER TABLE Servicio ADD CONSTRAINT chk_duracion_servicio CHECK (duracion > 0);
ALTER TABLE Servicio ALTER COLUMN tipo SET NOT NULL;

-- Restricciones de integridad de entidad
-- PK Servicio
ALTER TABLE Servicio ADD CONSTRAINT pk_Servicio PRIMARY KEY (id_servicio);

-- Restricciones de integridad referencial
-- FK Servicio
ALTER TABLE Servicio ADD CONSTRAINT fk_Servicio_id_negocio FOREIGN KEY (id_negocio) REFERENCES Negocio(id_negocio) ON DELETE CASCADE ON UPDATE CASCADE;


-- Comentarios
COMMENT ON TABLE Servicio IS 'Tabla que representa a los servicios ofrecidos';

COMMENT ON COLUMN Servicio.id_servicio IS 'El ID del servicio';
COMMENT ON COLUMN Servicio.id_negocio IS 'El ID del negocio';
COMMENT ON COLUMN Servicio.nombre IS 'El nombre del servicio';
COMMENT ON COLUMN Servicio.precio IS 'El precio del servicio';
COMMENT ON COLUMN Servicio.descripcion IS 'La descripcion del servicio';
COMMENT ON COLUMN Servicio.duracion IS 'La duracion del servicio';
COMMENT ON COLUMN Servicio.tipo IS 'El tipo del servicio';

COMMENT ON CONSTRAINT precio_check ON Servicio IS 'Restriccion que verifica que el precio sea mayor a 0';
COMMENT ON CONSTRAINT chk_duracion_servicio ON Servicio IS 'Restriccion que verifica que la duracion sea mayor a 0';
COMMENT ON CONSTRAINT pk_Servicio ON Servicio IS 'Restriccion de entidad de la tabla Servicio';
COMMENT ON CONSTRAINT fk_Servicio_id_negocio ON Servicio IS 'Restriccion referencial que verifica que el ID del negocio exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table ProductoNoPerecedero(
    id_mercancia int,
    id_negocio int,
    nombre varchar(50),
    precio money,
    descripcion varchar(200),
    cantidad int
);

-- Restricciones ProductoNoPerecedero
-- Restricciones de dominio
ALTER TABLE ProductoNoPerecedero ALTER COLUMN id_mercancia SET NOT NULL;
ALTER TABLE ProductoNoPerecedero ALTER COLUMN id_negocio SET NOT NULL;
ALTER TABLE ProductoNoPerecedero ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE ProductoNoPerecedero ALTER COLUMN precio SET NOT NULL;
ALTER TABLE ProductoNoPerecedero ADD CONSTRAINT precio_check CHECK (precio > '0');
ALTER TABLE ProductoNoPerecedero ALTER COLUMN descripcion SET NOT NULL;
ALTER TABLE ProductoNoPerecedero ALTER COLUMN cantidad SET NOT NULL;
ALTER TABLE ProductoNoPerecedero ADD CONSTRAINT cantidad_check CHECK (cantidad >= 0);

-- Restricciones de integridad de entidad
--PK ProductoNoPerecedero
ALTER TABLE ProductoNoPerecedero ADD CONSTRAINT pk_ProductoNoPerecedero PRIMARY KEY (id_mercancia);

-- Restricciones de integridad referencial
--FK ProductoNoPerecedero
ALTER TABLE ProductoNoPerecedero ADD CONSTRAINT fk_ProductoNoPerecedero_id_negocio FOREIGN KEY (id_negocio) REFERENCES Negocio(id_negocio) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE ProductoNoPerecedero IS 'Tabla que representa a los productos no perecederos';

COMMENT ON COLUMN ProductoNoPerecedero.id_mercancia IS 'El ID de la mercancia';
COMMENT ON COLUMN ProductoNoPerecedero.id_negocio IS 'El ID del negocio';
COMMENT ON COLUMN ProductoNoPerecedero.nombre IS 'El nombre del producto no perecedero';
COMMENT ON COLUMN ProductoNoPerecedero.precio IS 'El precio del producto no perecedero';
COMMENT ON COLUMN ProductoNoPerecedero.descripcion IS 'La descripcion del producto no perecedero';
COMMENT ON COLUMN ProductoNoPerecedero.cantidad IS 'La cantidad del producto no perecedero';

COMMENT ON CONSTRAINT precio_check ON ProductoNoPerecedero IS 'Restriccion que verifica que el precio sea mayor a 0';
COMMENT ON CONSTRAINT cantidad_check ON ProductoNoPerecedero IS 'Restriccion que verifica que la cantidad de producto sea mayor o igual a 0';
COMMENT ON CONSTRAINT pk_ProductoNoPerecedero ON ProductoNoPerecedero IS 'Restriccion de entidad de la tabla ProductoNoPerecedero';
COMMENT ON CONSTRAINT fk_ProductoNoPerecedero_id_negocio ON ProductoNoPerecedero IS 'Restriccion referencial que verifica que el ID del negocio exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table PresentacionProductoNoPerecedero(
    id_mercancia int,
    presentacion varchar(50)
);

-- Restricciones PresentacionProductoNoPerecedero
-- Restricciones de dominio
ALTER TABLE PresentacionProductoNoPerecedero ALTER COLUMN id_mercancia SET NOT NULL;
ALTER TABLE PresentacionProductoNoPerecedero ALTER COLUMN presentacion SET NOT NULL;

-- Restricciones de integridad de entidad
--PK PresentacionProductoNoPerecedero
ALTER TABLE PresentacionProductoNoPerecedero ADD CONSTRAINT pk_PresentacionProductoNoPerecedero PRIMARY KEY (id_mercancia, presentacion);

-- Restricciones de integridad referencial
--FK PresentacionProductoNoPerecedero
ALTER TABLE PresentacionProductoNoPerecedero ADD CONSTRAINT fk_ProductoNoPerecedero_id_mercancia FOREIGN KEY (id_mercancia) REFERENCES ProductoNoPerecedero(id_mercancia) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE PresentacionProductoNoPerecedero IS 'Tabla que representa a la presentacion del producto no perecedero';

COMMENT ON COLUMN PresentacionProductoNoPerecedero.id_mercancia IS 'El ID de la mercancia';
COMMENT ON COLUMN PresentacionProductoNoPerecedero.presentacion IS 'La presentacion del producto no perecedero';

COMMENT ON CONSTRAINT pk_PresentacionProductoNoPerecedero ON PresentacionProductoNoPerecedero IS 'Restriccion de entidad de la tabla PresentacionProductoNoPerecedero';
COMMENT ON CONSTRAINT fk_ProductoNoPerecedero_id_mercancia ON PresentacionProductoNoPerecedero IS 'Restriccion referencial que verifica que el ID de la mercancia exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table ProductoPerecedero(
    id_mercancia int,
    id_negocio int,
    nombre varchar(50),
    precio money,
    descripcion varchar(200),
    cantidad int,
    fecha_preparacion date,
    fecha_caducidad date
);

-- Restricciones ProductoPerecedero
-- Restricciones de dominio
ALTER TABLE ProductoPerecedero ALTER COLUMN id_mercancia SET NOT NULL;
ALTER TABLE ProductoPerecedero ALTER COLUMN id_negocio SET NOT NULL;
ALTER TABLE ProductoPerecedero ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE ProductoPerecedero ALTER COLUMN precio SET NOT NULL;
ALTER TABLE ProductoPerecedero ADD CONSTRAINT precio_check CHECK (precio > '0');
ALTER TABLE ProductoPerecedero ALTER COLUMN descripcion SET NOT NULL;
ALTER TABLE ProductoPerecedero ALTER COLUMN cantidad SET NOT NULL;
ALTER TABLE ProductoPerecedero ADD CONSTRAINT cantidad_check CHECK (cantidad >= 0);
ALTER TABLE ProductoPerecedero ALTER COLUMN fecha_preparacion SET NOT NULL;
ALTER TABLE ProductoPerecedero ALTER COLUMN fecha_caducidad SET NOT NULL;
ALTER TABLE ProductoPerecedero ADD CONSTRAINT fecha_check CHECK (fecha_preparacion <= fecha_caducidad);

-- Restricciones de integridad de entidad
--PK ProductoPerecedero
ALTER TABLE ProductoPerecedero ADD CONSTRAINT pk_ProductoPerecedero PRIMARY KEY (id_mercancia);

-- Restricciones de integridad referencial
--FK ProductoPerecedero
ALTER TABLE ProductoPerecedero ADD CONSTRAINT fk_ProductoPerecedero_id_negocio FOREIGN KEY (id_negocio) REFERENCES Negocio(id_negocio) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE ProductoPerecedero IS 'Tabla que representa a los productos perecederos';

COMMENT ON COLUMN ProductoPerecedero.id_mercancia IS 'El ID de la mercancia';
COMMENT ON COLUMN ProductoPerecedero.id_negocio IS 'El ID del negocio';
COMMENT ON COLUMN ProductoPerecedero.nombre IS 'El nombre del producto perecedero';
COMMENT ON COLUMN ProductoPerecedero.precio IS 'El precio del producto perecedero';
COMMENT ON COLUMN ProductoPerecedero.descripcion IS 'La descripcion del producto perecedero';
COMMENT ON COLUMN ProductoPerecedero.cantidad IS 'La cantidad del producto perecedero';
COMMENT ON COLUMN ProductoPerecedero.fecha_preparacion IS 'La fecha de preparacion del producto perecedero';
COMMENT ON COLUMN ProductoPerecedero.fecha_caducidad IS 'La fecha de caducidad del producto perecedero';

COMMENT ON CONSTRAINT precio_check ON ProductoPerecedero IS 'Restriccion que verifica que el precio sea mayor a 0';
COMMENT ON CONSTRAINT cantidad_check ON ProductoPerecedero IS 'Restriccion que verifica que la cantidad de producto sea mayor o igual a 0';
COMMENT ON CONSTRAINT fecha_check ON ProductoPerecedero IS 'Restriccion que verifica que la fecja de preparacion sea igual o mayor a la fecha de caducidad';
COMMENT ON CONSTRAINT pk_ProductoPerecedero ON ProductoPerecedero IS 'Restriccion de entidad de la tabla ProductoPerecedero';
COMMENT ON CONSTRAINT fk_ProductoPerecedero_id_negocio ON ProductoPerecedero IS 'Restriccion referencial que verifica que el ID del negocio exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table PresentacionProductoPerecedero(
    id_mercancia int NOT NULL,
    presentacion varchar(50) NOT NULL
);

-- Restricciones PresentacionProductoPerecedero
-- Restricciones de dominio
ALTER TABLE PresentacionProductoPerecedero ALTER COLUMN id_mercancia SET NOT NULL;
ALTER TABLE PresentacionProductoPerecedero ALTER COLUMN presentacion SET NOT NULL;

-- Restricciones de integridad de entidad
--PK PresentacionProductoPerecedero
ALTER TABLE PresentacionProductoPerecedero ADD CONSTRAINT pk_PresentacionProductoPerecedero PRIMARY KEY (id_mercancia, presentacion);

-- Restricciones de integridad referencial
--FK PresentacionProductoPerecedero
ALTER TABLE PresentacionProductoPerecedero ADD CONSTRAINT fk_ProductoPerecedero_id_mercancia FOREIGN KEY (id_mercancia) REFERENCES ProductoPerecedero(id_mercancia) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE PresentacionProductoPerecedero IS 'Tabla que representa a la presentacion del producto perecedero';

COMMENT ON COLUMN PresentacionProductoPerecedero.id_mercancia IS 'El ID de la mercancia';
COMMENT ON COLUMN PresentacionProductoPerecedero.presentacion IS 'La presentacion del producto perecedero';

COMMENT ON CONSTRAINT pk_PresentacionProductoPerecedero ON PresentacionProductoPerecedero IS 'Restriccion de entidad de la tabla PresentacionProductoPerecedero';
COMMENT ON CONSTRAINT fk_ProductoPerecedero_id_mercancia ON PresentacionProductoPerecedero IS 'Restriccion referencial que verifica que el ID de la mercancia exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Cliente(
    id_cliente int,
    nombre varchar(50),
    apellido_paterno varchar(50),
    apellido_materno varchar(50),
    estado varchar(50),
    colonia varchar(50),
    num_interior int,
    num_exterior int,
    calle varchar(50)
);

-- Restricciones Cliente
-- Restricciones de dominio
ALTER TABLE Cliente ALTER COLUMN id_cliente SET NOT NULL;
ALTER TABLE Cliente ALTER COLUMN nombre SET NOT NULL;
ALTER TABLE Cliente ALTER COLUMN apellido_paterno SET NOT NULL;
ALTER TABLE Cliente ALTER COLUMN apellido_materno SET NOT NULL;
ALTER TABLE Cliente ALTER COLUMN estado SET NOT NULL;
ALTER TABLE Cliente ALTER COLUMN colonia SET NOT NULL;
ALTER TABLE Cliente ALTER COLUMN num_interior SET NOT NULL;
ALTER TABLE Cliente ALTER COLUMN num_exterior SET NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT num_interior_check CHECK (num_interior >= 0);
ALTER TABLE Cliente ADD CONSTRAINT num_exterior_check CHECK (num_exterior >= 0);
ALTER TABLE Cliente ALTER COLUMN calle SET NOT NULL;

-- Restricciones de integridad de entidad
--PK Cliente
ALTER TABLE Cliente ADD CONSTRAINT pk_Cliente PRIMARY KEY (id_cliente);

-- Comentarios
COMMENT ON TABLE Cliente IS 'Tabla que representa al cliente';

COMMENT ON COLUMN Cliente.id_cliente IS 'El ID del cliente';
COMMENT ON COLUMN Cliente.nombre IS 'El nombre del cliente';
COMMENT ON COLUMN Cliente.apellido_paterno IS 'El apellido paterno del cliente';
COMMENT ON COLUMN Cliente.apellido_materno IS 'El apellido materno del cliente';
COMMENT ON COLUMN Cliente.estado IS 'El estado del cliente';
COMMENT ON COLUMN Cliente.colonia IS 'La colonia del cliente';
COMMENT ON COLUMN Cliente.num_interior IS 'El numero interior del domicilio del cliente';
COMMENT ON COLUMN Cliente.num_exterior IS 'El numero exterior del domicilio del cliente';
COMMENT ON COLUMN Cliente.calle IS 'La calle del cliente';

COMMENT ON CONSTRAINT num_interior_check ON Cliente IS 'Restriccion que checa que el numero interior sea igual o mayor a 0';
COMMENT ON CONSTRAINT num_exterior_check ON Cliente IS 'Restriccion que checa que el numero exterior sea igual o mayor a 0';
COMMENT ON CONSTRAINT pk_Cliente ON Cliente IS 'Restriccion de entidad de la tabla Cliente';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Tarjeta(
    id_pago int,
    num_tarjeta char(16),
    vencimiento date,
    cvv char(3)
);

-- Restricciones Tarjeta
-- Restricciones de dominio
ALTER TABLE Tarjeta ALTER COLUMN id_pago SET NOT NULL;
ALTER TABLE Tarjeta ALTER COLUMN num_tarjeta SET NOT NULL;
ALTER TABLE Tarjeta ADD CONSTRAINT num_tarjeta_check CHECK (CHAR_LENGTH(num_tarjeta)=16);
ALTER TABLE Tarjeta ALTER COLUMN vencimiento SET NOT NULL;
ALTER TABLE Tarjeta ALTER COLUMN cvv SET NOT NULL;
ALTER TABLE Tarjeta ADD CONSTRAINT cvv_check CHECK (CHAR_LENGTH(cvv)=3);

-- Restricciones de integridad de entidad
--PK Tarjeta
ALTER TABLE Tarjeta ADD CONSTRAINT pk_Tarjeta PRIMARY KEY (id_pago);

-- Comentarios
COMMENT ON TABLE Tarjeta IS 'Tabla que representa el pago con tarjeta';

COMMENT ON COLUMN Tarjeta.id_pago IS 'El ID del pago de la tarjeta';
COMMENT ON COLUMN Tarjeta.num_tarjeta IS 'El numero de la tarjeta';
COMMENT ON COLUMN Tarjeta.vencimiento IS 'El vencimiento de la tarjeta';
COMMENT ON COLUMN Tarjeta.cvv IS 'El cvv de la tarjeta';

COMMENT ON CONSTRAINT num_tarjeta_check ON Tarjeta IS 'Restriccion que checa que el numero de la tarjeta sea una cadena de tamanio 16';
COMMENT ON CONSTRAINT cvv_check ON Tarjeta IS 'Restriccion que checa que el cvv sea una cadena de tamanio 3';
COMMENT ON CONSTRAINT pk_Tarjeta ON Tarjeta IS 'Restriccion de entidad de la tabla Tarjeta';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Efectivo(
    id_pago int
);

-- Restricciones Efectivo
-- Restricciones de dominio
ALTER TABLE Efectivo ALTER COLUMN id_pago SET NOT NULL;

-- Restricciones de integridad de entidad
--PK Efectivo
ALTER TABLE Efectivo ADD CONSTRAINT pk_Efectivo PRIMARY KEY (id_pago);

-- Comentarios
COMMENT ON TABLE Efectivo IS 'Tabla que representa el pago en efectivo';

COMMENT ON COLUMN Efectivo.id_pago IS 'El ID del pago con efectivo';

COMMENT ON CONSTRAINT pk_Efectivo ON Efectivo IS 'Restriccion de entidad de la tabla Efectivo';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Ticket(
    id_ticket int,
    id_cliente int,
    rfc_emprendedor varchar(13),
    id_pago_tarjeta int,
    id_pago_efectivo int
);

-- Restricciones Ticket
-- Restricciones de dominio
ALTER TABLE Ticket ALTER COLUMN id_ticket SET NOT NULL;
ALTER TABLE Ticket ALTER COLUMN id_cliente SET NOT NULL;
ALTER TABLE Ticket ALTER COLUMN rfc_emprendedor SET NOT NULL;
ALTER TABLE Ticket ADD CONSTRAINT rfc_emprendedor_check CHECK (CHAR_LENGTH(rfc_emprendedor)=13 AND rfc_emprendedor ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');

-- Restricciones de integridad de entidad
--PK Ticket
ALTER TABLE Ticket ADD CONSTRAINT pk_Ticket PRIMARY KEY (id_ticket);
ALTER TABLE Ticket ADD CONSTRAINT chk_pago_valido CHECK (
    (id_pago_tarjeta IS NOT NULL AND id_pago_efectivo IS NULL) OR 
    (id_pago_tarjeta IS NULL AND id_pago_efectivo IS NOT NULL) OR
    (id_pago_tarjeta IS NOT NULL AND id_pago_efectivo IS NOT NULL));

-- Restricciones de integridad referencial
--FK Ticket
ALTER TABLE Ticket ADD CONSTRAINT fk_ticket_id_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE RESTRICT ON UPDATE NO ACTION;
ALTER TABLE Ticket ADD CONSTRAINT fk_Ticket_rfc_emprendedor FOREIGN KEY (rfc_emprendedor) REFERENCES Emprendedor(rfc_emprendedor) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE Ticket ADD CONSTRAINT fk_Ticket_id_pago_tarjeta FOREIGN KEY (id_pago_tarjeta) REFERENCES Tarjeta(id_pago) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE Ticket ADD CONSTRAINT fk_Ticket_id_pago_efectivo FOREIGN KEY (id_pago_efectivo) REFERENCES Efectivo(id_pago) ON DELETE RESTRICT ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE Ticket IS 'Tabla que representa a los tickets';

COMMENT ON COLUMN Ticket.id_ticket IS 'El ID del ticket';
COMMENT ON COLUMN Ticket.id_cliente IS 'El ID del cliente';
COMMENT ON COLUMN Ticket.rfc_emprendedor IS 'El RFC del emprendedor';
COMMENT ON COLUMN Ticket.id_pago_tarjeta IS 'EL ID de la tarjeta';
COMMENT ON COLUMN Ticket.id_pago_efectivo IS 'El ID del efectivo';

COMMENT ON CONSTRAINT rfc_emprendedor_check ON Ticket IS 'Restriccion que checa que el RFC del emprendedor sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT pk_Ticket ON Ticket IS 'Restriccion de entidad de la tabla Ticket';
COMMENT ON CONSTRAINT chk_pago_valido ON Ticket IS 'Restriccion que asegura que siempre se tenga un metodo de pago';
COMMENT ON CONSTRAINT fk_ticket_id_cliente ON Ticket IS 'Restriccion referencial que verifica que el cliente exista';
COMMENT ON CONSTRAINT fk_Ticket_rfc_emprendedor ON Ticket IS 'Restriccion referencial que verifica que el RFC del emprendedor exista';
COMMENT ON CONSTRAINT fk_Ticket_id_pago_tarjeta ON Ticket IS 'Restriccion referencial que verifica que el pago con la tarjeta exista';
COMMENT ON CONSTRAINT fk_Ticket_id_pago_efectivo ON Ticket IS 'Restriccion referencial que verifica que el pago con el efectivo exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table TrabajarMedico(
    id_bazar int,
    rfc_medico varchar(13)
);

--Restricciones TrabajarMedico
--Restricciones de dominio
ALTER TABLE TrabajarMedico ALTER COLUMN id_bazar SET NOT NULL;
ALTER TABLE TrabajarMedico ALTER COLUMN rfc_medico SET NOT NULL;
ALTER TABLE TrabajarMedico ADD CONSTRAINT rfc_medico_check CHECK (CHAR_LENGTH(rfc_medico)=13 AND rfc_medico ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');

-- Restricciones de integridad de entidad
 --PK TrabajarMedico
 ALTER TABLE TrabajarMedico ADD CONSTRAINT pk_TrabajarMedico PRIMARY KEY (id_bazar, rfc_medico);

 -- Restricciones de integridad referencial
 --FK TrabajarMedico
 ALTER TABLE TrabajarMedico ADD CONSTRAINT fk_TrabajarMedico_id_bazar FOREIGN KEY (id_bazar) REFERENCES Bazar(id_bazar) ON DELETE CASCADE ON UPDATE CASCADE;
 ALTER TABLE TrabajarMedico ADD CONSTRAINT fk_TrabajarMedico_rfc_medico FOREIGN KEY (rfc_medico) REFERENCES Medico(rfc_medico)ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE TrabajarMedico IS 'Tabla que representa la accion de los trabajores medicos al trabajar en un bazar';

COMMENT ON COLUMN TrabajarMedico.id_bazar IS 'El ID del bazar';
COMMENT ON COLUMN TrabajarMedico.rfc_medico IS 'El RFC del trabajador medico';

COMMENT ON CONSTRAINT rfc_medico_check ON TrabajarMedico IS 'Restriccion que checa que el RFC del trabajador medico sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT pk_TrabajarMedico ON TrabajarMedico IS 'Restriccion de entidad de la tabla TrabajarMedico';
COMMENT ON CONSTRAINT fk_TrabajarMedico_id_bazar ON TrabajarMedico IS 'Restriccion referencial que verifica que el bazar exista';
COMMENT ON CONSTRAINT fk_TrabajarMedico_rfc_medico ON TrabajarMedico IS 'Restriccion referencial que verifica que el RFC del trabajor medico exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table TrabajarSeguridad(
    id_bazar int,
    rfc_seguridad varchar(13)
);

--Restricciones TrabajarSeguridad
--Restricciones de dominio
ALTER TABLE TrabajarSeguridad ALTER COLUMN id_bazar SET NOT NULL;
ALTER TABLE TrabajarSeguridad ALTER COLUMN rfc_seguridad SET NOT NULL;
ALTER TABLE TrabajarSeguridad ADD CONSTRAINT rfc_seguridad_check CHECK (CHAR_LENGTH(rfc_seguridad)=13 AND rfc_seguridad ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');
-- Restricciones de integridad de entidad
--PK TrabajarSeguridad
 ALTER TABLE TrabajarSeguridad ADD CONSTRAINT pk_TrabajarSeguridad PRIMARY KEY (id_bazar, rfc_seguridad);

-- Restricciones de integridad referencial
--FK TrabajarSeguridad
  ALTER TABLE TrabajarSeguridad ADD CONSTRAINT fk_TrabajarSeguridad_id_bazar FOREIGN KEY (id_bazar) REFERENCES Bazar(id_bazar) ON DELETE CASCADE ON UPDATE CASCADE;
  ALTER TABLE TrabajarSeguridad ADD CONSTRAINT fk_TrabajarSeguridad_rfc_seguridad FOREIGN KEY (rfc_seguridad) REFERENCES Seguridad(rfc_seguridad) ON DELETE CASCADE ON UPDATE CASCADE;

-- Comentarios
COMMENT ON TABLE TrabajarSeguridad IS 'Tabla que representa la accion de los trabajores de seguridad al trabajar en un bazar';

COMMENT ON COLUMN TrabajarSeguridad.id_bazar IS 'El ID del bazar';
COMMENT ON COLUMN TrabajarSeguridad.rfc_seguridad IS 'El RFC del trabajador de seguridad';

COMMENT ON CONSTRAINT rfc_seguridad_check ON TrabajarSeguridad IS 'Restriccion que checa que el RFC del trabajador de seguridad sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT pk_TrabajarSeguridad ON TrabajarSeguridad IS 'Restriccion de entidad de la tabla TrabajarSeguridad';
COMMENT ON CONSTRAINT fk_TrabajarSeguridad_id_bazar ON TrabajarSeguridad IS 'Restriccion referencial que verifica que el bazar exista';
COMMENT ON CONSTRAINT fk_TrabajarSeguridad_rfc_seguridad ON TrabajarSeguridad IS 'Restriccion referencial que verifica que el RFC del trabajor de seguridad exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table TrabajarLimpieza(
    id_bazar int,
    rfc_limpieza varchar(13)
);

--Restricciones TrabajarLimpieza
--Restricciones de dominio
ALTER TABLE TrabajarLimpieza ALTER COLUMN id_bazar SET NOT NULL;
ALTER TABLE TrabajarLimpieza ALTER COLUMN rfc_limpieza SET NOT NULL;
ALTER TABLE TrabajarLimpieza ADD CONSTRAINT rfc_limpieza_check CHECK (CHAR_LENGTH(rfc_limpieza)=13 AND rfc_limpieza ~ '^[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$');

-- Restricciones de integridad de entidad
--PK TrabajarLimpieza
 ALTER TABLE TrabajarLimpieza ADD CONSTRAINT pk_TrabajarLimpieza PRIMARY KEY (id_bazar, rfc_limpieza);

-- Restricciones de integridad referencial
--FK TrabajarLimpieza
 ALTER TABLE TrabajarLimpieza ADD CONSTRAINT fk_TrabajarLimpieza_id_bazar FOREIGN KEY (id_bazar) REFERENCES Bazar(id_bazar) ON DELETE CASCADE ON UPDATE CASCADE;
 ALTER TABLE TrabajarLimpieza ADD CONSTRAINT fk_TrabajarLimpieza_rfc_limpieza FOREIGN KEY (rfc_limpieza) REFERENCES Limpieza(rfc_limpieza) ON DELETE CASCADE ON UPDATE CASCADE;

--Comentarios
COMMENT ON TABLE TrabajarLimpieza IS 'Tabla que representa la accion de los trabajores de limpieza al trabajar en un bazar';

COMMENT ON COLUMN TrabajarLimpieza.id_bazar IS 'El ID del bazar';
COMMENT ON COLUMN TrabajarLimpieza.rfc_limpieza IS 'El RFC del trabajador de limpieza';

COMMENT ON CONSTRAINT rfc_limpieza_check ON TrabajarLimpieza IS 'Restriccion que checa que el RFC del trabajador de limpieza sea una cadena de tamanio 13';
COMMENT ON CONSTRAINT pk_TrabajarLimpieza ON TrabajarLimpieza IS 'Restriccion de entidad de la tabla TrabajarLimpieza';
COMMENT ON CONSTRAINT fk_TrabajarLimpieza_id_bazar ON TrabajarLimpieza IS 'Restriccion referencial que verifica que el bazar exista';
COMMENT ON CONSTRAINT fk_TrabajarLimpieza_rfc_limpieza ON TrabajarLimpieza IS 'Restriccion referencial que verifica que el RFC del trabajor de limpieza exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Tener(
    id_bazar int,
    id_agenda int,
    modalidad boolean,
    fecha_inicio date,
    fecha_final date,
    num_interior int,
    colonia varchar(50),
    estado varchar(50),
    num_exterior int,
    calle varchar(50)
);

--Restricciones Tener
--Restricciones de dominio
ALTER TABLE Tener ALTER COLUMN id_bazar SET NOT NULL;
ALTER TABLE Tener ALTER COLUMN id_agenda SET NOT NULL;
ALTER TABLE Tener ALTER COLUMN modalidad SET NOT NULL;
ALTER TABLE Tener ALTER COLUMN fecha_inicio SET NOT NULL;
ALTER TABLE Tener ALTER COLUMN fecha_final SET NOT NULL;
ALTER TABLE Tener ALTER COLUMN num_interior SET NOT NULL;
ALTER TABLE Tener ADD CONSTRAINT num_interior_check CHECK (num_interior >= 0);
ALTER TABLE Tener ALTER COLUMN colonia SET NOT NULL;
ALTER TABLE Tener ALTER COLUMN estado SET NOT NULL;
ALTER TABLE Tener ALTER COLUMN num_exterior SET NOT NULL;
ALTER TABLE Tener ADD CONSTRAINT num_exterior_check CHECK (num_exterior >= 0);
ALTER TABLE Tener ALTER COLUMN calle SET NOT NULL;

-- Restricciones de integridad de entidad
--PK Tener
 ALTER TABLE Tener ADD CONSTRAINT pk_Tener PRIMARY KEY (id_bazar, id_agenda);

-- Restricciones de integridad referencial
--FK Tener
ALTER TABLE Tener ADD CONSTRAINT fk_Tener_id_bazar FOREIGN KEY (id_bazar) REFERENCES Bazar(id_bazar) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Tener ADD CONSTRAINT fk_Tener_id_agenda FOREIGN KEY (id_agenda) REFERENCES Agenda(id_agenda) ON DELETE CASCADE ON UPDATE CASCADE;

--Comentarios
COMMENT ON TABLE Tener IS 'Tabla que representa la accion de un bazar de tener una agenda';

COMMENT ON COLUMN Tener.id_bazar IS 'El ID del bazar';
COMMENT ON COLUMN Tener.id_agenda IS 'El ID de la agenda';
COMMENT ON COLUMN Tener.modalidad IS 'Si el bazar es presencial o en linea';
COMMENT ON COLUMN Tener.fecha_inicio IS 'La fecha en que inicia el bazar';
COMMENT ON COLUMN Tener.fecha_final IS 'La fecha en que termina el bazar';
COMMENT ON COLUMN Tener.num_interior IS 'El numero interior';
COMMENT ON COLUMN Tener.colonia IS 'El nombre de la colonia';
COMMENT ON COLUMN Tener.estado IS 'El nombre del estado';
COMMENT ON COLUMN Tener.num_exterior IS 'El numero exterior';
COMMENT ON COLUMN Tener.calle IS 'El nombre de la calle';

COMMENT ON CONSTRAINT num_interior_check ON Tener IS 'Restriccion que checa que el numero interior sea igual o mayor a 0';
COMMENT ON CONSTRAINT num_exterior_check ON Tener IS 'Restriccion que checa que el numero exterior sea igual o mayor a 0';
COMMENT ON CONSTRAINT pk_Tener ON Tener IS 'Restriccion de entidad de la tabla Tener';
COMMENT ON CONSTRAINT fk_Tener_id_bazar ON Tener IS 'Restriccion referencial que verifica que el bazar exista';
COMMENT ON CONSTRAINT fk_Tener_id_agenda ON Tener IS 'Restriccion referencial que verifica que la agenda exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Registrar(
    id_agenda int,
    num_estand int,
    fecha_asistencia date
);

--Restricciones Registrar
--Restricciones de dominio
ALTER TABLE Registrar ALTER COLUMN id_agenda SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN num_estand SET NOT NULL;
ALTER TABLE Registrar ALTER COLUMN fecha_asistencia SET NOT NULL;

-- Restricciones de integridad de entidad
--PK Registrar
ALTER TABLE Registrar ADD CONSTRAINT pk_Registrar PRIMARY KEY (id_agenda, num_estand);

-- Restricciones de integridad referencial
--FK Registrar
ALTER TABLE Registrar ADD CONSTRAINT fk_Registrar_id_agenda FOREIGN KEY (id_agenda) REFERENCES Agenda(id_agenda) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Registrar ADD CONSTRAINT fk_Registrar_num_estand FOREIGN KEY (num_estand) REFERENCES Estand(num_estand) ON DELETE CASCADE ON UPDATE CASCADE;

--Comentarios
COMMENT ON TABLE Registrar IS 'Tabla que representa la accion de registrar estands en una agenda';

COMMENT ON COLUMN Registrar.id_agenda IS 'El ID de la agenda';
COMMENT ON COLUMN Registrar.num_estand IS 'El ID del estand';
COMMENT ON COLUMN Registrar.fecha_asistencia IS 'La fecha en la que se registra en la agenda';

COMMENT ON CONSTRAINT pk_Registrar ON Registrar IS 'Restriccion de entidad de la tabla Registrar';
COMMENT ON CONSTRAINT fk_Registrar_id_agenda ON Registrar IS 'Restriccion referencial que verifica que la agenda exista';
COMMENT ON CONSTRAINT fk_Registrar_num_estand ON Registrar IS 'Restriccion referencial que verifica que el estand exista';


---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Participar(
    id_negocio int,
    id_bazar int
);

--Restricciones Participar
--Restricciones de dominio
ALTER TABLE Participar ALTER COLUMN id_negocio SET NOT NULL;
ALTER TABLE Participar ALTER COLUMN id_bazar SET NOT NULL;

-- Restricciones de integridad de entidad
--PK Participar 
ALTER TABLE Participar ADD CONSTRAINT pk_Participar PRIMARY KEY (id_negocio, id_bazar);

-- Restricciones de integridad referencial
--FK Participar
ALTER TABLE Participar ADD CONSTRAINT fk_Participar_id_negocio FOREIGN KEY (id_negocio) REFERENCES Negocio(id_negocio) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Participar ADD CONSTRAINT fk_Participar_id_bazar FOREIGN KEY (id_bazar) REFERENCES Bazar(id_bazar) ON DELETE CASCADE ON UPDATE CASCADE;

--Comentarios
COMMENT ON TABLE Participar IS 'Tabla que representa la accion de los negocios al participar a un bazar';

COMMENT ON COLUMN Participar.id_negocio IS 'El ID del negocio';
COMMENT ON COLUMN Participar.id_bazar IS 'El ID del bazar';

COMMENT ON CONSTRAINT pk_Participar ON Participar IS 'Restriccion de entidad de la tabla Participar';
COMMENT ON CONSTRAINT fk_Participar_id_negocio ON Participar IS 'Restriccion referencial que verifica que el negocio exista';
COMMENT ON CONSTRAINT fk_Participar_id_bazar ON Participar IS 'Restriccion referencial que verifica que el bazar exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table Ir(
    id_bazar int,
    id_cliente int
);

--Restricciones Ir
--Restricciones de dominio
ALTER TABLE Ir ALTER COLUMN id_bazar SET NOT NULL;
ALTER TABLE Ir ALTER COLUMN id_cliente SET NOT NULL;

-- Restricciones de integridad de entidad
--PK Ir
ALTER TABLE Ir ADD CONSTRAINT pk_Ir PRIMARY KEY (id_bazar, id_cliente);

-- Restricciones de integridad referencial
--FK Ir
ALTER TABLE Ir ADD CONSTRAINT fk_Ir_id_bazar FOREIGN KEY (id_bazar) REFERENCES Bazar(id_bazar) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Ir ADD CONSTRAINT fk_Ir_id_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE CASCADE ON UPDATE CASCADE;

--Comentarios
COMMENT ON TABLE Ir IS 'Tabla que representa la accion de los clientes al ir a un bazar';

COMMENT ON COLUMN Ir.id_bazar IS 'El ID del bazar';
COMMENT ON COLUMN Ir.id_cliente IS 'El ID del cliente';

COMMENT ON CONSTRAINT pk_Ir ON Ir IS 'Restriccion de entidad de la tabla Ir';
COMMENT ON CONSTRAINT fk_Ir_id_bazar ON Ir IS 'Restriccion referencial que verifica que el bazar exista';
COMMENT ON CONSTRAINT fk_Ir_id_cliente ON Ir IS 'Restriccion referencial que verifica que el cliente exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table TenerServicio(
    id_ticket int,
    id_servicio int
);

--Restricciones TenerServicio
--Restricciones de dominio
ALTER TABLE TenerServicio ALTER COLUMN id_ticket SET NOT NULL;
ALTER TABLE TenerServicio ALTER COLUMN id_servicio SET NOT NULL;

-- Restricciones de integridad de entidad
--PK TenerServicio
ALTER TABLE TenerServicio ADD CONSTRAINT pk_TenerServicio PRIMARY KEY (id_ticket, id_servicio);

-- Restricciones de integridad referencial
--FK TenerServicio
ALTER TABLE TenerServicio ADD CONSTRAINT fk_TenerServicio_id_ticket FOREIGN KEY (id_ticket) REFERENCES Ticket(id_ticket) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE TenerServicio ADD CONSTRAINT fk_TenerServicio_id_servicio FOREIGN KEY (id_servicio) REFERENCES Servicio(id_servicio) ON DELETE CASCADE ON UPDATE CASCADE;

--Comentarios
COMMENT ON TABLE TenerServicio IS 'Tabla que representa a la accion de un ticket de tener servicios';

COMMENT ON COLUMN TenerServicio.id_ticket IS 'El ID del ticket';
COMMENT ON COLUMN TenerServicio.id_servicio IS 'El ID del servicio';

COMMENT ON CONSTRAINT pk_TenerServicio ON TenerServicio IS 'Restriccion de entidad de la tabla TenerServicio';
COMMENT ON CONSTRAINT fk_TenerServicio_id_ticket ON TenerServicio IS 'Restriccion referencial que verifica que el ticket exista';
COMMENT ON CONSTRAINT fk_TenerServicio_id_servicio ON TenerServicio IS 'Restriccion referencial que verifica que el servicio exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table TenerProductoPerecedero(
    id_ticket int,
    id_mercancia int,
    cantidad int
);

--Restricciones TenerProductoNoPerecedero
--Restricciones de dominio
ALTER TABLE TenerProductoPerecedero ALTER COLUMN id_ticket SET NOT NULL;
ALTER TABLE TenerProductoPerecedero ALTER COLUMN id_mercancia SET NOT NULL;
ALTER TABLE TenerProductoPerecedero ALTER COLUMN cantidad SET NOT NULL;
ALTER TABLE TenerProductoPerecedero ADD CONSTRAINT cantidad_check CHECK (cantidad >= 0);


-- Restricciones de integridad de entidad
--PK TenerProductoPerecedero
ALTER TABLE TenerProductoPerecedero ADD CONSTRAINT pk_TenerProductoPerecedero PRIMARY KEY (id_ticket, id_mercancia);

-- Restricciones de integridad referencial
--FK TenerProductoPerecedero
ALTER TABLE TenerProductoPerecedero ADD CONSTRAINT fk_TenerProductoPerecedero_id_ticket FOREIGN KEY (id_ticket) REFERENCES Ticket(id_ticket) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE TenerProductoPerecedero ADD CONSTRAINT fk_TenerProductoPerecedero_id_mercancia FOREIGN KEY (id_mercancia) REFERENCES ProductoPerecedero(id_mercancia) ON DELETE CASCADE ON UPDATE CASCADE;

--Comentarios
COMMENT ON TABLE TenerProductoPerecedero IS 'Tabla que representa a a la accion de un ticket de tener productos perecederos';

COMMENT ON COLUMN TenerProductoPerecedero.id_ticket IS 'El ID del ticket';
COMMENT ON COLUMN TenerProductoPerecedero.id_mercancia IS 'El ID de la mercancia';
COMMENT ON COLUMN TenerProductoPerecedero.cantidad IS 'La cantidad de productos perecederos';

COMMENT ON CONSTRAINT cantidad_check ON TenerProductoPerecedero IS 'Restriccion que checa que la cantidad de productos perecedeores sea igual o mayor a 0';
COMMENT ON CONSTRAINT pk_TenerProductoPerecedero ON TenerProductoPerecedero IS 'Restriccion de entidad de la tabla TenerProductoPerecedero';
COMMENT ON CONSTRAINT fk_TenerProductoPerecedero_id_ticket ON TenerProductoPerecedero IS 'Restriccion referencial que verifica que el ticket exista';
COMMENT ON CONSTRAINT fk_TenerProductoPerecedero_id_mercancia ON TenerProductoPerecedero IS 'Restriccion referencial que verifica que la mercancia exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------

create table TenerProductoNoPerecedero(
    id_ticket int,
    id_mercancia int,
    cantidad int
);

-- Restricciones TenerProductoNoPerecedero
-- Restricciones de dominio
ALTER TABLE TenerProductoNoPerecedero ALTER COLUMN id_ticket SET NOT NULL;
ALTER TABLE TenerProductoNoPerecedero ALTER COLUMN id_mercancia SET NOT NULL;
ALTER TABLE TenerProductoNoPerecedero ALTER COLUMN cantidad SET NOT NULL;
ALTER TABLE TenerProductoNoPerecedero ADD CONSTRAINT cantidad_check CHECK (cantidad >= 0);

-- Restricciones de integridad de entidad
--PK TenerProductoNoPerecedero
ALTER TABLE TenerProductoNoPerecedero ADD CONSTRAINT pk_TenerProductoNoPerecedero PRIMARY KEY (id_ticket, id_mercancia);

-- Restricciones de integridad referencial
--FK TenerProductoNoPerecedero
ALTER TABLE TenerProductoNoPerecedero ADD CONSTRAINT fk_TenerProductoNoPerecedero_id_ticket FOREIGN KEY (id_ticket) REFERENCES Ticket(id_ticket) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE TenerProductoNoPerecedero ADD CONSTRAINT fk_TenerProductoNoPerecedero_id_mercancia FOREIGN KEY (id_mercancia) REFERENCES ProductoNoPerecedero(id_mercancia) ON DELETE CASCADE ON UPDATE CASCADE;

--Comentarios
COMMENT ON TABLE TenerProductoNoPerecedero IS 'Tabla que representa a la accion de un ticket de tener productos no perecederos';

COMMENT ON COLUMN TenerProductoNoPerecedero.id_ticket IS 'El ID del ticket';
COMMENT ON COLUMN TenerProductoNoPerecedero.id_mercancia IS 'El ID de la mercancia';
COMMENT ON COLUMN TenerProductoNoPerecedero.cantidad IS 'La cantidad de productos no perecederos';

COMMENT ON CONSTRAINT cantidad_check ON TenerProductoNoPerecedero IS 'Restriccion que checa que la cantidad de productos no perecedeores sea igual o mayor a 0';
COMMENT ON CONSTRAINT pk_TenerProductoNoPerecedero ON TenerProductoNoPerecedero IS 'Restriccion de entidad de la tabla TenerProductoNoPerecedero';
COMMENT ON CONSTRAINT fk_TenerProductoNoPerecedero_id_ticket ON TenerProductoNoPerecedero IS 'Restriccion referencial que verifica que el ticket exista';
COMMENT ON CONSTRAINT fk_TenerProductoNoPerecedero_id_mercancia ON TenerProductoNoPerecedero IS 'Restriccion referencial que verifica que la mercancia exista';

---------------------------------------------------------------------------------------------------------------------------------------------------------
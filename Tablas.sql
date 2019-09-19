CREATE TABLE IF NOT EXISTS Empleado
(
    IdEmpleado     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    CodigoEmpleado TEXT    NOT NULL,
    Nombre         TEXT    NOT NULL,
    Apellido       TEXT    NOT NULL,
    CuentaBancaria TEXT    NOT NULL,
    HoraEntrada    TEXT    NOT NULL,
    HoraSalida     TEXT    NOT NULL,
    Cedula         TEXT    NOT NULL
);

CREATE TABLE IF NOT EXISTS Aeropuerto
(
    IdAeropuerto     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre           TEXT    NOT NULL,
    Localizacion     TEXT,
    Horario          TEXT DEFAULT '24/7',
    CodigoAeropuerto TEXT    NOT NULL UNIQUE,
    IdBodega         INTEGER,
    FOREIGN KEY (IdBodega) REFERENCES Bodega (IdBodega)
);




CREATE TABLE IF NOT EXISTS Aerolinea
(
    IdAerolinea       INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    CodigoAerolinea   TEXT    NOT NULL UNIQUE,
    Nombre            TEXT    NOT NULL,
    CantidadEmpleados INTEGER DEFAULT 0
);

INSERT INTO Aerolinea (IdAerolinea, Nombre, CodigoAerolinea)
VALUES (1, 'Roodel', '368-60-6303'),
       (2, 'Mybuzz', '349-88-9025'),
       (3, 'Yochio', '861-28-4772'),
       (4, 'Eazzy', '892-95-7695'),
       (5, 'Feedspan', '198-72-6971'),
       (6, 'Oyoyo', '263-30-0421'),
       (7, 'Browsedrive', '307-11-5101'),
       (8, 'Thoughtsphere', '713-42-4794'),
       (9, 'Yabox', '634-84-0364'),
       (10, 'Fanoodle', '230-23-8683'),
       (11, 'Realcube', '748-68-9144'),
       (12, 'Yozio', '661-50-8056');

--FALTA
CREATE TABLE IF NOT EXISTS AerolineaAeropuerto
(
    IdAerolinea  INTEGER NOT NULL,
    IdAeropuerto INTEGER NOT NULL,
    FOREIGN KEY (IdAerolinea) REFERENCES Aerolinea (IdAerolinea),
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto)
);

CREATE TABLE IF NOT EXISTS Vuelo
(
    IdVuelo      INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    NumeroVuelo  TEXT UNIQUE,
    Destino      TEXT    NOT NULL,
    Origen       TEXT    NOT NULL,
    FechaLLegada DATE    NOT NULL,
    HoraLlegada  TIME    NOT NULL,
    FechaSalida  DATE    NOT NULL,
    HoraSalida   TIME    NOT NULL,
    Precio       REAL    NOT NULL,
    Estado       TEXT    NOT NULL,
    PesoMaximo   TEXT    NOT NULL,
    IdAerolinea  INTEGER NOT NULL,
    IdAvion      INTEGER,
    FOREIGN KEY (IdAerolinea) REFERENCES Aerolinea (IdAerolinea),
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion)
);

CREATE TABLE IF NOT EXISTS Comunicacion
(
    IdComunicacion     INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
    NumeroVuelo        INTEGER  NOT NULL,
    IdEmpleado         INTEGER,
    CodigoComunicacion TEXT     NOT NULL UNIQUE,
    FechaHoraLlegada   DATETIME NOT NULL,
    Posicion           TEXT,
    IdAvion            INTEGER,
    FOREIGN KEY (NumeroVuelo) REFERENCES Vuelo (NumeroVuelo),
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion),
    FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado)
);

CREATE TABLE IF NOT EXISTS EmpleadoAeropuerto
(
    IdAeropuerto INTEGER NOT NULL,
    IdEmpleado   INTEGER NOT NULL UNIQUE,
    Puesto       TEXT    NOT NULL,
    Salario      REAL    NOT NULL,
    FechaIngreso DATE,
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto),
    FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado)
);

CREATE TABLE IF NOT EXISTS EmpleadoAerolinea
(
    IdAerolinea  INTEGER NOT NULL,
    IdEmpleado   INTEGER NOT NULL UNIQUE,
    Puesto       TEXT    NOT NULL,
    Salario      REAL    NOT NULL,
    FechaIngreso DATE,
    FOREIGN KEY (IdAerolinea) REFERENCES Aerolinea (IdAerolinea),
    FOREIGN KEY (IdEmpleado) REFERENCES Empleado (IdEmpleado)
);

CREATE TABLE IF NOT EXISTS Bodega
(
    IdBodega     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdAeropuerto INTEGER NOT NULL,
    IdTaller     INTEGER NOT NULL,
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto),
    FOREIGN KEY (IdTaller) REFERENCES Taller (IdTaller)
);

CREATE TABLE IF NOT EXISTS AvionAeropuerto
(
    IdAvion          INTEGER  NOT NULL UNIQUE,
    IdAeropuerto     INTEGER  NOT NULL,
    FechaHoraLlegada DATETIME NOT NULL,
    FechaHoraSalida  DATETIME NOT NULL,
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion),
    FOREIGN KEY (IdAeropuerto) REFERENCES Aeropuerto (IdAeropuerto)
);

CREATE TABLE IF NOT EXISTS Avion
(
    IdAvion              INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    CodigoAvion          TEXT    NOT NULL UNIQUE,
    Modelo               TEXT    NOT NULL,
    CapacidadTripulacion INTEGER NOT NULL,
    CapacidadItinerario  INTEGER NOT NULL,
    IdAerolinea          INTEGER NOT NULL,
    IdFabricante         INTEGER NOT NULL,
    Posicion             TEXT    NOT NULL,
    Estado               TEXT    NOT NULL,
    FOREIGN KEY (IdAerolinea) REFERENCES Aerolinea (IdAerolinea),
    FOREIGN KEY (IdFabricante) REFERENCES Fabricante (IdFabricante)
);

CREATE TABLE IF NOT EXISTS Fabricante
(
    IdFabricante    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Nombre          TEXT    NOT NULL,
    CantidadModelos INTEGER NOT NULL,
    Telefono        TEXT
);

CREATE TABLE IF NOT EXISTS AvionBodega
(
    IdAvion          INTEGER  NOT NULL UNIQUE,
    IdBodega         INTEGER  NOT NULL,
    FechaHoraLlegada DATETIME NOT NULL,
    FechaHoraSalida  DATETIME NOT NULL,
    FOREIGN KEY (IdBodega) REFERENCES Bodega (IdBodega),
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion)
);

CREATE TABLE IF NOT EXISTS Taller
(
    IdTaller INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    IdBodega INTEGER NOT NULL,
    FOREIGN KEY (IdBodega) REFERENCES Bodega (IdBodega)
);

CREATE TABLE IF NOT EXISTS AvionTaller
(
    IdTaller         INTEGER  NOT NULL,
    IdAvion          INTEGER  NOT NULL,
    FechaHoraLlegada DATETIME NOT NULL,
    FechaHoraSalida  DATETIME NOT NULL,
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion),
    FOREIGN KEY (IdTaller) REFERENCES Taller (IdTaller)
);

CREATE TABLE IF NOT EXISTS Factura
(
    IdFactura        INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
    Repuesto         TEXT     NOT NULL,
    FechaHoraLlegada DATETIME NOT NULL,
    FechaHoraSalida  DATETIME NOT NULL,
    DescripcionDanos TEXT     NOT NULL,
    IdTaller         INTEGER  NOT NULL NOT NULL,
    IdAvion          INTEGER  NOT NULL NOT NULL,
    Costo            REAL     NOT NULL,
    FOREIGN KEY (IdTaller) REFERENCES Taller (IdTaller),
    FOREIGN KEY (IdAvion) REFERENCES Avion (IdAvion)
);

CREATE TABLE IF NOT EXISTS Pasajero
(
    IdPasajero     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    CodigoPasajero INTEGER NOT NULL UNIQUE,
    Nombre         TEXT    NOT NULL,
    Apellido       TEXT    NOT NULL,
    Telefono       TEXT
);

CREATE TABLE IF NOT EXISTS Boleto
(
    IdBoleto      INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    NumeroAsiento INTEGER NOT NULL,
    IdVuelo       INTEGER NOT NULL,
    IdPasajero    INTEGER NOT NULL,
    FOREIGN KEY (IdPasajero) REFERENCES Pasajero (IdPasajero),
    FOREIGN KEY (IdVuelo) REFERENCES Vuelo (IdVuelo)
);

CREATE TABLE IF NOT EXISTS Equipaje
(
    IdEquipaje     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    CodigoPasajero TEXT    NOT NULL,
    IdPasajero     INTEGER NOT NULL,
    PesoEnKg       TEXT    NOT NULL,
    FOREIGN KEY (IdPasajero) REFERENCES Pasajero (IdPasajero)
);

CREATE TABLE IF NOT EXISTS Pasaporte
(
    IdPasaporte     INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    NumeroPasaporte TEXT    NOT NULL UNIQUE,
    Nacionalidad    TEXT    NOT NULL,
    IdPasajero      INTEGER NOT NULL,
    FOREIGN KEY (IdPasajero) REFERENCES Pasajero (IdPasajero)
);

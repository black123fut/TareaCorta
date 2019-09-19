--1: TOP 10 de aerolíneas con mayor cantidad de empleados.
SELECT Aerolinea.IdAerolinea,
       Aerolinea.CodigoAerolinea,
       Aerolinea.Nombre,
       COUNT(Aerolinea.IdAerolinea) AS CantidadEmpleados
FROM Aerolinea
         INNER JOIN EmpleadoAerolinea EA ON Aerolinea.IdAerolinea = EA.IdAerolinea
GROUP BY Aerolinea.IdAerolinea
ORDER BY CantidadEmpleados DESC
LIMIT 10;

--2: TOP 10 de aeropuertos con más Aerolíneas.
SELECT Aeropuerto.IdAeropuerto,
       Aeropuerto.Nombre,
       Aeropuerto.CodigoAeropuerto,
       COUNT(Aeropuerto.IdAeropuerto) AS CantidadAerolineas
FROM Aeropuerto
         INNER JOIN AvionAeropuerto AA ON Aeropuerto.IdAeropuerto = AA.IdAeropuerto
GROUP BY Aeropuerto.IdAeropuerto
ORDER BY CantidadAerolineas DESC
LIMIT 10;

--3: Toda la información de un empleado de la aerolínea y del aeropuerto con el sueldo más alto.
SELECT *
FROM Empleado
         INNER JOIN EmpleadoAerolinea EA ON Empleado.IdEmpleado = EA.IdEmpleado
         INNER JOIN(SELECT *
                    FROM Empleado
                             INNER JOIN
                         EmpleadoAeropuerto E ON Empleado.IdEmpleado = E.IdEmpleado
                    ORDER BY Salario DESC
                    LIMIT 1)
ORDER BY Salario DESC
LIMIT 1;

--4: Promedio de salario para los aeropuertos con mayor número de empleados.
SELECT AVG(EmpleadoAeropuerto.Salario) AS PromedioSalario, COUNT(EmpleadoAeropuerto.IdAeropuerto) AS CantidadEmpleados, A.Nombre,A.IdAeropuerto
FROM EmpleadoAeropuerto
         INNER JOIN Aeropuerto A ON EmpleadoAeropuerto.IdAeropuerto = A.IdAeropuerto
GROUP BY Nombre
ORDER BY CantidadEmpleados DESC;

--5: Cantidad de aviones en una aerolínea que están en estado de reparación.
SELECT COUNT(Avion.IdAerolinea) AS AvionesEnReparacion
FROM Avion
INNER JOIN Aerolinea AE ON Avion.IdAerolinea = AE.IdAerolinea
WHERE Estado = 'reparacion'
AND AE.Nombre = 'Mybuzz';
--Se cambia el id por el que se desea obtener

--6: Costo de reparación, modelo, fabricante y el código de un avión para una aerolínea perteneciente a un aeropuerto
-- específico.
SELECT Factura.Costo, A.Modelo, F.Nombre, A.CodigoAvion
FROM Factura
         INNER JOIN Avion A ON Factura.IdAvion = A.IdAvion
         INNER JOIN Fabricante F ON A.IdFabricante = F.IdFabricante
         INNER JOIN AerolineaAeropuerto AA ON A.IdAerolinea = AA.IdAerolinea
WHERE AA.IdAerolinea = 2;
--Se cambia el id por el que se desea obtener

--7: Cantidad de aviones activos en un aeropuerto.
SELECT COUNT(IdAeropuerto) AS CantidadAviones, IdAeropuerto
FROM AvionAeropuerto
         INNER JOIN Avion A ON AvionAeropuerto.IdAvion = A.IdAvion
WHERE IdAeropuerto = 4
  AND Estado = 'Activo'
GROUP BY IdAeropuerto;

-opcion 2
--7: Cantidad de aviones activos en un aeropuerto.
SELECT COUNT(AA.IdAeropuerto) AS CantidadAviones, AP.Nombre
FROM AvionAeropuerto AA
INNER JOIN Avion A ON AA.IdAvion = A.IdAvion
INNEr JOIN Aeropuerto AP ON AA.IdAeropuerto = AP.IdAeropuerto
WHERE AA.IdAeropuerto = 3 AND A.Estado = 'Activo'
GROUP BY AA.IdAeropuerto;

--8: Promedio de costo de reparación de los aviones para un aeropuerto específico.
--revisar
SELECT AA.NombreAerolinea, AVG(F.Costo)
FROM Factura F
         INNER JOIN (
    SELECT A2.Nombre AS NombreAerolinea, A.IdAvion
    FROM Avion A
             INNER JOIN Aerolinea A2 on A.IdAerolinea = A2.IdAerolinea
    WHERE A.Estado = 'En reparacion'
) AS AA ON F.IdAvion = AA.IdAvion
WHERE AA.NombreAerolinea = 'Caca';

--9: Cantidad de aviones inactivos dentro de una bodega.
--revisar
SELECT COUNT(AB.IdAvion) AS CantidadAvionEnBodega
FROM AvionBodega AB
         INNER JOIN Bodega B ON AB.IdBodega = B.IdBodega
         INNER JOIN Avion A ON AB.IdAvion = A.IdAvion
WHERE A.Estado = 'Inactivo'
  AND B.IdBodega = 2;
--Seleccionar bodega

--10: Nombre de los fabricantes con la mayor cantidad de modelos.
SELECT Nombre AS NombreFabricante, CantidadModelos
FROM Fabricante
ORDER BY CantidadModelos DESC;

--11: Cantidad de aerolíneas que contienen la letra “A” en el nombre. De este resultado además deben de mostrar cuáles
-- tienen más vuelos activos.
SELECT A.Nombre AS NombreAerolinea, COUNT(V.Estado) AS VuelosActivos
FROM Aerolinea A
         INNER JOIN Vuelo V ON A.IdAerolinea = V.IdAerolinea
WHERE A.Nombre LIKE '%a%'
  AND V.Estado = 'Activo'
GROUP BY A.Nombre;

--12: Intervalo de horas con la mayor llegada de aviones para un aeropuerto.
SELECT AP.Nombre                              AS NombreAeropuerto,
       AEV.NombreAerolinea,
       COUNT(strftime('%H', AEV.HoraLlegada)) AS CantidadLlegadas,
       strftime('%H', AEV.HoraLlegada)        AS HoraLlegada
FROM AerolineaAeropuerto AA
         INNER JOIN Aeropuerto AP ON AA.IdAeropuerto = AP.IdAeropuerto
         INNER JOIN (
    SELECT AL2.IdAerolinea, Nombre AS NombreAerolinea, V.HoraLlegada AS HoraLlegada, V.Destino AS Destino
    FROM Aerolinea AL2
             INNER JOIN Vuelo V ON AL2.IdAerolinea = V.IdAerolinea
    WHERE V.Estado = 'Activo'
) AS AEV ON AA.IdAerolinea = AEV.IdAerolinea
WHERE AP.Nombre = AEV.Destino
  AND AP.IdAeropuerto = 1 --Seleccionar Aeropuerto
GROUP BY strftime('%H', AEV.HoraLlegada)
ORDER BY CantidadLlegadas DESC;
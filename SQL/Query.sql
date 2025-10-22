-- 1. Listado completo de productos disponibles en el bazar (perecederos y no perecederos)
SELECT nombre, descripcion, precio, cantidad, 'Perecedero' AS tipo
FROM ProductoPerecedero
UNION
SELECT nombre, descripcion, precio, cantidad, 'No Perecedero' AS tipo
FROM ProductoNoPerecedero;

-- 2. Historial de ventas realizadas en un periodo especifico

SELECT T.id_ticket, T.id_cliente, T.rfc_emprendedor, T.id_pago_tarjeta, T.id_pago_efectivo
FROM Ticket T
JOIN TenerProductoPerecedero TP ON T.id_ticket = TP.id_ticket
JOIN ProductoPerecedero P ON TP.id_mercancia = P.id_mercancia
WHERE P.fecha_preparacion BETWEEN '2024-01-01' AND '2024-12-31';

-- 3. Reporte de ingresos por tipo de pago (es decir, tarjeta o efectivo)
SELECT 
    CASE 
        WHEN T.id_pago_tarjeta IS NOT NULL THEN 'Tarjeta'
        WHEN T.id_pago_efectivo IS NOT NULL THEN 'Efectivo'
        ELSE 'Otro'
    END AS tipo_pago,
    COUNT(*) AS cantidad_transacciones
FROM Ticket T
GROUP BY tipo_pago;

-- 4. Ventas realizadas por un emprendedor especifico
SELECT T.id_ticket, C.nombre, C.apellido_paterno, T.rfc_emprendedor
FROM Ticket T
JOIN Cliente C ON T.id_cliente = C.id_cliente
WHERE T.rfc_emprendedor = 'RGVJ228467U22';

-- 5. Productos con baja rotacion (ventas menores a 5 unidades)
SELECT P.id_mercancia, P.nombre, COALESCE(SUM(TNP.cantidad), 0) AS total_vendido
FROM ProductoNoPerecedero P
LEFT JOIN TenerProductoNoPerecedero TNP ON P.id_mercancia = TNP.id_mercancia
GROUP BY P.id_mercancia, P.nombre
HAVING SUM(TNP.cantidad) < 5;

-- 6. Informacion de contacto de los clientes
SELECT id_cliente, nombre, apellido_paterno, apellido_materno, calle, colonia, estado
FROM Cliente;

-- 7. Productos próximos a caducar (menos de 7 días)
SELECT nombre, fecha_caducidad
FROM ProductoPerecedero
WHERE fecha_caducidad <= CURRENT_DATE + INTERVAL '7 days';

-- 8. Servicios ofrecidos por cada negocio
SELECT N.nombre_negocio, S.nombre AS servicio, S.precio
FROM Negocio N
JOIN Servicio S ON N.id_negocio = S.id_negocio;


-- 9. Emprendedores mayores de 30 años

SELECT nombre, apellido_paterno, apellido_materno, fecha_nacimiento
FROM Emprendedor
WHERE fecha_nacimiento <= CURRENT_DATE - INTERVAL '30 years';

-- 10. 5 productos no perecederos más vendidos

SELECT P.nombre, SUM(TNP.cantidad) AS total_vendido
FROM ProductoNoPerecedero P
JOIN TenerProductoNoPerecedero TNP ON P.id_mercancia = TNP.id_mercancia
GROUP BY P.nombre
ORDER BY total_vendido DESC
LIMIT 5;

-- 11. Cantidad de trabajadores de cada tipo por bazar
SELECT B.id_bazar, --cambiar
       (SELECT COUNT(*) FROM TrabajarMedico WHERE id_bazar = B.id_bazar) AS medicos,
       (SELECT COUNT(*) FROM TrabajarSeguridad WHERE id_bazar = B.id_bazar) AS seguridad,
       (SELECT COUNT(*) FROM TrabajarLimpieza WHERE id_bazar = B.id_bazar) AS limpieza
FROM Bazar B;

-- 12. Promedio de precios de productos por negocio
SELECT id_negocio, AVG(precio::numeric::float8) AS precio_promedio
FROM (
    SELECT id_negocio, precio FROM ProductoPerecedero
    UNION ALL
    SELECT id_negocio, precio FROM ProductoNoPerecedero
) AS productos
GROUP BY id_negocio;

--13. Negocios que participan en más de 3 bazares

SELECT id_negocio, COUNT(id_bazar) AS total_bazares
FROM Participar
GROUP BY id_negocio
HAVING COUNT(id_bazar) >= 3;


-- 14. Clientes que han realizado más de 2 compras
SELECT id_cliente, COUNT(id_ticket) AS total_compras
FROM Ticket
GROUP BY id_cliente
HAVING COUNT(id_ticket) > 2;

-- 15. Resumen financiero del bazar por ingresos estimados
SELECT E.id_pago AS id_pago_tarjeta, 'Tarjeta' AS tipo_pago
FROM Tarjeta E
UNION
SELECT E.id_pago AS id_pago_efectivo, 'Efectivo' AS tipo_pago
FROM Efectivo E;

-- 16. Consultar todos los bazares registrados con sus fechas y ubicación
SELECT id_bazar, modalidad, fecha_inicio, fecha_final, colonia, estado, calle
FROM bazar;

-- 17. Mostrar médicos registrados con su RFC, horario y salario
SELECT rfc_medico, nombre, apellido_paterno, apellido_materno, salario, hora_inicio, hora_final
FROM medico;

-- 18. Consultar todos los negocios con sus precios y descripción
SELECT nombre_negocio, descripcion, precio_minimo, precio_maximo
FROM negocio;

-- 19. Consultar productos no perecederos con su cantidad y precio
SELECT nombre, descripcion, precio, cantidad
FROM productonoperecedero
ORDER BY precio DESC;

-- 20. Negocios con servicios registrados, junto con sus precios y duración
SELECT s.nombre AS nombre_servicio, s.descripcion, s.precio, s.duracion, s.tipo, n.nombre_negocio
FROM servicio s
JOIN negocio n ON s.id_negocio = n.id_negocio;

-- 21. Listar todos los correos de médicos, agrupados por RFC
SELECT rfc_medico, STRING_AGG(correo, ', ') AS correos
FROM correomedico
GROUP BY rfc_medico;

-- 22. Número de médicos por rango salarial
SELECT CASE
    WHEN salario < '10000' THEN 'Menos de 10k'
    WHEN salario BETWEEN '10000' AND '20000' THEN '10k - 20k'
    ELSE 'Más de 20k'
END AS rango_salarial,
COUNT(*) AS total_medicos
FROM medico
GROUP BY rango_salarial;

-- 23. Servicios cuyo precio sea mayor al promedio general
SELECT nombre, precio
FROM servicio
WHERE precio::numeric::float8 > (SELECT AVG(precio::numeric::float8) FROM servicio);

-- 24. Mostrar el número de amenidades por bazar
SELECT id_bazar, COUNT(*) AS total_amenidades
FROM amenidadbazar
GROUP BY id_bazar;

-- 25. Ver todos los paquetes de estand disponibles
SELECT DISTINCT paquete_estand
FROM estand;

-- 26. Relación de negocios con sus enlaces de contacto
SELECT n.nombre_negocio, e.enlace
FROM negocio n
JOIN enlacenegocio e ON n.id_negocio = e.id_negocio;

-- 27. Servicios por tipo y su duración promedio
SELECT tipo, AVG(duracion) AS duracion_promedio
FROM servicio
GROUP BY tipo;

-- 28. Bazar más largo en duración
SELECT id_bazar, fecha_inicio, fecha_final, (fecha_final - fecha_inicio) AS dias_duracion
FROM bazar
ORDER BY dias_duracion DESC
LIMIT 1;

-- 29. El genero de cada emprendedor
SELECT rfc_emprendedor, genero
FROM emprendedor;
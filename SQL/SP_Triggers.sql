-- Registra una nueva venta con tarjeta
--Objetivo: Inserta un ticket nuevo para un cliente y emprendedor dado, generando tambien el registro de pago con tarjeta.


CREATE OR REPLACE PROCEDURE registrar_venta_tarjeta(
    IN p_id_cliente INT,
    IN p_rfc_emprendedor VARCHAR(13),
    IN p_num_tarjeta CHAR(16),
    IN p_vencimiento DATE,
    IN p_cvv CHAR(3),
    OUT p_id_ticket INT
)
AS $$
DECLARE
    v_id_pago_tarjeta INT;
    v_id_pago_efectivo INT := 0; 
BEGIN
    -- Insertar el pago con tarjeta
    INSERT INTO Tarjeta (id_pago, num_tarjeta, vencimiento, cvv)
    VALUES (DEFAULT, p_num_tarjeta, p_vencimiento, p_cvv)
    RETURNING id_pago INTO v_id_pago_tarjeta;

    -- Insertar el pago ficticio en efectivo (por la fk)
    INSERT INTO Efectivo (id_pago)
    VALUES (DEFAULT)
    RETURNING id_pago INTO v_id_pago_efectivo;

    -- Insertar el ticket
    INSERT INTO Ticket (id_cliente, rfc_emprendedor, id_pago_tarjeta, id_pago_efectivo)
    VALUES (p_id_cliente, p_rfc_emprendedor, v_id_pago_tarjeta, v_id_pago_efectivo)
    RETURNING id_ticket INTO p_id_ticket;
END;
$$ LANGUAGE plpgsql;


-- Actualizar cantidad de un producto no perecedero
-- Objetivo: Permite modificar la cantidad de stock de un producto no perecedero.

CREATE OR REPLACE PROCEDURE actualizar_stock_producto_no_perecedero(
    IN p_id_mercancia INT,
    IN p_nueva_cantidad INT
)
AS $$
BEGIN
    UPDATE ProductoNoPerecedero
    SET cantidad = p_nueva_cantidad
    WHERE id_mercancia = p_id_mercancia;
END;
$$ LANGUAGE plpgsql;


-- Funcion que revisa la fhecha de caducidad de un producto perecedero, en este caso la fecha a comparar no es la actual debido a como poblamos nuertra base de datos

CREATE OR REPLACE FUNCTION revisar_caducidad()
RETURNS TRIGGER AS $$
DECLARE 
    fecha_comp DATE := '05/05/2024';
BEGIN
    IF NEW.fecha_caducidad < fecha_comp THEN
        RAISE EXCEPTION 'El producto que se quiere insertar caducó en %', NEW.fecha_caducidad;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger que lanza una excepcion si al insertar un producto perecedero ya esta caducado

CREATE TRIGGER revisar_caducidad
    BEFORE INSERT 
    ON productoperecedero
    FOR EACH ROW
    EXECUTE FUNCTION revisar_caducidad();

-- Funcion que actualiza el precio maximo o minimo

CREATE OR REPLACE FUNCTION actualiza_maximo_minimo()
RETURNS TRIGGER AS $$
DECLARE
    maximo_actual money;
    minimo_actual money;
    maximo_nuevo money;
    minimo_nuevo money;
BEGIN

    IF TG_OP = 'DELETE' THEN
		
	maximo_actual = (SELECT precio_maximo FROM negocio WHERE id_negocio = OLD.id_negocio);
    minimo_actual = (SELECT precio_minimo FROM negocio WHERE id_negocio = OLD.id_negocio);

        IF OLD.precio = maximo_actual THEN
            SELECT MAX(precio) INTO maximo_nuevo FROM (
                    SELECT precio FROM servicio WHERE id_negocio = OLD.id_negocio
                    UNION ALL
                    SELECT precio FROM productonoperecedero WHERE id_negocio = OLD.id_negocio
                    UNION ALL
                    SELECT precio FROM productoperecedero WHERE id_negocio = OLD.id_negocio
                );
            UPDATE negocio SET precio_maximo = maximo_nuevo WHERE id_negocio = OLD.id_negocio;
        END IF;

        IF OLD.precio = minimo_actual THEN
            SELECT MIN(precio) INTO minimo_nuevo FROM (
                    SELECT precio FROM servicio WHERE id_negocio = OLD.id_negocio
                    UNION ALL
                    SELECT precio FROM productonoperecedero WHERE id_negocio = OLD.id_negocio
                    UNION ALL
                    SELECT precio FROM productoperecedero WHERE id_negocio = OLD.id_negocio
                );
            UPDATE negocio SET precio_minimo = minimo_nuevo WHERE id_negocio = OLD.id_negocio;
        END IF;

        RETURN OLD;
    END IF;

	maximo_actual = (SELECT precio_maximo FROM negocio WHERE id_negocio = NEW.id_negocio);
    minimo_actual = (SELECT precio_minimo FROM negocio WHERE id_negocio = NEW.id_negocio);

    IF TG_OP = 'UPDATE' THEN

        IF NEW.precio = maximo_actual THEN
            SELECT MAX(precio) INTO maximo_nuevo FROM (
                    SELECT precio FROM servicio WHERE id_negocio = NEW.id_negocio
                    UNION ALL
                    SELECT precio FROM productonoperecedero WHERE id_negocio = NEW.id_negocio
                    UNION ALL
                    SELECT precio FROM productoperecedero WHERE id_negocio = NEW.id_negocio
                );
            UPDATE negocio SET precio_maximo = maximo_nuevo WHERE id_negocio = NEW.id_negocio;
        END IF;

        IF NEW.precio = minimo_actual THEN
            SELECT MIN(precio) INTO minimo_nuevo FROM (
                    SELECT precio FROM servicio WHERE id_negocio = NEW.id_negocio
                    UNION ALL
                    SELECT precio FROM productonoperecedero WHERE id_negocio = NEW.id_negocio
                    UNION ALL
                    SELECT precio FROM productoperecedero WHERE id_negocio = NEW.id_negocio
                );
            UPDATE negocio SET precio_maximo = minimo_nuevo WHERE id_negocio = NEW.id_negocio;
        END IF;

        RETURN NEW;
    END IF;


    IF TG_OP = 'INSERT'  THEN

        IF NEW.precio > maximo_actual THEN
            UPDATE negocio SET precio_maximo = NEW.precio WHERE id_negocio = NEW.id_negocio;
        END IF;

        IF NEW.precio < minimo_actual THEN
            UPDATE negocio SET precio_minimo = NEW.precio WHERE id_negocio = NEW.id_negocio;
        END IF;

        RETURN NEW;
    END IF;

    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


-- Triggers que actualizan el precio maximo o minimo de un negocio cuando se inserta un servicio, producto perecedero o producto no perecedero

CREATE TRIGGER actualiza_maximo_minimo_servicio
    AFTER INSERT OR UPDATE OF precio OR DELETE
    ON servicio
    FOR EACH ROW
    EXECUTE FUNCTION actualiza_maximo_minimo();

CREATE TRIGGER actualiza_maximo_minimo_productonoperecedero
    AFTER INSERT OR UPDATE OF precio OR DELETE
    ON productonoperecedero
    FOR EACH ROW
    EXECUTE FUNCTION actualiza_maximo_minimo();

CREATE TRIGGER actualiza_maximo_minimo_productoperecedero
    AFTER INSERT OR UPDATE OF precio OR DELETE
    ON productoperecedero
    FOR EACH ROW
    EXECUTE FUNCTION actualiza_maximo_minimo();


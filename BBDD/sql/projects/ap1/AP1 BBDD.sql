USE db_hotels;

-- ----------------------------------------------------------------------------
-- Exercici 1: Disponibilitat d'habitacions
-- ----------------------------------------------------------------------------
DROP FUNCTION IF EXISTS sp_Disponibilitat;

DELIMITER //
CREATE FUNCTION sp_Disponibilitat(pHotelId SMALLINT, pDataEntrada DATE, pDataSortida DATE) RETURNS BOOLEAN
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE varRetorn BOOLEAN;

    SELECT IF(COUNT(*) = 0, TRUE, FALSE) INTO varRetorn
    FROM reserves r
    INNER JOIN habitacions hab ON hab.hab_id = r.hab_id
    WHERE hab.hotel_id = pHotelId
        AND pDataEntrada <= r.data_fi
        AND pDataSortida >= r.data_inici;

    RETURN varRetorn;
END;
//
DELIMITER ;

-- Exemple d'ús de la funció
SELECT sp_Disponibilitat(69, '2015-12-01', '2016-01-12');

-- ----------------------------------------------------------------------------
-- Exercici 2: Omplir estadístiques de reserves
-- ----------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_OmplirEstadisticsReserves;

DELIMITER //
CREATE PROCEDURE sp_OmplirEstadisticsReserves()
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE tmp_any YEAR;
    DECLARE tmp_mes VARCHAR(30);
    DECLARE tmp_num_nits INT;
    DECLARE fi_cursor BOOLEAN DEFAULT FALSE;

    -- Cursor per obtenir les dades de reserves (limitat a 100 per l'exemple)
    DECLARE cReserves CURSOR FOR
        SELECT YEAR(data_inici), MONTH(data_inici), TIMESTAMPDIFF(DAY, data_inici, data_fi)
        FROM reserves LIMIT 100;

    -- Handler per gestionar el final del cursor (NOT FOUND)
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    BEGIN
        SET fi_cursor = TRUE;
    END;

    -- Neteja de registres anteriors
    DELETE FROM estadistics_reserves;

    -- Processament de la consulta mitjançant el cursor
    OPEN cReserves;

    FETCH cReserves INTO tmp_any, tmp_mes, tmp_num_nits;
    WHILE (fi_cursor = FALSE) DO
        INSERT INTO estadistics_reserves(any, mes, num_nits)
        VALUES (tmp_any, tmp_mes, tmp_num_nits);

        FETCH cReserves INTO tmp_any, tmp_mes, tmp_num_nits;
    END WHILE;

    CLOSE cReserves;
END;
//
DELIMITER ;

-- Creació de la taula de destí si no existeix
DROP TABLE IF EXISTS estadistics_reserves;
CREATE TABLE estadistics_reserves (
    any YEAR,
    mes INT,
    num_nits INT
);

-- Execució del procediment i consulta de resultats
CALL sp_OmplirEstadisticsReserves;

SELECT any, mes, SUM(num_nits) AS total_nits
FROM estadistics_reserves
GROUP BY any, mes
ORDER BY mes DESC;

-- ----------------------------------------------------------------------------
-- Exercici 3: Triggers per mantenir el comptador d'habitacions de l'hotel
-- ----------------------------------------------------------------------------

-- Trigger per actualitzar el comptador després d'una inserció
DROP TRIGGER IF EXISTS insert_habitacio_hotel;
DELIMITER //
CREATE TRIGGER insert_habitacio_hotel AFTER INSERT ON habitacions
FOR EACH ROW
BEGIN
    UPDATE hotels
    SET habitacions = habitacions + 1
    WHERE hotel_id = NEW.hotel_id;
END;
//
DELIMITER ;

-- Trigger per actualitzar el comptador després d'una eliminació
DROP TRIGGER IF EXISTS delete_habitacio_hotel;
DELIMITER //
CREATE TRIGGER delete_habitacio_hotel AFTER DELETE ON habitacions
FOR EACH ROW
BEGIN
    UPDATE hotels
    SET habitacions = habitacions - 1
    WHERE hotel_id = OLD.hotel_id;
END;
//
DELIMITER ;

-- Trigger per actualitzar el comptador després d'una actualització (canvi d'hotel)
DROP TRIGGER IF EXISTS update_habitacio_hotel;
DELIMITER //
CREATE TRIGGER update_habitacio_hotel AFTER UPDATE ON habitacions
FOR EACH ROW
BEGIN
    IF OLD.hotel_id != NEW.hotel_id THEN
        -- Restem una habitació de l'hotel antic
        UPDATE hotels
        SET habitacions = habitacions - 1
        WHERE hotel_id = OLD.hotel_id;

        -- Sumem una habitació al nou hotel
        UPDATE hotels
        SET habitacions = habitacions + 1
        WHERE hotel_id = NEW.hotel_id;
    END IF;
END;
//
DELIMITER ;

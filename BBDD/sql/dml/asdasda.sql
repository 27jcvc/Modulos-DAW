CREATE DATABASE exercicis_dml;
USE exercicis_dml;

-- ----------------------------------------------------------------------------
-- Exercici 5: Creació de la taula de clients
-- ----------------------------------------------------------------------------
CREATE TABLE clients (
    client_id INT UNSIGNED AUTO_INCREMENT,
    dni       CHAR(10),
    nom       VARCHAR(15) NOT NULL,
    CONSTRAINT pk_clients PRIMARY KEY (client_id),
    CONSTRAINT uk_clients_dni UNIQUE (dni)
);

-- ----------------------------------------------------------------------------
-- Exercici 6: Creació de la taula de pobles
-- ----------------------------------------------------------------------------
CREATE TABLE pobles (
    poble_id      INT NOT NULL,
    municipi_id   INT NOT NULL,
    nom           VARCHAR(40),
    provincia_nom VARCHAR(14) NOT NULL,
    CONSTRAINT pk_pobles PRIMARY KEY (poble_id, municipi_id)
);

-- ----------------------------------------------------------------------------
-- Exercici 7: Actualització de la taula de jugadors
-- ----------------------------------------------------------------------------
ALTER TABLE jugadors
    ADD COLUMN dni VARCHAR(10) AFTER jugador_id,
    ADD CONSTRAINT uq_jugadors_dni UNIQUE (dni);

-- ----------------------------------------------------------------------------
-- Exercici 8: Gestió de la clau forana de linies_factura
-- ----------------------------------------------------------------------------
ALTER TABLE linies_factura
    DROP FOREIGN KEY fk_linies_factura_factura;

ALTER TABLE linies_factura
    ADD CONSTRAINT fk_linies_factura_factura
        FOREIGN KEY (numero, serie, any)
        REFERENCES factures(numero, serie, any)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

-- ----------------------------------------------------------------------------
-- Consultes sobre municipis_covid19
-- ----------------------------------------------------------------------------
USE municipis_covid19;

SELECT municipi_id, SUM(quantitat) AS qt
FROM casos
WHERE YEAR(data) = 2020
GROUP BY municipi_id
HAVING qt = (
    SELECT SUM(quantitat) AS qt
    FROM casos
    WHERE YEAR(data) = 2020
    GROUP BY municipi_id
    ORDER BY qt ASC
    LIMIT 1
)
ORDER BY qt ASC
LIMIT 100;

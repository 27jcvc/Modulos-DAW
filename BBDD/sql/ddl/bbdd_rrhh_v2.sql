USE rrhh;

-- ----------------------------------------------------------------------------
-- Exercici 1
-- ----------------------------------------------------------------------------
DELETE FROM empleats
WHERE empleat_id = 1;

-- S'han hagut d'afegir els camps 'email' i 'data_contractacio' perquè no permeten valors NULL.
INSERT INTO empleats (empleat_id, nom, cognoms, email, data_contractacio, feina_codi, salari)
VALUES (1, 'Pere', 'Pi', 'perepi@sapalomera.cat', CURRENT_DATE(), 'IT_PROG', 7000);

-- SELECT * FROM empleats;

-- ----------------------------------------------------------------------------
-- Exercici 2
-- ----------------------------------------------------------------------------
DELETE FROM empleats
WHERE empleat_id IN (2, 3, 4);

-- S'han hagut d'afegir els camps 'email' i 'data_contractacio' perquè no permeten valors NULL.
INSERT INTO empleats (empleat_id, nom, cognoms, email, data_contractacio, feina_codi, salari)
VALUES
    (2, 'Sandra', 'González', 'sgonzalez@sapa.cat', CURRENT_DATE(), 'AC_ACCOUNT', 6000),
    (3, 'Marta', 'Pérez', 'mperez@sapa.cat', CURRENT_DATE(), 'AC_ACCOUNT', 6000),
    (4, 'Maria', 'Cantó', 'mcanto@sapa.cat', CURRENT_DATE(), 'AC_ACCOUNT', 6000);

-- ----------------------------------------------------------------------------
-- Exercici 3
-- ----------------------------------------------------------------------------
DELETE FROM historial_feines
WHERE empleat_id IN (5, 6, 7);

DELETE FROM empleats
WHERE empleat_id IN (5, 6, 7);

-- Hi ha una restricció UNIQUE per al camp 'email'.
INSERT INTO empleats (empleat_id, nom, cognoms, email, data_contractacio, feina_codi, departament_id)
VALUES
    (5, 'Pau', 'Serra', 'pserra@prog.cat', '1992-01-15', 'IT_PROG', 60), -- Fins 20 d'Octubre del 1993
    (6, 'Pau', 'Serra', 'pserra@rep.cat', '1993-10-21', 'SA_REP', 50),   -- Fins 21 d'Octubre del 1994
    (7, 'Pau', 'Serra', 'pserra@man.cat', '1994-10-21', 'SA_MAN', 50);   -- Fins 31 de Desembre del 1994

INSERT INTO historial_feines (empleat_id, data_inici, data_fi, feina_codi, departament_id)
VALUES
    (5, '1992-01-15', '1993-10-20', 'IT_PROG', 60),
    (6, '1993-10-21', '1994-10-21', 'SA_REP', 50),
    (7, '1994-10-21', '1994-12-31', 'SA_MAN', 50);

-- ----------------------------------------------------------------------------
-- Exercici 4
-- ----------------------------------------------------------------------------
DELETE FROM paisos
WHERE pais_id IN ('ES', 'FR', 'AU', 'JP', 'KR');

INSERT INTO paisos (pais_id, nom, regio_id)
VALUES
    ('ES', 'Espanya', 1),
    ('FR', 'França', 1),
    ('AU', 'Austràlia', 1),
    ('JP', 'Japó', 1),
    ('KR', 'Corea del Sud', 1);

-- ----------------------------------------------------------------------------
-- Exercici 5
-- ----------------------------------------------------------------------------
UPDATE localitzacions
SET adreca = 'Carrer Vilar Petit',
    ciutat = 'Blanes'
WHERE localitzacio_id = 1800 AND ciutat = 'Toronto';

-- ----------------------------------------------------------------------------
-- Exercici 6 (No completat)
-- ----------------------------------------------------------------------------
INSERT INTO feines (feina_codi, nom_treball)
VALUES ('temporal', 'Feina temporal');

-- Canvi a "temporal"
UPDATE empleats
SET feina_codi = 'temporal'
WHERE feina_codi = 'AD_PRES';

UPDATE empleats
SET feina_codi = 'AD_PRES'
WHERE feina_codi = 'AD_VP';

UPDATE empleats
SET feina_codi = 'AD_VP'
WHERE feina_codi = 'temporal';

SELECT feina_codi
FROM empleats
WHERE feina_codi IN ('AD_VP', 'AD_PRES', 'temporal');

-- ----------------------------------------------------------------------------
-- Exercici 7 (No completat)
-- ----------------------------------------------------------------------------
-- UPDATE historial_feines

SELECT data_inici, data_fi
FROM historial_feines
WHERE empleat_id = 101
    AND data_inici BETWEEN '1900-01-01' AND '1900-01-01'
    AND data_fi BETWEEN '1900-01-01' AND '1900-01-01';

SELECT data_inici, data_fi
FROM historial_feines
WHERE YEAR(data_inici) BETWEEN 1980 AND 1990
    AND YEAR(data_fi) BETWEEN 1900 AND 2000;

SELECT *
FROM information_schema.columns;

-- ----------------------------------------------------------------------------
-- Exercici 8
-- ----------------------------------------------------------------------------
SELECT * FROM empleats;

-- ----------------------------------------------------------------------------
-- Exercici 9
-- ----------------------------------------------------------------------------
SELECT nom, cognoms, salari
FROM empleats
LIMIT 4;

-- ----------------------------------------------------------------------------
-- Exercici 10
-- ----------------------------------------------------------------------------
SELECT * FROM feines;

-- ----------------------------------------------------------------------------
-- Exercici 11
-- ----------------------------------------------------------------------------
SELECT DISTINCT departament_id
FROM empleats
WHERE departament_id IS NOT NULL;

-- ----------------------------------------------------------------------------
-- Exercici 12
-- ----------------------------------------------------------------------------
SELECT empleat_id, cognoms, nom, salari AS salariEUR, (salari * 166.386) AS salariPTS
FROM empleats;

-- ----------------------------------------------------------------------------
-- Exercici 13
-- ----------------------------------------------------------------------------
SELECT cognoms, nom, salari
FROM empleats
WHERE salari > 12000;

-- ----------------------------------------------------------------------------
-- Exercici 14
-- ----------------------------------------------------------------------------
SELECT *
FROM paisos
ORDER BY nom ASC;

-- ----------------------------------------------------------------------------
-- Exercici 15
-- ----------------------------------------------------------------------------
SELECT nom
FROM paisos
WHERE regio_id = 2;

-- ----------------------------------------------------------------------------
-- Exercici 16
-- ----------------------------------------------------------------------------
SELECT cognoms, departament_id, email
FROM empleats
WHERE empleat_id = 176;

-- ----------------------------------------------------------------------------
-- Exercici 17
-- ----------------------------------------------------------------------------
SELECT *
FROM empleats
WHERE YEAR(data_contractacio) > 1996;

-- Nota: Es recomana evitar l'ús de funcions com YEAR() dins de la clàusula WHERE
-- perquè pot afectar el rendiment al no poder utilitzar els índexos.
-- És millor utilitzar comparacions directes de dates, p.ex.: data_contractacio >= '1999-01-01'.

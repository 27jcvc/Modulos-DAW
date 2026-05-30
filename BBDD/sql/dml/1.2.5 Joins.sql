-- 1.2.5 Joins
USE rrhh;

-- ----------------------------------------------------------------------------
-- Exercici 1
-- ----------------------------------------------------------------------------
SELECT e.empleat_id, e.nom, e.cognoms, e.salari, YEAR(e.data_contractacio) AS any_contractacio
FROM empleats e
INNER JOIN departaments d ON d.departament_id = e.departament_id
WHERE YEAR(e.data_contractacio) < 1999
    AND e.salari BETWEEN 10000 AND 20000
    AND (d.nom = 'Vendes' OR d.nom = 'Compres');

-- ----------------------------------------------------------------------------
-- Exercici 2
-- ----------------------------------------------------------------------------
SELECT d.departament_id, d.nom, l.codi_postal, l.ciutat
FROM departaments d
INNER JOIN localitzacions l ON l.localitzacio_id = d.localitzacio_id;

-- ----------------------------------------------------------------------------
-- Exercici 3
-- ----------------------------------------------------------------------------
SELECT d.departament_id, d.nom, l.adreca, l.codi_postal, l.ciutat
FROM departaments d
INNER JOIN localitzacions l ON l.localitzacio_id = d.localitzacio_id
WHERE d.nom = 'Marketing';

-- ----------------------------------------------------------------------------
-- Exercici 4
-- ----------------------------------------------------------------------------
SELECT l.localitzacio_id, l.ciutat, l.estat_provincia, p.nom AS pais, r.nom AS regio
FROM localitzacions l
INNER JOIN paisos p ON p.pais_id = l.pais_id
INNER JOIN regions r ON r.regio_id = p.regio_id
WHERE l.localitzacio_id IN (1400, 1700, 2500)
ORDER BY l.localitzacio_id;

-- ----------------------------------------------------------------------------
-- Exercici 13 / 14
-- ----------------------------------------------------------------------------
SELECT e.empleat_id, e.cognoms, f.nom_treball, e.salari, f.salari_min
FROM feines f
INNER JOIN empleats e ON e.feina_codi = f.feina_codi
WHERE f.nom_treball IN ('Programador', 'Venedor')
    AND e.salari > f.salari_min + 1000;

-- ----------------------------------------------------------------------------
-- Exercici 15
-- ----------------------------------------------------------------------------
SELECT e.nom, e.cognoms, hf.data_inici, hf.data_fi, f.nom_treball, d.nom AS nom_departament
FROM historial_feines hf
INNER JOIN empleats e ON e.empleat_id = hf.empleat_id
INNER JOIN feines f ON f.feina_codi = hf.feina_codi
INNER JOIN departaments d ON d.departament_id = hf.departament_id;

-- ----------------------------------------------------------------------------
-- Exercici 16
-- ----------------------------------------------------------------------------
SELECT e.nom, e.cognoms, e.salari, f.nom_treball, l.ciutat, p.nom AS pais, r.nom AS regio
FROM empleats e
INNER JOIN departaments d ON d.departament_id = e.departament_id
INNER JOIN localitzacions l ON l.localitzacio_id = d.localitzacio_id
INNER JOIN paisos p ON p.pais_id = l.pais_id
INNER JOIN regions r ON r.regio_id = p.regio_id
INNER JOIN feines f ON f.feina_codi = e.feina_codi;

-- ----------------------------------------------------------------------------
-- Exercici 17
-- ----------------------------------------------------------------------------
SELECT e.nom, e.cognoms, e.salari, f.nom_treball, l.ciutat, p.nom AS pais, r.nom AS regio
FROM empleats e
LEFT JOIN departaments d ON d.departament_id = e.departament_id
LEFT JOIN localitzacions l ON l.localitzacio_id = d.localitzacio_id
LEFT JOIN paisos p ON p.pais_id = l.pais_id
LEFT JOIN regions r ON r.regio_id = p.regio_id
INNER JOIN feines f ON f.feina_codi = e.feina_codi; -- INNER JOIN perquè la feina sempre existeix encara que no hi hagi departament

-- ----------------------------------------------------------------------------
-- Exercici 18
-- ----------------------------------------------------------------------------

-- Consultes Reflexives (Self-Joins)
SELECT e.empleat_id, e.nom, IFNULL(c.empleat_id, 'Es su propio jefe') AS cap_id,
       IFNULL(c.nom, 'Es su propio jefe') AS nom_cap
FROM empleats e
LEFT JOIN empleats c ON c.empleat_id = e.id_cap;

SELECT e.empleat_id, e.nom, IFNULL(c.empleat_id, 'Es su propio jefe') AS cap_id,
       IFNULL(c.nom, 'Es su propio jefe') AS nom_cap,
       e.data_contractacio
FROM empleats e
LEFT JOIN empleats c ON c.empleat_id = e.id_cap
WHERE e.data_contractacio < c.data_contractacio;

SELECT COUNT(e1.data_contractacio)
FROM empleats e
INNER JOIN empleats e1 ON e.data_contractacio = 1996
INNER JOIN empleats e2 ON e.data_contractacio = 1997
INNER JOIN empleats e3 ON e.data_contractacio = 1998;

SELECT
    (SELECT COUNT(*) FROM empleats WHERE YEAR(data_contractacio) = 1996) AS '1996',
    (SELECT COUNT(*) FROM empleats WHERE YEAR(data_contractacio) = 1997) AS '1997',
    (SELECT COUNT(*) FROM empleats WHERE YEAR(data_contractacio) = 1998) AS '1998',
    (SELECT COUNT(*) FROM empleats) AS total
FROM empleats e
GROUP BY total;

-- Exercicis de la "Copa del Rei" (Resum per any)
SELECT
    SUM(IF(YEAR(e.data_contractacio) = 1996, 1, 0)) AS '1996',
    SUM(IF(YEAR(e.data_contractacio) = 1997, 1, 0)) AS '1997',
    SUM(IF(YEAR(e.data_contractacio) = 1998, 1, 0)) AS '1998',
    COUNT(*) AS total
FROM empleats e
WHERE YEAR(e.data_contractacio) IN (1996, 1997, 1998);

SELECT COUNT(*) AS '1996' FROM empleats WHERE YEAR(data_contractacio) = 1996;
SELECT COUNT(*) AS '1997' FROM empleats WHERE YEAR(data_contractacio) = 1997;
SELECT COUNT(*) AS '1998' FROM empleats WHERE YEAR(data_contractacio) = 1998;
SELECT COUNT(*) AS total FROM empleats;

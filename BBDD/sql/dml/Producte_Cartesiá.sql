-- Producte cartesià (Similar a l'INNER JOIN però sense control de condició en la sintaxi JOIN)
-- Al fer servir la clau forana (FK), es filtra mitjançant l'índex.

USE rrhh;

-- ----------------------------------------------------------------------------
-- Producte Cartesià: Relació empleats i departaments
-- ----------------------------------------------------------------------------
SELECT d.nom AS nom_dep,
       e.*
FROM empleats AS e,
     departaments AS d
WHERE d.departament_id = e.departament_id;

-- ----------------------------------------------------------------------------
-- Producte Cartesià: Comptador per departament
-- ----------------------------------------------------------------------------
SELECT d.nom AS nom_dep, COUNT(*)
FROM empleats AS e,
     departaments AS d
WHERE d.departament_id = e.departament_id
GROUP BY d.nom;

/*
  Resum de Joins:
  - INNER JOIN: Retorna registres quan hi ha coincidència en ambdues taules.
  - LEFT OUTER JOIN: Retorna tots els registres de la taula esquerra i els coincidents de la dreta.
  - IFNULL: S'utilitza al SELECT per substituir valors NULL per un text o valor específic.
  - Taula esquerra: La taula definida al FROM.
  - Taula dreta: La taula definida al JOIN.
*/

-- ----------------------------------------------------------------------------
-- Vistes (Views) - Creades mitjançant INNER JOINS i SELECTS
-- ----------------------------------------------------------------------------
CREATE VIEW v_empleats_deps AS
SELECT e.nom, e.cognoms,
       d.nom AS dep_nom,
       e.feina_codi
FROM empleats e
INNER JOIN departaments d ON d.departament_id = e.departament_id;

SELECT *
FROM v_empleats_deps ved
INNER JOIN feines f ON f.feina_codi = ved.feina_codi;

-- ----------------------------------------------------------------------------
-- Taula EMPLEATS: Exercicis de filtrat per salari
-- ----------------------------------------------------------------------------

-- Selecciona els empleats amb salari fora del rang mínim i màxim
SELECT e.nom, e.cognoms, e.salari AS salari_empleat,
       f.nom_treball, f.salari_min, f.salari_max
FROM empleats e
INNER JOIN feines f ON f.feina_codi = e.feina_codi
WHERE e.salari > f.salari_min AND e.salari < f.salari_max;

-- Selecciona els empleats amb salari dins del rang mínim i màxim (utilitzant BETWEEN)
SELECT e.nom, e.cognoms, e.salari AS salari_empleat,
       f.nom_treball, f.salari_min, f.salari_max
FROM empleats e
INNER JOIN feines f ON f.feina_codi = e.feina_codi
WHERE e.salari BETWEEN f.salari_min AND f.salari_max;

-- Misme resultat que l'anterior però utilitzant la sintaxi de Producte Cartesià
SELECT e.nom, e.cognoms, e.salari AS salari_empleat,
       f.nom_treball, f.salari_min, f.salari_max
FROM empleats e, feines f
WHERE e.salari > f.salari_min AND e.salari < f.salari_max AND f.feina_codi = e.feina_codi;

-- Common Table Expressions (CTE) i Window Functions

-- Exemple de CTE (Comentat)
-- WITH dep AS (
--     SELECT ...
--     FROM ...
-- )
-- SELECT * FROM dep;

-- ----------------------------------------------------------------------------
-- Window Functions
-- ----------------------------------------------------------------------------

-- Aggregate Window Function: Suma del salari per departament sense agrupar files
SELECT empleat_id, nom, cognoms, salari, departament_id,
       SUM(salari) OVER (PARTITION BY departament_id) AS massa_salarial
FROM empleats;

-- ----------------------------------------------------------------------------
-- Ranking Window Functions
-- ----------------------------------------------------------------------------
-- RANK(): Assigna un rang. Si hi ha empats, deixa buits els següents rangs (1, 2, 2, 4).
-- DENSE_RANK(): Assigna un rang sense deixar buits (1, 2, 2, 3).
-- PERCENT_RANK(): Calcula el rang percentil (0 a 1).
-- NTILE(n): Divideix els resultats en n grups.

SELECT empleat_id, nom, cognoms, salari, departament_id,
       RANK() OVER (
           PARTITION BY departament_id ORDER BY salari
       ) AS salari_rank
FROM empleats
WHERE departament_id IS NOT NULL
ORDER BY departament_id;

-- ----------------------------------------------------------------------------
-- Value Window Functions
-- ----------------------------------------------------------------------------
-- LAG(): Retorna el valor de la fila anterior.
-- LEAD(): Retorna el valor de la fila següent.
-- FIRST_VALUE(): Retorna el primer valor del grup.
-- LAST_VALUE(): Retorna l'últim valor del grup.

-- ----------------------------------------------------------------------------
-- Named Windows
-- ----------------------------------------------------------------------------
-- Permet definir una finestra una sola vegada i reutilitzar-la en diverses funcions.

SELECT empleat_id, nom, cognoms, departament_id AS dep,
       feina_codi,
       salari,
       AVG(salari) OVER w_dep AS avg_dep,
       AVG(salari) OVER w_feina AS avg_feina
FROM empleats
WHERE departament_id IS NOT NULL
WINDOW w_dep AS (PARTITION BY departament_id),
       w_feina AS (PARTITION BY feina_codi)
ORDER BY dep;

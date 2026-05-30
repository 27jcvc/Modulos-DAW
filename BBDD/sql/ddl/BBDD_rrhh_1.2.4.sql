USE rrhh;

-- ------------------------------------------------------------------------------------
-- Exercici 1: Empleats contractats l'any anterior
-- ------------------------------------------------------------------------------------
SELECT *
FROM empleats
WHERE YEAR(data_contractacio) = YEAR(CURRENT_DATE()) - 1;

-- ------------------------------------------------------------------------------------
-- Exercici 2: Empleat amb menys antiguitat
-- ------------------------------------------------------------------------------------
SELECT empleat_id, YEAR(data_contractacio) - YEAR(CURRENT_DATE()) AS anys_antiguitat
FROM empleats
ORDER BY anys_antiguitat ASC
LIMIT 1;

-- ------------------------------------------------------------------------------------
-- Exercici 3: Empleat amb més antiguitat
-- ------------------------------------------------------------------------------------
SELECT empleat_id, YEAR(data_contractacio) - YEAR(CURRENT_DATE()) AS anys_antiguitat
FROM empleats
ORDER BY anys_antiguitat DESC
LIMIT 1;

-- ------------------------------------------------------------------------------------
-- Exercici 4: Salari mitjà per tipus de feina
-- ------------------------------------------------------------------------------------
SELECT feina_codi, ROUND(AVG(salari)) AS salari_mig
FROM empleats
GROUP BY feina_codi;

-- ------------------------------------------------------------------------------------
-- Exercici 5: Salari màxim i mínim general
-- ------------------------------------------------------------------------------------
SELECT MAX(salari) AS salari_max, MIN(salari) AS salari_min
FROM empleats;

-- ------------------------------------------------------------------------------------
-- Exercici 6: Salari mitjà i nombre total d'empleats
-- ------------------------------------------------------------------------------------
SELECT AVG(salari) AS salari_avg, COUNT(*) AS num_empleats
FROM empleats;

-- ------------------------------------------------------------------------------------
-- Exercici 7: Mitjana de salaris màxims per tipus de feina
-- ------------------------------------------------------------------------------------
SELECT nom_treball, AVG(salari_max) AS mitjana_salaris
FROM feines
GROUP BY nom_treball
ORDER BY nom_treball;

-- ------------------------------------------------------------------------------------
-- Exercici 8: Nombre d'empleats per tipus de feina
-- ------------------------------------------------------------------------------------
SELECT f.nom_treball, COUNT(*) AS num_empleats
FROM feines AS f
INNER JOIN empleats AS e ON e.feina_codi = f.feina_codi
GROUP BY f.nom_treball
ORDER BY num_empleats DESC;

-- ------------------------------------------------------------------------------------
-- Exercici 9: Nombre d'empleats per departament
-- ------------------------------------------------------------------------------------
SELECT d.nom, COUNT(*) AS num_empleats
FROM departaments AS d
INNER JOIN empleats AS e ON e.departament_id = d.departament_id
GROUP BY d.nom
ORDER BY num_empleats DESC;

-- ------------------------------------------------------------------------------------
-- Exercici 10: Nombre d'empleats per departament (incloent no assignats)
-- ------------------------------------------------------------------------------------
SELECT IFNULL(d.nom, 'No assignat') AS identificador, COUNT(*) AS num_empleats
FROM departaments AS d
RIGHT JOIN empleats AS e ON e.departament_id = d.departament_id
GROUP BY d.nom
ORDER BY num_empleats DESC;

-- ------------------------------------------------------------------------------------
-- Exercici 11: Nombre de caps únics
-- ------------------------------------------------------------------------------------
SELECT COUNT(DISTINCT id_cap) AS qt
FROM empleats
WHERE id_cap IS NOT NULL;

-- ------------------------------------------------------------------------------------
-- Exercici 12: Diferència entre el salari mínim i màxim
-- ------------------------------------------------------------------------------------
SELECT MIN(salari) - MAX(salari) AS diferencia
FROM empleats;

-- ------------------------------------------------------------------------------------
-- Exercici 13: Salari mínim per cap i empleat
-- ------------------------------------------------------------------------------------
SELECT id_cap, empleat_id, MIN(salari) AS salari_min
FROM empleats
WHERE id_cap IS NOT NULL
GROUP BY id_cap, empleat_id;

-- ------------------------------------------------------------------------------------
-- Exercici 14: Caps amb salari mínim superior a 6000
-- ------------------------------------------------------------------------------------
SELECT id_cap, MIN(salari) AS salari_min
FROM empleats
WHERE id_cap IS NOT NULL
GROUP BY id_cap
HAVING salari_min > 6000;

-- ------------------------------------------------------------------------------------
-- Exercici 15: Nombre d'empleats per any de contractació (anys parells)
-- ------------------------------------------------------------------------------------
SELECT YEAR(data_contractacio) AS any, COUNT(*) AS qt
FROM empleats
GROUP BY any
HAVING (any % 2) = 0
ORDER BY any ASC;

-- ------------------------------------------------------------------------------------
-- Exercici 16: Nombre d'empleats per departament
-- ------------------------------------------------------------------------------------
SELECT d.departament_id, COUNT(*) AS qt_empleats
FROM departaments AS d
INNER JOIN empleats AS e ON e.departament_id = d.departament_id
GROUP BY d.departament_id;

-- ------------------------------------------------------------------------------------
-- Exercici 17: Empleats amb salari superior a 9000
-- ------------------------------------------------------------------------------------
SELECT COUNT(*) AS nombre_empleats
FROM empleats
WHERE salari > 9000;

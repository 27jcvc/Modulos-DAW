USE rrhh;

-- ----------------------------------------------------------------------------
-- Exercici 1: Empleats del departament d'IT
-- ----------------------------------------------------------------------------
SELECT e.empleat_id, e.nom
FROM empleats e
WHERE e.departament_id = (
    SELECT d.departament_id
    FROM departaments d
    WHERE d.nom = 'IT'
);

-- ----------------------------------------------------------------------------
-- Exercici 1: Empleats amb el mateix salari que 'Pat Fay' (Multitaula)
-- ----------------------------------------------------------------------------
SELECT e1.empleat_id, e1.nom, e1.salari
FROM empleats e1
WHERE e1.salari = (
    SELECT e2.salari
    FROM empleats e2
    WHERE CONCAT(e2.nom, ' ', e2.cognoms) = 'Pat Fay'
    AND e1.nom != e2.nom
);

-- ----------------------------------------------------------------------------
-- Exercici 2: Empleats amb salari superior al de 'Pat Fay'
-- ----------------------------------------------------------------------------
SELECT e1.empleat_id, e1.nom, e1.salari
FROM empleats e1
WHERE e1.salari > ANY (
    SELECT e2.salari
    FROM empleats e2
    WHERE CONCAT(e2.nom, ' ', e2.cognoms) = 'Pat Fay'
);

-- ----------------------------------------------------------------------------
-- Següents Exercicis (Descripcions)
-- ----------------------------------------------------------------------------
/*
Exercici 3 - Obtenir el id_empleat, cognoms i codi departament dels empleats
que treballen en el mateix departament que l'empleat ‘Pat Fay’.

Exercici 4 - Obté el id_empleat, nom i salari dels empleats que guanyen més del
departament de ‘Vendes’.

Exercici 5 - Obté el id_empleat, nom i salari dels empleats que guanyen menys
del departament de ‘Vendes’.

Exercici 6 - Obté el id_empleat, nom i salari dels empleats del departament de
‘Compres’ que guanyen més que la mitjana d’aquest departament.

Exercici 7 - Obté el nom, cognom i data de contractació dels empleats que van
ser contractats després de l'empleat ‘Pat Fay’. Ordena per data de contractació.

Exercici 8 - Volem saber els cognoms, salari i codi de departament dels empleats
que guanyen més que la mitjana dels salaris del departament ‘Compres’. Exlou
els que siguin d’aquest departament.

Exercici 9 - Partint de la consulta anterior, volem saber també el nom del
departament dels empleats. Ordena per salari.

Exercici 10 - Volem saber el codi, nom i cognom del jefe de l'empleat 103. Utilitza
l'operador IN.

Exercici 11 - Quins departaments no tenim empleats? Mostra el codi i nom de
departament. Utilitza l'operador NOT IN.

Exercici 12 - Quins empleats (nom/cognom/nom_departament) pertanyen als
mateixos departaments situats a Seattle.

Exercici 13 - Crea una llista dels empleats mostrant l’inicial del nom juntament
amb el cognom separat per un punt (‘.’), el salari, el nom del departament de cada
empleat que guanyi més de la mitjana del seu propi departament.

Exercici 14 - Quins empleats només han estat assignats a un sol treball? Mostra
el codi empleat, nom, cognom i ordena per codi empleat.

Exercici 15 - Obté per cada departament, el salari màxim. Descarta els empleats
que no tenen assignat cap departament.

Exercici 16 - Dels empleats que no treballen a cap departament indica quins són
els que guanyen més? (nom, cognoms i salari).

Exercici 17 - Volem saber quins empleats guanyen més de cada departament.
Mostra el codi empleat, nom, codi de departament, nom departament i salari.
Utilitza l’operador IN.

Exercici 18 - Volem saber el nom, cognoms i salari dels empleats que guanyen
més QUE ALGUN dels empleats del departament de ‘Vendes’.

Exercici 19 - Volem saber el nom, cognoms i salari dels empleats que guanyen
més QUE TOTS els empleats del departament de ‘Vendes’.

Exercici 20 - Quants empleats tenim del departament de ‘IT’ que van ser
contractats abans que ALGUN empleat del departament de ‘Vendes’? Mostra
els cognoms i la data de contractació.

Exercici 21 - Quants empleats tenim del departament de ‘IT’ que van ser
contractats abans que TOTS els empleats del departament de ‘Vendes’? Mostra
els cognoms i la data de contractació.

Exercici 22 - Utilitzant l’operador EXISTS. Volem saber els departaments que
tenen assignats empleats.
*/

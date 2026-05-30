# 🗄️ Ejercicios de Bases de Datos - DAW

Este repositorio contiene una recopilación de ejercicios y proyectos realizados durante el año académico en el ciclo de **Desarrollo de Aplicaciones Web (DAW)**. El enfoque principal es la gestión de datos utilizando SQL (Relacional) y MongoDB (NoSQL).

## 🚀 Contenido del Repositorio

El proyecto está organizado de la siguiente manera para facilitar su navegación:

### 📁 `sql/`
Contiene todo el trabajo realizado con bases de datos relacionales (MySQL/MariaDB).
- **`ddl/` (Data Definition Language):** Scripts de creación de esquemas, definición de tablas, restricciones y relaciones. Incluye la base de datos de Recursos Humanos (`rrhh`) y ejercicios de COVID-19.
- **`dml/` (Data Manipulation Language):** Consultas y manipulación de datos.
    - **Joins:** Ejercicios de unión de tablas (INNER JOIN, LEFT JOIN) y autorreferencias.
    - **Subconsultas:** Uso de queries anidadas para filtrado avanzado.
    - **Funciones de Ventana & CTE:** Implementación de `RANK()`, `SUM() OVER`, `PARTITION BY` y Expresiones de Tabla Comunes (CTEs) para análisis de datos complejos.
    - **Operaciones CRUD:** Scripts de `INSERT`, `UPDATE` y `DELETE`.
- **`projects/`:** Implementaciones de proyectos académicos específicos (como el AP1).

### 📁 `mongodb/`
Ejercicios prácticos sobre bases de datos NoSQL.
- Consultas básicas y filtrado de documentos.
- Uso del **Aggregation Framework** (`$group`, `$match`, `$sum`, `$avg`) para generar reportes y estadísticas.

### 📁 `docs/`
Documentación complementaria, enunciados en PDF y archivos de apoyo utilizados durante el curso.

## 🛠️ Tecnologías Utilizadas
- **SQL:** MySQL / MariaDB
- **NoSQL:** MongoDB
- **Herramientas:** MySQL Workbench, MongoDB Compass, VS Code

## 📝 Notas de Implementación
En los ejercicios de SQL, se ha puesto especial énfasis en la **optimización de consultas**, evitando el uso de funciones dentro del `WHERE` cuando afectan el rendimiento de los índices, y priorizando el uso de Window Functions para cálculos de agregación sin perder el detalle de las filas.

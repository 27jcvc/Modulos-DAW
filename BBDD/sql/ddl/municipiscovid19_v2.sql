USE municipis_covid19;

-- ----------------------------------------------------------------------------
-- MUNICIPI
-- ----------------------------------------------------------------------------

RENAME TABLE municipis TO municipi;
RENAME TABLE casos TO municipi_cas;
RENAME TABLE tipus_casos TO tipus_cas;

ALTER TABLE municipi
    MODIFY COLUMN codi_ine CHAR(5),
    MODIFY COLUMN codi VARCHAR(40) NOT NULL,
    CHANGE COLUMN comarca comarca_id INT UNSIGNED AFTER municipi_id,
    ADD COLUMN num_habitants INT UNSIGNED AFTER nom;

ALTER TABLE municipi
    ADD CONSTRAINT uk_municipi_codi_codi_ine UNIQUE (codi, codi_ine),
    ADD CONSTRAINT pk_municipi_id PRIMARY KEY (municipi_id);

ALTER TABLE municipi
    MODIFY COLUMN municipi_id INT UNSIGNED AUTO_INCREMENT;

-- ----------------------------------------------------------------------------
-- COMARCA
-- ----------------------------------------------------------------------------

ALTER TABLE comarca
    MODIFY COLUMN comarca_id INT UNSIGNED AUTO_INCREMENT,
    MODIFY COLUMN codi CHAR(2) NOT NULL,
    MODIFY COLUMN nom VARCHAR(25) NOT NULL,
    ADD CONSTRAINT pk_comarca_comarca_id PRIMARY KEY (comarca_id),
    ADD CONSTRAINT uk_comarca_codi UNIQUE (codi);

-- ----------------------------------------------------------------------------
-- MUNICIPI_CAS (casos)
-- ----------------------------------------------------------------------------

ALTER TABLE municipi_cas
    DROP FOREIGN KEY fk_casos_tipus_casos,
    DROP INDEX fk_casos_tipus_casos;

ALTER TABLE tipus_cas
    DROP PRIMARY KEY;

CREATE INDEX fk_tipus_cas ON tipus_cas (tipus_cas);

-- ----------------------------------------------------------------------------
-- TIPUS_CAS (tipus_casos)
-- ----------------------------------------------------------------------------

ALTER TABLE tipus_cas
    MODIFY COLUMN tipus_cas VARCHAR(5),
    ADD CONSTRAINT pk_tipus_cas PRIMARY KEY (tipus_cas),
    ADD CONSTRAINT ck_tipus_cas_valors CHECK (tipus_cas IN ('PCR', 'TAR', 'ELISA', 'TR', 'EPID')),
    ADD CONSTRAINT ck_tipus_cas_tipus_cas CHECK (tipus_cas = UPPER(tipus_cas));

-- ----------------------------------------------------------------------------
-- Actualització de MUNICIPI_CAS
-- ----------------------------------------------------------------------------

ALTER TABLE municipi_cas
    MODIFY COLUMN municipi_id INT UNSIGNED AUTO_INCREMENT,
    MODIFY COLUMN sexe ENUM('H', 'D'),
    MODIFY COLUMN tipus_cas VARCHAR(5),
    ADD COLUMN any YEAR GENERATED ALWAYS AS (YEAR(data)) AFTER tipus_cas,
    MODIFY COLUMN quantitat INT UNSIGNED DEFAULT 0,
    ADD CONSTRAINT pk_municipi_cas PRIMARY KEY (municipi_id, data, sexe, tipus_cas),
    ADD CONSTRAINT fk_municipi_cas_municipi_id FOREIGN KEY (municipi_id)
        REFERENCES municipi (municipi_id),
    ADD CONSTRAINT fk_municipi_cas_tipus_cas FOREIGN KEY (tipus_cas)
        REFERENCES tipus_cas (tipus_cas),
    ADD CONSTRAINT ck_municipi_cas_quantitat CHECK (quantitat BETWEEN 1 AND 1000),
    ADD CONSTRAINT ck_municipi_cas_tipus_cas CHECK (tipus_cas = UPPER(tipus_cas));

CREATE INDEX idx_municipis_codi_ine ON municipi (codi_ine);

-- Vista de municipis de Girona
CREATE VIEW v_municipis_girona AS
SELECT municipi_id, comarca_id, nom
FROM municipi
WHERE comarca_id IN (2, 10, 15, 19, 20, 28, 31, 34);

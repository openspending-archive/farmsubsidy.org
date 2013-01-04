
-- ALTER TABLE scheme ADD COLUMN invalid BOOLEAN DEFAULT true;
-- SELECT DISTINCT "GlobalSchemeId" FROM scheme;

ALTER TABLE country ADD COLUMN name VARCHAR(3);
UPDATE country SET name = LOWER(code);

CREATE SEQUENCE country_id_seq;
ALTER TABLE country ADD COLUMN id INT DEFAULT nextval('country_id_seq');
ALTER TABLE country ALTER COLUMN id SET NOT NULL;
ALTER SEQUENCE country_id_seq OWNED BY country.id;

ALTER TABLE payment ADD COLUMN country_id INT;
UPDATE payment AS p SET country_id = c.id FROM country c WHERE c."code" = p."countryPayment";
ALTER TABLE payment DROP COLUMN "countryPayment";


-- SCHEME TABLE 

CREATE SEQUENCE scheme_id_seq;
ALTER TABLE scheme ADD COLUMN id INT DEFAULT nextval('scheme_id_seq');
ALTER TABLE scheme ALTER COLUMN id SET NOT NULL;
ALTER SEQUENCE scheme_id_seq OWNED BY scheme.id;

ALTER TABLE payment ADD COLUMN scheme_id INT;
-- UPDATE payment SET scheme_id =
--  (SELECT id FROM scheme WHERE scheme."GlobalSchemeId" = payment."globalSchemeId");

UPDATE payment AS p SET scheme_id=s.id FROM scheme s WHERE s."GlobalSchemeId" = p."globalSchemeId";
CREATE INDEX scheme_id_idx ON payment (scheme_id);


-- RECIPIENT TABLE

CREATE SEQUENCE recipient_id_seq;
ALTER TABLE recipient ADD COLUMN id INT DEFAULT nextval('recipient_id_seq');
ALTER TABLE recipient ALTER COLUMN id SET NOT NULL;
ALTER SEQUENCE recipient_id_seq OWNED BY recipient.id;

ALTER TABLE recipient RENAME name TO label;
UPDATE recipient SET label = BTRIM(label, ' ;:-,`');
ALTER TABLE recipient DROP COLUMN "countryPayment";

-- PAYMENT TABLE

ALTER TABLE payment DROP COLUMN "paymentId";


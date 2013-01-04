
ALTER TABLE country ADD COLUMN name VARCHAR(3);
UPDATE country SET name = LOWER(code);

CREATE SEQUENCE country_id_seq;
ALTER TABLE country ADD COLUMN id INT DEFAULT nextval('country_id_seq');
ALTER TABLE country ALTER COLUMN id SET NOT NULL;
ALTER SEQUENCE country_id_seq OWNED BY country.id;
ALTER TABLE payment ADD COLUMN country_id INT;


-- SCHEME TABLE 

CREATE SEQUENCE scheme_id_seq;
ALTER TABLE scheme ADD COLUMN id INT DEFAULT nextval('scheme_id_seq');
ALTER TABLE scheme ALTER COLUMN id SET NOT NULL;
ALTER SEQUENCE scheme_id_seq OWNED BY scheme.id;
ALTER TABLE payment ADD COLUMN scheme_id INT;

ALTER TABLE recipient RENAME "nameEnglish" TO label;
ALTER TABLE recipient ADD COLUMN name VARCHAR(2000);
UPDATE recipient SET
  label = BTRIM(label, ' ;:-,`'),
  name = BTRIM(LOWER("GlobalSchemeId"), ' ;:-,`');

-- RECIPIENT TABLE

CREATE SEQUENCE recipient_id_seq;
ALTER TABLE recipient ADD COLUMN id INT DEFAULT nextval('recipient_id_seq');
ALTER TABLE recipient ALTER COLUMN id SET NOT NULL;
ALTER SEQUENCE recipient_id_seq OWNED BY recipient.id;
ALTER TABLE payment ADD COLUMN recipient_id INT;

ALTER TABLE recipient RENAME name TO label;
ALTER TABLE recipient ADD COLUMN name VARCHAR(2000);
UPDATE recipient SET
  label = BTRIM(label, ' ;:-,`'),
  name = BTRIM(LOWER("globalRecipientId"), ' ;:-,`');

-- PAYMENT TABLE

ALTER TABLE payment ADD COLUMN "id" VARCHAR(42);
ALTER TABLE payment ADD COLUMN "amount" DOUBLE PRECISION;

UPDATE payment AS p SET
  id = MD5(p."globalPaymentId"),
  amount = cast(p."amountEuro" as double precision)
  scheme_id = s.id,
  recipient_id = r.id,
  country_id = c.id
  FROM scheme s, recipient r, country c
  WHERE
    s."GlobalSchemeId" = p."globalSchemeId"
    AND r."globalRecipientId" = p."globalRecipientId"
    AND c."code" = p."countryPayment";

-- UPDATE payment AS p SET scheme_id=s.id FROM scheme s WHERE s."GlobalSchemeId" = p."globalSchemeId";
-- UPDATE payment AS p SET recipient_id=r.id FROM recipient r WHERE r."globalRecipientId" = p."globalRecipientId";
-- UPDATE payment AS p SET country_id = c.id FROM country c WHERE c."code" = p."countryPayment";
CREATE INDEX scheme_id_idx ON payment (scheme_id);
CREATE INDEX recipient_id_idx ON payment (recipient_id);
CREATE INDEX country_id_idx ON payment (country_id);
CREATE INDEX payment_id_idx ON payment (id);


-- DROP SUPERFLUOUS COLUMNS

-- ALTER TABLE payment DROP COLUMN "paymentId";
-- ALTER TABLE payment DROP COLUMN "countryPayment";
-- ALTER TABLE recipient DROP COLUMN "total";
-- ALTER TABLE recipient DROP COLUMN "countryPayment";
-- ALTER TABLE scheme DROP COLUMN "total";



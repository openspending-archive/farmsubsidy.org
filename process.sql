ANALYZE;

TRUNCATE TABLE time;
INSERT INTO time (week, yearmonth, name, year, intyear, month, quarter, day, label)
  SELECT '00', format('%s-01', year),
  format('%s-01-01', year),
  year, year, '01', '0', '01',
  format('01. January %s', year)
  FROM (SELECT DISTINCT year FROM payment) AS year;
ALTER TABLE payment ADD COLUMN time_id INT;

ALTER TABLE country ADD COLUMN name VARCHAR(3);
UPDATE country SET name = LOWER(code);

ALTER TABLE scheme RENAME "nameEnglish" TO label;
ALTER TABLE scheme ADD COLUMN name VARCHAR(2000);
UPDATE scheme SET
  label = BTRIM(label, ' ;:-,`'),
  name = BTRIM(LOWER("GlobalSchemeId"), ' ;:-,`');

ALTER TABLE recipient RENAME name TO label;
ALTER TABLE recipient ADD COLUMN name VARCHAR(2000);
UPDATE recipient SET
  label = BTRIM(label, ' ;:-,`'),
  name = BTRIM(LOWER("globalRecipientId"), ' ;:-,`');

ALTER TABLE payment ADD COLUMN "id" VARCHAR(42);
ALTER TABLE payment ADD COLUMN "amount" DOUBLE PRECISION;

UPDATE payment SET
  id = MD5("globalPaymentId"),
  amount = cast("amountEuro" as double precision);

UPDATE payment AS p SET scheme_id=s.id FROM scheme s WHERE s."GlobalSchemeId" = p."globalSchemeId";
UPDATE payment AS p SET recipient_id=r.id FROM recipient r WHERE r."globalRecipientId" = p."globalRecipientId";
UPDATE payment AS p SET country_id = c.id FROM country c WHERE c."code" = p."countryPayment";
UPDATE payment AS p SET time_id = t.id FROM time t WHERE t.intyear = p."year";

INSERT INTO scheme (name, label) VALUES ('unknown', '(Unknown Scheme)');
INSERT INTO recipient (name, label) VALUES ('unknown', '(Unknown Recipient)');

UPDATE payment SET scheme_id = (SELECT id FROM scheme WHERE name = 'unknown') WHERE scheme_id IS NULL;
UPDATE payment SET recipient_id = (SELECT id FROM recipient WHERE name = 'unknown') WHERE recipient_id IS NULL;

DELETE FROM scheme WHERE id NOT IN (SELECT DISTINCT scheme_id FROM payment);
DELETE FROM country WHERE id NOT IN (SELECT DISTINCT country_id FROM payment);
DELETE FROM recipient WHERE id NOT IN (SELECT DISTINCT recipient_id FROM payment);

DELETE FROM payment WHERE amount IS NULL;
DELETE FROM payment WHERE time_id IS NULL;



CREATE SEQUENCE eucap_country_id_seq;
ALTER TABLE country ADD COLUMN id INT DEFAULT nextval('eucap_country_id_seq');
ALTER TABLE country ALTER COLUMN id SET NOT NULL;
ALTER SEQUENCE eucap_country_id_seq OWNED BY country.id;
ALTER TABLE payment ADD COLUMN country_id INT;

CREATE SEQUENCE eucap_scheme_id_seq;
ALTER TABLE scheme ADD COLUMN id INT DEFAULT nextval('eucap_scheme_id_seq');
ALTER TABLE scheme ALTER COLUMN id SET NOT NULL;
ALTER SEQUENCE eucap_scheme_id_seq OWNED BY scheme.id;
ALTER TABLE payment ADD COLUMN scheme_id INT;

CREATE SEQUENCE eucap_recipient_id_seq;
ALTER TABLE recipient ADD COLUMN id INT DEFAULT nextval('eucap_recipient_id_seq');
ALTER TABLE recipient ALTER COLUMN id SET NOT NULL;
ALTER SEQUENCE eucap_recipient_id_seq OWNED BY recipient.id;
ALTER TABLE payment ADD COLUMN recipient_id INT;




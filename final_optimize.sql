
ALTER TABLE payment DROP COLUMN "paymentId";
ALTER TABLE payment DROP COLUMN "globalPaymentId";
ALTER TABLE payment DROP COLUMN "globalRecipientId";
ALTER TABLE payment DROP COLUMN "globalRecipientIdx";
ALTER TABLE payment DROP COLUMN "globalSchemeId";
ALTER TABLE payment DROP COLUMN "amountNationalCurrency";
ALTER TABLE payment DROP COLUMN "amountEuro";
ALTER TABLE payment DROP COLUMN "year";
ALTER TABLE payment DROP COLUMN "paymentId";
ALTER TABLE payment DROP COLUMN "countryPayment";

ALTER TABLE recipient DROP COLUMN "recipientId";
ALTER TABLE recipient DROP COLUMN "recipientIdx";
ALTER TABLE recipient DROP COLUMN "globalRecipientIdx";
ALTER TABLE recipient DROP COLUMN "globalRecipientId";
ALTER TABLE recipient DROP COLUMN "total";
ALTER TABLE recipient DROP COLUMN "countryPayment";

ALTER TABLE scheme DROP COLUMN "total";
ALTER TABLE scheme DROP COLUMN "GlobalSchemeId";
ALTER TABLE scheme DROP COLUMN "countryPayment";

ALTER TABLE time DROP COLUMN "intyear";

CREATE INDEX eucap_entry_scheme_id_idx ON payment (scheme_id);
CREATE INDEX eucap_entry_time_id_idx ON payment (time_id);
CREATE INDEX eucap_entry_recipient_id_idx ON payment (recipient_id);
CREATE INDEX eucap_entry_country_id_idx ON payment (country_id);
CREATE INDEX eucap_entry_id_idx ON payment (id);

CREATE INDEX eucap_recipient_id_idx ON recipient (id);
CREATE INDEX eucap_recipient_name_idx ON recipient (name);
CREATE INDEX eucap_recipient_nameid_idx ON recipient (id, name);

CREATE INDEX eucap_scheme_id_idx ON scheme (id);
CREATE INDEX eucap_scheme_name_idx ON scheme (name);
CREATE INDEX eucap_scheme_nameid_idx ON scheme (id, name);

CREATE INDEX eucap_country_id_idx ON country (id);
CREATE INDEX eucap_country_name_idx ON country (name);
CREATE INDEX eucap_country_nameid_idx ON country (id, name);

CREATE INDEX eucap_time_id_idx ON time (id);

ALTER TABLE payment RENAME TO "eu-cap__entry";
ALTER TABLE scheme RENAME TO "eu-cap__scheme";
ALTER TABLE time RENAME TO "eu-cap__time";
ALTER TABLE recipient RENAME TO "eu-cap__recipient";

VACUUM FULL VERBOSE ANALYZE;


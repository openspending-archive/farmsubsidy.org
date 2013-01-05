DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS recipient;
DROP TABLE IF EXISTS scheme;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS time;

CREATE TABLE payment (
  "paymentId" INTEGER NOT NULL,
  "globalPaymentId"     VARCHAR(250),
  "globalRecipientId" VARCHAR(250) NOT NULL,
  "globalRecipientIdx" VARCHAR(250) NOT NULL,
  "globalSchemeId" VARCHAR(250) NOT NULL,
  "amountEuro" VARCHAR(250),
  "amountNationalCurrency" VARCHAR(250),
  "year" INTEGER NOT NULL,
  "countryPayment" VARCHAR(250) NOT NULL
);

CREATE TABLE recipient (
  "recipientId" INTEGER NOT NULL, 
  "recipientIdx" INTEGER NOT NULL, 
  "globalRecipientId" VARCHAR(2000) NOT NULL, 
  "globalRecipientIdx" VARCHAR(2000) NOT NULL, 
  name VARCHAR(2000),
  address1 VARCHAR(2000), 
  address2 VARCHAR(2000), 
  zipcode VARCHAR(2000), 
  town VARCHAR(2000), 
  "countryRecipient" VARCHAR(2000), 
  "countryPayment" VARCHAR(2000) NOT NULL, 
  geo1 VARCHAR(2000), 
  geo2 VARCHAR(2000), 
  geo3 VARCHAR(2000), 
  geo4 VARCHAR(2000), 
  "geo1NationalLanguage" VARCHAR(2000), 
  "geo2NationalLanguage" VARCHAR(2000),
  "geo3NationalLanguage" VARCHAR(2000), 
  "geo4NationalLanguage" VARCHAR(2000), 
  lat VARCHAR(2000), 
  lng VARCHAR(2000)
);

CREATE TABLE scheme (
  "GlobalSchemeId" VARCHAR(100),
  "nameNationalLanguage" VARCHAR(2000), 
  "nameEnglish" VARCHAR(2000), 
  "budgetlines8Digit" VARCHAR(2000), 
  "countryPayment" VARCHAR(2000)
);

CREATE TABLE country (
  "label" VARCHAR(2000),
  "code" VARCHAR(3)
);

CREATE TABLE time (
    id SERIAL,
    week text,
    yearmonth text,
    name text,
    year text,
    intyear int,
    month text,
    quarter text,
    day text,
    label text
);

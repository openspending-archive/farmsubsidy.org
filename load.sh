#!/bin/bash

WD=`pwd`
DATA=$WD/data
DB="farmsubsidy_etl"
SQL="psql $DB"

$SQL -f schema.sql
$SQL -c "COPY country FROM '$WD/countries.csv' WITH CSV DELIMITER ',' QUOTE '\"' HEADER ENCODING 'Utf-8';"

for COUNTRY in "AT" "BE" "BG" "CY" "CZ" "DE" "DK" "EE" "ES" "FI" "GR" "HU" "IE" "IT" "LT" "LU" "LV" "MT" "NL" "PL" "PT" "RO" "SE" "SK" "SL"; do
  unzip -n -j -d $DATA/$COUNTRY $DATA/$COUNTRY.zip
  for FN in "payment.txt" "payment1.txt" "payment2.txt"; do
    if [ -f $DATA/$COUNTRY/$FN ]; then
      $SQL -c "COPY payment FROM '$DATA/$COUNTRY/$FN' WITH CSV DELIMITER ';' QUOTE '\"' HEADER ENCODING 'Utf-8';"
    fi
  done
  $SQL -c "COPY recipient FROM '$DATA/$COUNTRY/recipient.txt' WITH CSV DELIMITER ';' QUOTE '\"' HEADER ENCODING 'Utf-8';"
  for FN in "scheme.txt" "schemes.txt"; do
    if [ -f $DATA/$COUNTRY/$FN ] && [ $COUNTRY != "DK" ]; then
      $SQL -c "COPY scheme FROM '$DATA/$COUNTRY/$FN' WITH CSV DELIMITER ';' QUOTE '\"' HEADER ENCODING 'Utf-8';"
    fi
  done
done

$SQL -c "ALTER TABLE recipient ADD COLUMN total VARCHAR(2000);"
$SQL -c "ALTER TABLE scheme ADD COLUMN total VARCHAR(2000);"
$SQL -c "COPY scheme FROM '$DATA/DK/scheme.txt' WITH CSV DELIMITER ';' QUOTE '\"' HEADER ENCODING 'Utf-8';"

unzip -n -d $DATA $DATA/FR.zip
$SQL -c "COPY payment FROM '$DATA/FR/payment.csv' WITH CSV DELIMITER ';' QUOTE '\"' ENCODING 'Utf-8';"
$SQL -c "COPY recipient FROM '$DATA/FR/recipient.csv' WITH CSV DELIMITER ';' QUOTE '\"' ENCODING 'Utf-8';"
$SQL -c "COPY scheme FROM '$DATA/FR/scheme.csv' WITH CSV DELIMITER ';' QUOTE '\"' ENCODING 'Utf-8';"

unzip -n -d $DATA $DATA/GB.zip
$SQL -c "COPY payment FROM '$DATA/GB/payment.csv' WITH CSV DELIMITER ';' QUOTE '\"' ENCODING 'Utf-8';"
$SQL -c "COPY recipient FROM '$DATA/GB/recipient.csv' WITH CSV DELIMITER ';' QUOTE '\"' ENCODING 'Utf-8';"
$SQL -c "COPY scheme FROM '$DATA/GB/scheme.csv' WITH CSV DELIMITER ';' QUOTE '\"' ENCODING 'Utf-8';"


$SQL -f keys.sql
$SQL -f process.sql
$SQL -f final_optimize.sql

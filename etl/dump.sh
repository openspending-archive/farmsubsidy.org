#!/bin/bash

pg_dump -c -t "eu-cap__*" farmsubsidy_etl >eu-cap.sql 


#!/bin/bash

if [[ -z "$OPENSPENDING_AUTH" ]]; then
  echo "Please set \$OPENSPENDING_AUTH to user:password"
  exit
fi

curl -X POST -o /dev/null -u $OPENSPENDING_AUTH --data-urlencode mapping@mapping.json http://openspending.org/eu-cap/editor/dimensions 

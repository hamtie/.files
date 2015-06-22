#!/bin/bash
set -e

if [ $# -eq 0 ]
  then
    echo "Company name provided"
    exit 1
fi
COMPANY=$1
OLD_COPYRIGHT="Copyright 2014 $COMPANY, Inc."
NEW_COPYRIGHT="Copyright 2015 $COMPANY, Inc."

find . -type f ! -path "./tmp/*" ! -path "./log/*" ! -path "./db/*" ! -path "./target/*" ! -path "./*.log" ! -path "./.*" -exec sed -r -i'' -e "s/$OLD_COPYRIGHT/$NEW_COPYRIGHT/g" {} \;

exit 0

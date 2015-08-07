#!/usr/bin/env bash

# Usage ./replace.sh <company-name>

set -e

if [ -z "$1" ]
  then
    echo "Company name provided"
    exit 1
fi

COMPANY=$1
OLD_COPYRIGHT="Copyright 2014 $COMPANY, Inc."
NEW_COPYRIGHT="Copyright 2015 $COMPANY, Inc."

IGNORE_DIRS=('./tmp/*' './db/*' './target/*' './*.log' './.*')

CMD="find . -type f $(printf "! -path \"%s\" " "${IGNORE_DIRS[@]}") -exec sed -r -i'' -e \"s/$OLD_COPYRIGHT/$NEW_COPYRIGHT/g\" {} \;"
echo -e "Running:"
echo -e $CMD
eval $CMD

#find . -type f ! -path "./tmp/*" ! -path "./log/*" ! -path "./db/*" ! -path "./target/*" ! -path "./*.log" ! -path "./.*" -exec sed -r -i'' -e "s/$OLD_COPYRIGHT/$NEW_COPYRIGHT/g" {} \;

exit 0

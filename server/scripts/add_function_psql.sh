#!/bin/sh

if [ $# != 2 ]; then
    echo "please enter a user and DB name"
    exit 1
fi

export USER_NAME=$1
export DB_NAME=$2

psql \
    -X \
    -U $USER_NAME \
    -h localhost \
    -f ./function.sql \
    --echo-all \
    --set AUTOCOMMIT=off \
    --set ON_ERROR_STOP=on \
    $DB_NAME

export psql_exit_status=$?

if [ $psql_exit_status != 0 ]; then
    echo "psql failed while trying to run this sql script" 1>&2
    exit $psql_exit_status
fi

echo "sql script successful"
exit 0
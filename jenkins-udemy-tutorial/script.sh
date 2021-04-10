#!/bin/bash

#automate db container backup


# variables
DATE=$(date +%H-%M-%S)
DB_USER=$1
DB_HOST=$2
DB_PASSWORD=$3
DB_NAME=$4
AWS_ACCESS_KEY=$5
AWS_SECRET_KEY=$6

mysqldump -u $DB_USER -h $DB_HOST -p$DB_PASSWORD $DB_NAME > /tmp/testdb-dump-$DATE.sql && \

export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_KEY && \

echo "Takind testdb backup in aws s3" && \

aws s3 cp /tmp/testdb-dump-$DATE.sql s3://collabora-online-backup-raghib/db-backup/testdb-dump-$DATE.sql


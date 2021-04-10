#!/bin/bash

echo '**********************************'
echo 'copy *.jar file to build directory'
echo '**********************************'

cp -f java-app/target/my-app-1.0-SNAPSHOT.jar jenk/build/

echo "**********************************************"
echo "***** Building docker image for java-jdk *****"
echo "**********************************************"

cd jenk/build && docker-compose -f docker-compose-build.yml build --no-cache


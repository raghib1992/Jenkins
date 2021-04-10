## to fing the location of the downloaded images in docker 
docker info | grep -i root  

## to check the storage docker is using 
sudo du -sh <storage location path>

## to spin up conatiner from compose file 
docker-compose up -d

## check the log of conatiner
docker logs -f <conatiner-name>


## to stop all container through compose file
docker-compose stop

## to start all conatiner through compose file
docker-compose start 

## to start particular conatainer from compose file 
docker-compose restart <container-name>

## to delet docker container 
docker-compose down
##############################################
##
# Pipeline
##
# Install pipeline plugins

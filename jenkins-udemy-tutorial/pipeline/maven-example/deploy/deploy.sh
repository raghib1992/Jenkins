#!/bin/bash

echo maven-project > /tmp/.auth
echo $BUILD_TAG >> /tmp/.auth
echo $PASS >> /tmp/.auth

scp -i $SSH_KEY /tmp/.auth ec2-user@13.232.172.96:/tmp/.aut
scp -i $SSH_KEY publish ec2-user@13.232.172.96:/tmp/publish
ssh -i $SSH_KEY ec2-user@13.232.172.96 "/tmp/publish"

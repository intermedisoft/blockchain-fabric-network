#!/bin/bash
docker-compose -f docker-compose-phr.yaml down
rm -rf /var/hyperledger/*
docker-compose -f docker-compose-phr.yaml up -d
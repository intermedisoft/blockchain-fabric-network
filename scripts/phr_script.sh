#!/bin/bash

docker exec -it peer0.phr.ehrblox.com peer channel create -o orderer.ehrblox.com:7050 -c depachannel -f /var/hyperledger/channel-artifacts/channel.tx --tls --cafile /var/hyperledger/crypto-config/ordererOrganizations/ehrblox.com/orderers/orderer.ehrblox.com/msp/tlscacerts/tlsca.ehrblox.com-cert.pem --logging-level debug
docker exec -it peer0.phr.ehrblox.com peer channel update -o orderer.ehrblox.com:7050 -c depachannel -f /var/hyperledger/channel-artifacts/PHRBloxMSPanchors.tx --tls true --cafile /var/hyperledger/crypto-config/ordererOrganizations/ehrblox.com/orderers/orderer.ehrblox.com/msp/tlscacerts/tlsca.ehrblox.com-cert.pem
docker exec -it peer0.phr.ehrblox.com mv /opt/gopath/src/github.com/hyperledger/fabric/peer/depachannel.block /var/hyperledger/channel-artifacts-write
docker exec -it peer0.phr.ehrblox.com peer channel join -b /var/hyperledger/channel-artifacts-write/depachannel.block
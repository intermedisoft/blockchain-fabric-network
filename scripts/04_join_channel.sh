#!/bin/bash
export ORDERER_CA=/var/hyperledger/crypto-config/ordererOrganizations/ehrblox.com/orderers/orderer.ehrblox.com/msp/tlscacerts/tlsca.ehrblox.com-cert.pem
echo peer channel create -o orderer.ehrblox.com:7050 -c DepaChannel -f /var/hyperledger/channel-artifacts/channel.tx --tls true --cafile $ORDERER_CA
echo peer channel update -o orderer.ehrblox.com:7050 -c DepaChannel -f /var/hyperledger/channel-artifacts/PHRBloxMSPanchors.tx --tls true --cafile $ORDERER_CA 
echo peer channel update -o orderer.ehrblox.com:7050 -c DepaChannel -f /var/hyperledger/channel-artifacts/BPKMSPanchors.tx --tls true --cafile $ORDERER_CA 
echo peer channel update -o orderer.ehrblox.com:7050 -c DepaChannel -f /var/hyperledger/channel-artifacts/PensookMSPanchors.tx --tls true --cafile $ORDERER_CA 

echo peer channel join -b DepaChannel.block 
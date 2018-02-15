#!/bin/bash
export ORDERER_CA=/var/hyperledger/crypto-config/ordererOrganizations/ehrblox.com/orderers/orderer.ehrblox.com/msp/tlscacerts/tlsca.ehrblox.com-cert.pem

echo ==== for PHR node
echo docker exec -it peer0.phr.ehrblox.com peer channel create -o orderer.ehrblox.com:7050 -c depachannel -f /var/hyperledger/channel-artifacts/channel.tx --tls --cafile /var/hyperledger/crypto-config/ordererOrganizations/ehrblox.com/orderers/orderer.ehrblox.com/msp/tlscacerts/tlsca.ehrblox.com-cert.pem --logging-level debug
echo docker exec -it peer0.phr.ehrblox.com peer channel update -o orderer.ehrblox.com:7050 -c depachannel -f /var/hyperledger/channel-artifacts/PHRBloxMSPanchors.tx --tls true --cafile $ORDERER_CA 
echo docker exec -it peer0.phr.ehrblox.com mv /opt/gopath/src/github.com/hyperledger/fabric/peer/depachannel.block /var/hyperledger/channel-artifacts-write
echo docker exec -it peer0.phr.ehrblox.com peer channel join -b /var/hyperledger/channel-artifacts-write/depachannel.block

echo ==== for Pensook node
echo docker exec -it peer0.pensook.ehrblox.com peer channel update -o orderer.ehrblox.com:7050 -c depachannel -f /var/hyperledger/channel-artifacts/PensookMSPanchors.tx --tls true --cafile $ORDERER_CA 
echo docker exec -it peer0.pensook.ehrblox.com peer channel join -b /var/hyperledger/channel-artifacts/depachannel.block

echo ==== for BPK node
echo docker exec -it peer0.bpk.ehrblox.com peer channel update -o orderer.ehrblox.com:7050 -c depachannel -f /var/hyperledger/channel-artifacts/BPKMSPanchors.tx --tls true --cafile $ORDERER_CA 
echo docker exec -it peer0.bpk.ehrblox.com peer channel join -b /var/hyperledger/channel-artifacts/depachannel.block
echo
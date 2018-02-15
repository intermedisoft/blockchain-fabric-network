#!/bin/bash
export FABRIC_CFG_PATH=$PWD

./bin/cryptogen generate --config=./crypto-config.yaml
./bin/configtxgen -profile DepaOrdererGenesis -outputBlock ./channel-artifacts/genesis.block
./bin/configtxgen -profile DepaChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID depachannel
./bin/configtxgen -profile DepaChannel -outputAnchorPeersUpdate ./channel-artifacts/PHRBloxMSPanchors.tx -channelID depachannel -asOrg PHRBloxMSP
./bin/configtxgen -profile DepaChannel -outputAnchorPeersUpdate ./channel-artifacts/BPKMSPanchors.tx -channelID depachannel -asOrg BPKMSP
./bin/configtxgen -profile DepaChannel -outputAnchorPeersUpdate ./channel-artifacts/PensookMSPanchors.tx -channelID depachannel -asOrg PensookMSP


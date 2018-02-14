#!/bin/bash
export FABRIC_CFG_PATH=$PWD

./bin/cryptogen generate --config=./crypto-config.yaml
./bin/configtxgen -profile DepaOrdererGenesis -outputBlock ./channel-artifacts/genesis.block
./bin/configtxgen -profile DepaChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID DepaChannel
./bin/configtxgen -profile DepaChannel -outputAnchorPeersUpdate ./channel-artifacts/PHRBloxMSPanchors.tx -channelID DepaChannel -asOrg PHRBloxMSP
./bin/configtxgen -profile DepaChannel -outputAnchorPeersUpdate ./channel-artifacts/BPKMSPanchors.tx -channelID DepaChannel -asOrg BPKMSP
./bin/configtxgen -profile DepaChannel -outputAnchorPeersUpdate ./channel-artifacts/PensookMSPanchors.tx -channelID DepaChannel -asOrg PensookMSP


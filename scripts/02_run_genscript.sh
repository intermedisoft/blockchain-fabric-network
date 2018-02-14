#!/bin/bash
export FABRIC_CFG_PATH=$PWD

./bin/cryptogen generate --config=./crypto-config.yaml
./bin/configtxgen -profile DepaOrdererGenesis -outputBlock ./channel-artifacts/genesis.block
./bin/configtxgen -profile depa_channel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID depa_channel
./bin/configtxgen -profile depa_channel -outputAnchorPeersUpdate ./channel-artifacts/PHRBloxMSPanchors.tx -channelID depa_channel -asOrg PHRBloxMSP
./bin/configtxgen -profile depa_channel -outputAnchorPeersUpdate ./channel-artifacts/BPKMSPanchors.tx -channelID depa_channel -asOrg BPKMSP
./bin/configtxgen -profile depa_channel -outputAnchorPeersUpdate ./channel-artifacts/PensookMSPanchors.tx -channelID depa_channel -asOrg PensookMSP


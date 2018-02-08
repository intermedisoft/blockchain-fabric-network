#!/bin/bash
export FABRIC_CFG_PATH=$PWD
./bin/cryptogen generate --config=./crypto-config.yaml
./bin/configtxgen -profile DepaOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

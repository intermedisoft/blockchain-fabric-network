#/bin/bash
./bin/cryptogen generate --config=./crypto-config.yaml
export FABRIC_CFG_PATH=$PWD
./bin/configtxgen -profile DepaOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

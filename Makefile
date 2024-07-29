-include .env


.PHONY: all deploy anvil


            

NETWORK_ARGS := --rpc-url http://127.0.0.1:8545 --private-key $(ANVIL_KEY) --broadcast
deploy :; @forge script script/DeployToken.s.sol:DeployToken $(NETWORK_ARGS)

#switching network
ifeq ($(findstring --network sepolia,$(ARGS)), --network sepolia)
        NETWORK_ARGS := --fork-url $(SEPOLIA_RPC) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif		

anvil:; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1


test:; forge test 
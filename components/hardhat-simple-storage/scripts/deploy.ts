import { ethers, run, network } from "hardhat"

async function main() {
  const SimpleStorageFactory = await ethers.getContractFactory(
    "SimpleStorage"
  )
  console.log("Deploying contract...")
  const simpleStorage = await SimpleStorageFactory.deploy()
  await simpleStorage.getDeployedCode()
  console.log(`Deployed contract to: ${simpleStorage.target}`)

  // console.log(network.config)
  if (network.config.chainId === 11155111 && process.env.ETHER_SCAN_API_KEY) {
    console.log("Waiting for 6 block tx...")
    await simpleStorage.deploymentTransaction()?.wait(6)
    await verify(simpleStorage.target, [])
  }

  const currentValue = await simpleStorage.retrieve()
  console.log(`Current value is: ${currentValue}`)

  // Update the current value
  const transactionResponse = await simpleStorage.store(7)
  await transactionResponse.wait(1)
  const updatedValue = await simpleStorage.retrieve()
  console.log(`Updated Value is: ${updatedValue}`)
}

async function verify(contractAddress: any, args: any) {
  console.log("Verifying contract....")
  try {
  await run("verify:verify", {
    address: contractAddress,
    constructorArguments: args,
  })
  } catch (e: any) {
    if (e.message.toLowerCase().includes("already verified")) {
      console.log("Already verfied")
    } else {
      console.log(e)
    }
  }
}

main().then(() => process.exit(0)).catch((error) => {
    console.error(error)
    process.exit(1)
})
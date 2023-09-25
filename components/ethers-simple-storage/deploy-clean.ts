const ethers = require("ethers")
const fs = require('fs-extra')
require("dotenv").config() // This is an example dotenv file with fake information

async function main() {
    /* This is the information we need to prepare our contract for deployment */
    let provider = new ethers.JsonRpcProvider(process.env.RPC_URL) 
    

    const wallet = new ethers.Wallet( // Using metamask test key with newly generated wallet
        process.env.PRIVATE_KEY,
        provider,
    )

    const abi = fs.readFileSync("./compiledContracts/components_ethers-simple-storage_SimpleStorage_sol_SimpleStorage.abi", "utf8")
    const binary = fs.readFileSync("./compiledContracts/components_ethers-simple-storage_SimpleStorage_sol_SimpleStorage.bin", "utf8")
    const contractFactory = new ethers.ContractFactory(abi, binary, wallet)

    /* These are the lines of code we need to deploy a contract to the block chain */
    console.log("deploying, plz wait...")
    const contract = await contractFactory.deploy()
    await contract.deploymentTransaction().wait(1)
    console.log(`Contract Address: ${contract.target}`)

    /* Accessing our contract after deploying it. */
    const currentFavoriteNumber = await contract.retrieve(); 
    console.log(`Current favorite number: ${currentFavoriteNumber}`)
    const transactionResponse = await contract.store("7")
    const transactionReceipt = await transactionResponse.wait(1)
    // console.log(`What is in transactionReceipt?`)
    // console.log(transactionReceipt)
    const updatedFavoriteNumber = await contract.retrieve()
    console.log(`Updated favorite number: ${updatedFavoriteNumber}`)
}

main().then(() => process.exit(0)).catch((error) => {
    console.error(error)
    process.exit(1)
})
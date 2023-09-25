const ethers = require("ethers")
const fs = require('fs-extra')
require("dotenv").config()

async function main() {

    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY)
    const encryptedJsonKey = await wallet.encrypt(
        process.env.PRIVATE_KEY_PASSWORD
        ) // 
    console.log(encryptedJsonKey)
    fs.writeFileSync("./.encryptedKey.json", encryptedJsonKey) // Once we run this line, we would add the file that has been created to our gitignore
}                                                              // In this case, we would add our encryptedKey.json file to the gitignore.

main().then(() => process.exit(0)).catch((error) => {
    console.error(error)
    process.exit(1)
})
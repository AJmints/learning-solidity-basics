async function mainWithdraw() {
    const { deployer } = await getNamedAccounts()
    const fundMe = await ethers.getContractAt("FundMe", deployer)
    console.log("Funding...")
    const transactionResponse = await fundMe.withdraw()
    await transactionResponse.wait(1)
    console.log("Got it back!")
}

mainWithdraw().then(() => process.exit(0)).catch((error) => {
    console.log(error)
    process.exit(1)
})
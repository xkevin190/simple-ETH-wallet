//
//  EthWalletTest.swift
//  singleEthWalletTests
//
//  Created by Kevin Velasco on 31/3/24.
//
import XCTest
import Foundation
@testable import singleEthWallet

class EthereumWalletTests: XCTestCase {
    
    var mockMnemonic: String = "release quantum regret breeze tobacco lazy when enrich old drum latin tag yard estate opinion illegal between green borrow alpha quit pride economy actual"
    
    var mockNft = [NFT(name: "Mock NFT", description: "Mock description", image: "Mock image")]
    
    var mockTransaction: [Transaction] = [Transaction(blockNumber: "123456",
                                                      timeStamp: "1635632743",
                                                      hash: "0xabcdef123456",
                                                      nonce: "0",
                                                      blockHash:  "0x123456abcdef",
                                                      transactionIndex:  "0",
                                                      from: "0x123456",
                                                      to: "0xabcdef",
                                                      value: "10000000000000000",
                                                      gas: "21000",
                                                      gasPrice: "1000000000",
                                                      isError:  "0",
                                                      txreceipt_status: "1",
                                                      input: "0x",
                                                      contractAddress:  "",
                                                      cumulativeGasUsed:  "21000",
                                                      gasUsed: "21000",
                                                      confirmations:  "123456",
                                                      methodId: "",
                                                      functionName: "")]
    
    
    func testUpdateBalance() {
        var wallet = EthereumWallet(address: "test_address", balance: 100.0, privateKey: Data(), transactions: [], NFTs: [])
        
        // Update balance
        wallet.updateBalance(newBalance: 200.0)
        
        XCTAssertEqual(wallet.balance, 200.0)
    }
    
    func testUpdateTransaction() {
        var wallet = EthereumWallet(address: "test_address", balance: 100.0, privateKey: Data(), transactions: [], NFTs: [])
        
        // Update transactions
        wallet.updateTransaction(newTransactions: mockTransaction)
        
        XCTAssertEqual(wallet.transaction, mockTransaction)
    }
    
    func testUpdateNFTs() {
        var wallet = EthereumWallet(address: "test_address", balance: 100.0, privateKey: Data(), transactions: [], NFTs: [])
        
        let mockNFT1 = NFT(name: "NFT 1", description: "Description of NFT 1", image: "image_url_1")
        let mockNFT2 = NFT(name: "NFT 2", description: "Description of NFT 2", image: "image_url_2")
        let mockNFT3 = NFT(name: "NFT 3", description: "Description of NFT 3", image: "image_url_3")
        
        let newNFTs: [NFT] = [mockNFT1, mockNFT2, mockNFT3]
        
        // Update NFTs
        wallet.updateNFTs(newNfts: newNFTs)
        
        XCTAssertTrue(newNFTs.count == wallet.NFTs.count)
    }
    
    
    func testCreateMnemonics() {
        let mnemonics = EthereumWallet.createMnemonics()
        XCTAssertNotNil(mnemonics, "Mnemonic generation failed")
    }
    
    func testGenerateBIT32Keystore() {
        var testAddress = "0xC16E9B216E57d5B72fB38dAc3e64A28B6DC06528"
        // Assuming you have a valid mnemonic
        let keystore = EthereumWallet.GenerateBIT32Keystore(tMnemonics: mockMnemonic)
        
        
        XCTAssertNotNil(keystore, "BIP32 keystor2e generation failed")
        
        let validKeystore = keystore!
        let address = EthereumWallet.getWalletAddress(tempAddress: validKeystore)
        XCTAssertNotNil(address, "Wallet address retrieval failed")
        XCTAssertEqual(testAddress, address?.address)
        
    }
    
    
    func testReadNFTContract() async {
        // Mock data and dependencies
        let mockData: [ERC721Transaction] = [
            ERC721Transaction(
                blockNumber: "5595362",
                timeStamp: "1711844964",
                hash: "0x7496115f0e4e025ca6b8e27c2abf417297f50206e3efa2ab7796a182568bb0af",
                nonce: "1",
                blockHash: "0x2079442264f772ab915e9f757996c72770f175b887894f4dee7c12b3f2f01e68",
                from: "0x0000000000000000000000000000000000000000",
                contractAddress: "0xe6a150c75c6423e8573010a4504a099dd015c7db",
                to: "0xc16e9b216e57d5b72fb38dac3e64a28b6dc06528",
                tokenID: "1",
                tokenName: "Kevin NFT",
                tokenSymbol: "KEV",
                tokenDecimal: "0",
                transactionIndex: "19",
                gas: "145641",
                gasPrice: "1500264487",
                gasUsed: "144485",
                cumulativeGasUsed: "2329925",
                input: "deprecated",
                confirmations: "2193"
            ),
        ] // Provide mock ERC721Transaction array
        let mockHttpRequest = MockHttpRequest() // Create a mock implementation of HttpRequest
        
       
        
        // Call the asynchronous function
        let result = await EthereumWallet.ReadNFTContract(data: mockData, httpRequest: mockHttpRequest)
        
        XCTAssertNotEqual(result, [])
        
    }
    
    
}


class MockHttpRequest: HttpRequest {
    func getNFT(url: URL) async throws -> NFT? {
        // Implement mock behavior for getNFT if needed
        return NFT(name: "Mock NFT", description: "Mock description", image: "Mock image")
    }
    
    // Implement other methods if needed
}

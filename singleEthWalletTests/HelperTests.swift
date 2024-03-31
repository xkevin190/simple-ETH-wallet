//
//  HelperTests.swift
//  singleEthWalletTests
//
//  Created by Kevin Velasco on 31/3/24.
//

import Foundation


import XCTest
@testable import singleEthWallet // Import your app module

class MockIdenticon {
    static func icon(from name: String, size: CGSize) -> UIImage? {
        // Return a dummy image for testing purposes
        return UIImage(named: "mockIdenticon")
    }
}


class HelpersTests: XCTestCase {

    func testParseAmount() {
            // Given
            let amount1: Double = 1.234e18 // 1.234e18 wei
            let amount2: Double = 0.0 // Zero amount
            let amount3: Double = -1.0 // Negative amount

            // When
            let result1 = Helpers.parseAmount(amount: amount1)
            let result2 = Helpers.parseAmount(amount: amount2)
            let result3 = Helpers.parseAmount(amount: amount3)

            // Then
            XCTAssertEqual(result1, "1.234", "Parsed amount should be '1.234'")
            XCTAssertEqual(result2, "0.0", "Parsed amount should be '0.0'")
    }


    func testParseNFTUrl() {
        // Given
        let urlString1 = "https://example.com/image.jpg"
        let urlString2 = "ipfs://QmVmBQ4orpncsnFkueGWdtjZ9zA98P5atmeJ49EzjcxfJv/1"

        // When
        let result1 = Helpers.parseNFTUrl(urlString: urlString1)
        let result2 = Helpers.parseNFTUrl(urlString: urlString2)

        // Then
        XCTAssertEqual(result1, urlString1, "Parsed URL should be unchanged for non-IPFS URLs")
        XCTAssertEqual(result2, "https://gateway.ipfs.chaingpt.dev/ipfs/QmVmBQ4orpncsnFkueGWdtjZ9zA98P5atmeJ49EzjcxfJv/1", "Parsed URL should be updated for IPFS URLs")
    }
    
    
    func testSetAndGetStorageValue() {
            // Given
            let key = "testKey"
            let value = "testValue"

            // When
            
            Helpers.setStorageValue(value: value, key: key)
            let retrievedValue: String? = Helpers.getStorageValue(type: String.self, key: key)

            // Then
            XCTAssertEqual(retrievedValue, value, "Retrieved value should be equal to the stored value")
    }
    
    func testSetAndGetStorageValueForERC721Transaction() {
            // Given
            let key = "ERC721TransactionKey"
            let transaction = ERC721Transaction(blockNumber: "123", timeStamp: "456", hash: "789", nonce: "1", blockHash: "abc", from: "sender", contractAddress: "contract", to: "recipient", tokenID: "tokenID", tokenName: "tokenName", tokenSymbol: "tokenSymbol", tokenDecimal: "tokenDecimal", transactionIndex: "0", gas: "1000", gasPrice: "2000", gasUsed: "3000", cumulativeGasUsed: "4000", input: "input", confirmations: "5")
            
            // When
            Helpers.setStorageValue(value: transaction, key: key)
            let retrievedTransaction: ERC721Transaction? = Helpers.getStorageValue(type: ERC721Transaction.self, key: key)

            // Then
            XCTAssertNotNil(retrievedTransaction, "Retrieved transaction should not be nil")
            XCTAssertEqual(retrievedTransaction?.hash, transaction.hash, "Retrieved transaction's hash should match the original transaction's hash")
            // Add more specific assertions for other properties if needed
        }

        func testSetAndGetStorageValueForTransaction() {
            // Given
            let key = "TransactionKey"
            let transaction = Transaction(blockNumber: "123", timeStamp: "456", hash: "789", nonce: "1", blockHash: "abc", transactionIndex: "0", from: "sender", to: "recipient", value: "1000", gas: "2000", gasPrice: "3000", isError: "0", txreceipt_status: "1", input: "input", contractAddress: "contract", cumulativeGasUsed: "4000", gasUsed: "5000", confirmations: "5", methodId: "methodId", functionName: "functionName")
            
            // When
            Helpers.setStorageValue(value: transaction, key: key)
            let retrievedTransaction: Transaction? = Helpers.getStorageValue(type: Transaction.self, key: key)

            // Then
            XCTAssertNotNil(retrievedTransaction, "Retrieved transaction should not be nil")
            XCTAssertEqual(retrievedTransaction?.hash, transaction.hash, "Retrieved transaction's hash should match the original transaction's hash")
            // Add more specific assertions for other properties if needed
        }

        func testSetAndGetStorageValueForNFT() {
            // Given
            let key = "NFTKey"
            let nft = NFT(name: "NFT Name", description: "NFT Description", image: "NFT Image URL")
            
            // When
            Helpers.setStorageValue(value: nft, key: key)
            let retrievedNFT: NFT? = Helpers.getStorageValue(type: NFT.self, key: key)

            // Then
            XCTAssertNotNil(retrievedNFT, "Retrieved NFT should not be nil")
            XCTAssertEqual(retrievedNFT?.name, nft.name, "Retrieved NFT's name should match the original NFT's name")
            // Add more specific assertions for other properties if needed
        }



}

//
//  KeychainTest.swift
//  singleEthWalletTests
//
//  Created by Kevin Velasco on 31/3/24.
//

import Foundation

import XCTest
@testable import singleEthWallet // Import your app module

class KeychainModuleTests: XCTestCase {

    func testSaveAndLoadData() {
        // Given
        let key = "testKey"
        let data = "testData"

        // When
        keychainModule.save(key: key, data: data)
        let loadedData = keychainModule.load(key: key)

        // Then
        XCTAssertEqual(loadedData, data, "Loaded data should be equal to the saved data")
    }

    func testDeleteData() {
        // Given
        let key = "testKey"
        let data = "testData"
        keychainModule.save(key: key, data: data)

        // When
        keychainModule.delete(key: key)
        let loadedData = keychainModule.load(key: key)

        // Then
        XCTAssertNil(loadedData, "Loaded data should be nil after deletion")
    }

    // Add more test cases for edge cases and error handling if needed

}

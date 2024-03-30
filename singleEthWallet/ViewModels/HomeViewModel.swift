//
//  HomeViewModel.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 30/3/24.
//

import Foundation


enum TabSelect {
    case activity
    case nfts
}

class HomeViewModel: ObservableObject {
    @Published var tabSelected = TabSelect.activity
    
}

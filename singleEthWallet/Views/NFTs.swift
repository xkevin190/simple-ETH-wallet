//
//  NFTs.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 30/3/24.
//

import SwiftUI

struct NFTs: View {
    var carSize = UIScreen.main.bounds.width * 0.4;
    var nfts: [NFT]
    
    
    init(nfts: [NFT]){
        self.nfts = nfts
    }
    
    var body: some View {
        ZStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: carSize))]) {
                
                ForEach(Array(nfts.enumerated()), id: \.offset) { _, ntf in
                    
                    VStack {
                        AsyncImage(
                            url: URL(string: ntf.image),
                            content: { image in
                                image.resizable()
                                    .frame(maxWidth: 200, maxHeight: 100)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )

                        Divider().background(.white).padding(.top, -5)
                        VStack(alignment: .leading) {
                            Text(ntf.name)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding(.top, -10)
                                .padding(.bottom, 10)

                        }
                        
                    }
                    .frame(width: carSize)
                    .background(Color(UIColor.box))
                    .cornerRadius(10)
                }
                
            }
            
        }
    }
}

#Preview {
    NFTs(nfts: [])
}

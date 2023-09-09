//
//  ContentView.swift
//  CoinPrice
//
//  Created by Дмитрий Волынкин on 08.09.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CoinsViewModel()
    var body: some View {
        List {
            ForEach(viewModel.coins) { coin in
                HStack {
//                    Text("\(coin.marketCapRank)")
//                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading) {
                        Text(coin.name)
                            .font(.subheadline)
                        
                        Text(coin.symbol)
                    }
                }
                .font(.footnote)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

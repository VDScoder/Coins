//
//  CoinsViewModel.swift
//  CoinPrice
//
//  Created by Дмитрий Волынкин on 08.09.2023.
//

import Foundation

class CoinsViewModel: ObservableObject {
   
    @Published var coins = [Coin]()
    
    private let service = CoinDataService()
    
    init() {
        fetchCoins()
    }
    
    func fetchCoins() {
        service.fetchCoins { coins in
            DispatchQueue.main.async {
                self.coins = coins
            }
        }
    }
    
    
}

//
//  CoinDataService.swift
//  CoinPrice
//
//  Created by Дмитрий Волынкин on 08.09.2023.
//

import Foundation

class CoinDataService {
    
    private var urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=24h&locale=ru"
    
    func fetchCoins(complition: @escaping([Coin]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            
            guard let coins = try? JSONDecoder().decode([Coin].self, from: data) else { return }
            print("DEBUG: Coins decoded \(coins)")
            
            complition(coins)
        }.resume()
    }
    
    func fetchPrice(coin: String, complition: @escaping(Double) -> Void) {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DEBUG: Failed with error \(error.localizedDescription)")
//                self.errorMessage = error.localizedDescription
                return
            }
                guard let httpResponse = response as? HTTPURLResponse else {
//                    self.errorMessage = "bad HTTP"
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
//                    self.errorMessage = "Failed to featch with status code \(httpResponse.statusCode)"
                    return
                }
                print("DEBUG: Response status code is \(httpResponse.statusCode)")
                
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let value = jsonObject[coin] as? [String: Double] else {
                print("Failed to parce value")
                return
                
            }
            
            guard let price = value["usd"] else { return }
            
                print("Price in Service \(price)")
                complition(price)
            
        }.resume()
    }
    
}

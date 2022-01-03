import Foundation
import Alamofire
import RxSwift

final class CoinDataService {
    
    var allCoins = PublishSubject<[Coin]>()
    
    struct Constants {
        static let url =  "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
    }
    
    init() {
        downloadData()
    }
    
    private func downloadData() {
        guard let url = URL(string: Constants.url) else { return }

        AF.request(url)
            .validate()
            .responseDecodable(of: [Coin].self) { data in
                guard let coins = data.value else { return }
                
                self.allCoins.onNext(coins)
            }
    }
}



import Foundation
import RxSwift

class CoinViewModel {
    private(set) var allCoins = PublishSubject<[Coin]>()
    private(set) var portfolioCoins = PublishSubject<[Coin]>()
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.allCoins.onNext([DeveloperPreview.instance.coin, DeveloperPreview.instance.coin])
            self.allCoins.onCompleted()
        }
    }
}

import Foundation
import RxSwift

final class CoinViewModel {
    private(set) var allCoins = PublishSubject<[Coin]>()
    private(set) var portfolioCoins = PublishSubject<[Coin]>()
    
    private let networkService = CoinDataService()
    
    var disposeBag = DisposeBag()
    
    init() {
        createSubscriber()
    }
    
    private func createSubscriber() {
        networkService.allCoins
            .subscribe { data in
                guard let coins = data.element else { return }
                self.allCoins.onNext(coins)
            }
            .disposed(by: disposeBag)
    }
}

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Live Prices"
        label.font = .preferredFont(forTextStyle: .headline)
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.textColor = .theme.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coinColumnLabel: UILabel = {
        let label = UILabel()
        label.text = "Coin"
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .theme.secondaryText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let holdingsColumnLabel: UILabel = {
        let label = UILabel()
        label.text = "Holdings"
        label.alpha = 0
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .theme.secondaryText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceColumnLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .theme.secondaryText
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coinTableView: UITableView = {
        let table = UITableView()
        table.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let portfolioTableView: UITableView = {
        let table = UITableView()
        table.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
        
    private let leftCircleButton = CircleButtonView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), buttonName: "info")
    private let rightCircleButton = CircleButtonView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), buttonName: "chevron.right")
    
    private let viewModel: CoinViewModel = CoinViewModel()
    
    private var showPortfolio = false
    
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setupConstraints()
        configureAppearance()
        setupTableView()
    }
    
    private func addViews() {
        view.addSubview(headerLabel)
        view.addSubview(leftCircleButton)
        view.addSubview(rightCircleButton)
        view.addSubview(coinColumnLabel)
        view.addSubview(holdingsColumnLabel)
        view.addSubview(priceColumnLabel)
        view.addSubview(portfolioTableView)
        view.addSubview(coinTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        
            leftCircleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            leftCircleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            leftCircleButton.heightAnchor.constraint(equalToConstant: 66),
            leftCircleButton.widthAnchor.constraint(equalToConstant: 66),
            
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerLabel.centerYAnchor.constraint(equalTo: leftCircleButton.centerYAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rightCircleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            rightCircleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            rightCircleButton.heightAnchor.constraint(equalToConstant: 66),
            rightCircleButton.widthAnchor.constraint(equalToConstant: 66),
            
            coinTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coinTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coinTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            coinTableView.topAnchor.constraint(equalTo: holdingsColumnLabel.bottomAnchor, constant: 16),
            
            coinColumnLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            coinColumnLabel.topAnchor.constraint(equalTo: rightCircleButton.bottomAnchor, constant: 10),
            
            priceColumnLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            priceColumnLabel.topAnchor.constraint(equalTo: rightCircleButton.bottomAnchor, constant: 10),
            priceColumnLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3.5),
            
            holdingsColumnLabel.trailingAnchor.constraint(equalTo: priceColumnLabel.leadingAnchor),
            holdingsColumnLabel.topAnchor.constraint(equalTo: rightCircleButton.bottomAnchor, constant: 10),
            
            portfolioTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            portfolioTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            portfolioTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            portfolioTableView.topAnchor.constraint(equalTo: holdingsColumnLabel.bottomAnchor, constant: 16),
        ])
    }
    
    private func setupTableView() {
        viewModel.allCoins.bind(to: coinTableView.rx.items(cellIdentifier: CoinCell.identifier, cellType: CoinCell.self)) { row, item, cell in
            cell.configureAppearance(coin: item)
        }
        .disposed(by: bag)
        
        viewModel.portfolioCoins.bind(to: portfolioTableView.rx.items(cellIdentifier: CoinCell.identifier, cellType: CoinCell.self)) { row, item, cell in
            cell.configureAppearance(coin: item)
        }
        .disposed(by: bag)
    }
    
    private func configureAppearance() {
        view.backgroundColor = .theme.background
        
        navigationController?.isNavigationBarHidden = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chevronWasTapped))
        rightCircleButton.isUserInteractionEnabled = true
        rightCircleButton.addGestureRecognizer(tapGesture)
        
        leftCircleButton.translatesAutoresizingMaskIntoConstraints = false
        rightCircleButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func chevronWasTapped() {
        showPortfolio.toggle()
        
        UIView.animate(withDuration: 0.4) { [weak self] in
            if self!.showPortfolio {
                self?.rightCircleButton.transform = CGAffineTransform(rotationAngle: .pi)
                self?.headerLabel.text = "Portfolio"
                self?.leftCircleButton.imageName = "plus"
                self?.holdingsColumnLabel.alpha = 1
            } else {
                self?.rightCircleButton.transform = CGAffineTransform.identity
                self?.headerLabel.text = "Live Prices"
                self?.leftCircleButton.imageName = "info"
                self?.holdingsColumnLabel.alpha = 0
            }
        }
        
        if showPortfolio {
            UIView.animate(withDuration: 0.7) { [weak self] in
                self?.coinTableView.frame.origin.x -= UIScreen.main.bounds.width
                self?.coinTableView.removeAllConstraints()
                self?.portfolioTableView.frame.origin.x -= UIScreen.main.bounds.width
            }
        } else {
            UIView.animate(withDuration: 0.7) { [weak self] in
                self?.portfolioTableView.frame.origin.x += UIScreen.main.bounds.width
                self?.coinTableView.frame.origin.x += UIScreen.main.bounds.width
                self?.portfolioTableView.removeAllConstraints()
            }
        }
        
    }
}

import SwiftUI

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        Container()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            UINavigationController(rootViewController: HomeViewController())
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}



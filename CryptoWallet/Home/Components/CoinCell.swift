import UIKit

class CoinCell: UITableViewCell {
    
    private let coinRankLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .theme.secondaryText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coinSymbolLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .theme.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .theme.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceChangedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .theme.green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentHoldingsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .theme.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentHoldingsShortLabel: UILabel = {
        let label = UILabel()
        label.textColor = .theme.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coinImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let rightStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let centerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    static let identifier = "CoinCellID"
    
    let coin = DeveloperPreview.instance.coin

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        coinRankLabel.text = "\(coin.rank)"
        coinSymbolLabel.text = coin.symbol.uppercased()
        currentPriceLabel.text = coin.currentPrice.asCurrencyWith6Decimals()
        priceChangedLabel.text = coin.priceChangePercentage24H?.asPercentString()
        currentHoldingsLabel.text = coin.currentHoldingsValue.asCurrencyWith2Decimals()
        currentHoldingsShortLabel.text = (coin.currentHoldings ?? 0).asNumberString()
        
        addViews()
        setupConstraints()
        
        backgroundColor = .theme.background
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        coinImage.layer.cornerRadius = coinImage.frame.height / 2
    }
    
    private func addViews() {
        addSubview(coinRankLabel)
        addSubview(coinImage)
        addSubview(coinSymbolLabel)
        addSubview(rightStackView)
        addSubview(centerStackView)
        
        rightStackView.addArrangedSubview(currentPriceLabel)
        rightStackView.addArrangedSubview(priceChangedLabel)
        
        centerStackView.addArrangedSubview(currentHoldingsLabel)
        centerStackView.addArrangedSubview(currentHoldingsShortLabel)
    }
    
    private func setupConstraints() {
            
        NSLayoutConstraint.activate([
            coinRankLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            coinRankLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            coinImage.heightAnchor.constraint(equalToConstant: 30),
            coinImage.widthAnchor.constraint(equalToConstant: 30),
            coinImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinImage.leadingAnchor.constraint(equalTo: coinRankLabel.trailingAnchor, constant: 10),
            
            coinSymbolLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinSymbolLabel.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: 6),
            
            rightStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            rightStackView.widthAnchor.constraint(equalToConstant: self.frame.width / 3.5),
            
            centerStackView.trailingAnchor.constraint(equalTo: rightStackView.leadingAnchor, constant: -10),
            centerStackView.leadingAnchor.constraint(equalTo: coinSymbolLabel.trailingAnchor, constant: 20)
        ])
    }

}

import SwiftUI

struct ViewControllesr_Previews: PreviewProvider {
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


import UIKit
import SDWebImage

final class CoinCell: UITableViewCell {
    
    static let identifier = "CoinCellID"
    
    private let coinRankLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .theme.secondaryText
        label.textAlignment = .center
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
        label.adjustsFontSizeToFitWidth = true
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
        image.image = UIImage(systemName: "questionmark")
        image.clipsToBounds = true
        image.isHidden = true
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
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.isHidden = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
            
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        addViews()
        setupConstraints()
        backgroundColor = .theme.background
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        coinImage.layer.cornerRadius = coinImage.frame.height / 2
    }
    
    public func configureAppearance(coin: Coin, isShowHoldingColumn: Bool) {
        coinRankLabel.text = "\(coin.rank)"
        coinSymbolLabel.text = coin.symbol.uppercased()
        currentPriceLabel.text = coin.currentPrice.asCurrencyWith6Decimals()
        priceChangedLabel.text = coin.priceChangePercentage24H?.asPercentString()
        currentHoldingsLabel.text = coin.currentHoldingsValue.asCurrencyWith2Decimals()
        currentHoldingsShortLabel.text = (coin.currentHoldings ?? 0).asNumberString()

        priceChangedLabel.textColor = (coin.priceChangePercentage24H ?? 0) >= 0 ?
            .theme.green :
            .theme.red
        
        if !isShowHoldingColumn {
            currentHoldingsLabel.isHidden = true
            currentHoldingsShortLabel.isHidden = true
        }
        
        setupImage(urlString: coin.image)
    }
    
    private func addViews() {
        addSubview(coinRankLabel)
        addSubview(coinImage)
        addSubview(coinSymbolLabel)
        addSubview(rightStackView)
        addSubview(centerStackView)
        addSubview(loadingIndicator)
        
        rightStackView.addArrangedSubview(currentPriceLabel)
        rightStackView.addArrangedSubview(priceChangedLabel)
        
        centerStackView.addArrangedSubview(currentHoldingsLabel)
        centerStackView.addArrangedSubview(currentHoldingsShortLabel)
    }
    
    private func setupConstraints() {
            
        NSLayoutConstraint.activate([
            coinRankLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            coinRankLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinRankLabel.widthAnchor.constraint(equalToConstant: 30),
            
            coinImage.heightAnchor.constraint(equalToConstant: 30),
            coinImage.widthAnchor.constraint(equalToConstant: 30),
            coinImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinImage.leadingAnchor.constraint(equalTo: coinRankLabel.trailingAnchor),
            
            loadingIndicator.heightAnchor.constraint(equalToConstant: 30),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 30),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loadingIndicator.leadingAnchor.constraint(equalTo: coinRankLabel.trailingAnchor),
            
            coinSymbolLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinSymbolLabel.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: 6),
            
            rightStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            rightStackView.widthAnchor.constraint(equalToConstant: self.frame.width / 3.5),
            rightStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            centerStackView.trailingAnchor.constraint(equalTo: rightStackView.leadingAnchor, constant: -10),
            centerStackView.leadingAnchor.constraint(equalTo: coinSymbolLabel.trailingAnchor, constant: 20),
            centerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    private func setupImage(urlString: String) {
        coinImage.sd_setImage(with: URL(string: urlString)) { [weak self] _, _, _, _ in
            self?.loadingIndicator.stopAnimating()
            self?.loadingIndicator.isHidden = true
            self?.coinImage.isHidden = false
        }
    }
}

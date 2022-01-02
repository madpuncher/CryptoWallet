import UIKit

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
    
    private let coinTableView: UITableView = {
        let table = UITableView()
        table.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let leftCircleButton = CircleButtonView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), buttonName: "info")
    private let rightCircleButton = CircleButtonView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), buttonName: "chevron.right")
    
    private var showPortfolio = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        setupConstraints()
        configureAppearance()
    }
    
    private func addViews() {
        view.addSubview(headerLabel)
        view.addSubview(leftCircleButton)
        view.addSubview(rightCircleButton)
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
            coinTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            coinTableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16)
        ])
    }
    
    private func configureAppearance() {
        navigationController?.isNavigationBarHidden = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chevronWasTapped))
        rightCircleButton.isUserInteractionEnabled = true
        rightCircleButton.addGestureRecognizer(tapGesture)
        
        leftCircleButton.translatesAutoresizingMaskIntoConstraints = false
        rightCircleButton.translatesAutoresizingMaskIntoConstraints = false
        
        coinTableView.delegate = self
        coinTableView.dataSource = self
    }
    
    @objc private func chevronWasTapped() {
        showPortfolio.toggle()
        
        UIView.animate(withDuration: 0.4) { [weak self] in
            if !self!.showPortfolio {
                self?.rightCircleButton.transform = CGAffineTransform(rotationAngle: .pi)
                self?.headerLabel.text = "Portfolio"
                self?.leftCircleButton.imageName = "plus"
            } else {
                self?.rightCircleButton.transform = CGAffineTransform.identity
                self?.headerLabel.text = "Live Prices"
                self?.leftCircleButton.imageName = "info"
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as! CoinCell
        
        return cell
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


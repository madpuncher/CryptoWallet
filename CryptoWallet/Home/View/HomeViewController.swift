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
        ])
    }
    
    private func configureAppearance() {
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

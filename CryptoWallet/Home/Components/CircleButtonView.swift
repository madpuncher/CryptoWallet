import UIKit

final class CircleButtonView: UIView {
    
    private let buttonImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.tintColor = .theme.accent
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public var imageName: String {
        get {
            return ""
        }
        set {
            buttonImage.image = UIImage(systemName: newValue)
        }
    }
    
    init(frame: CGRect, buttonName: String) {
        super.init(frame: frame)
        
        configureAppearance(named: buttonName)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        buttonImage.layer.cornerRadius = buttonImage.frame.height / 2
    }
    
    private func addViews() {
        addSubview(buttonImage)
    }
    
    private func configureAppearance(named: String) {
        buttonImage.image = UIImage(systemName: named)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonImage.heightAnchor.constraint(equalToConstant: 50),
            buttonImage.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

import SwiftUI

struct ViewControllers_Previews: PreviewProvider {
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

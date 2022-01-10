import UIKit

final class SearchBarView: UIView {
    
    private let searchGlassImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "magnifyingglass")
        image.contentMode = .scaleAspectFit
        image.tintColor = .theme.secondaryText
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let searchTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search by name or symbol..."
        tf.textColor = .theme.accent
        tf.textAlignment = .left
        tf.font = .systemFont(ofSize: 17, weight: .semibold)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let clearTextFieldButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "xmark.circle.fill")
        image?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .theme.accent
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setupConstraints()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.addSubview(searchGlassImage)
        self.addSubview(searchTextField)
        self.addSubview(clearTextFieldButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchGlassImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            searchGlassImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            searchGlassImage.widthAnchor.constraint(equalToConstant: 30),
            
            searchTextField.leadingAnchor.constraint(equalTo: searchGlassImage.trailingAnchor, constant: 10),
            searchTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            searchTextField.trailingAnchor.constraint(equalTo: clearTextFieldButton.leadingAnchor, constant: -10),
            
            clearTextFieldButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            clearTextFieldButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            clearTextFieldButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureAppearance() {
        clearTextFieldButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        searchTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        
        searchTextField.delegate = self
    }
    
    @objc private func textFieldDidChanged() {
        guard let text = searchTextField.text else { return }
        searchGlassImage.tintColor = text.isEmpty ?
            .theme.secondaryText :
            .theme.accent
        
        clearTextFieldButton.isHidden = text.isEmpty ? true : false
    }
    
    @objc private func clearButtonTapped() {
        searchTextField.text = ""
        clearTextFieldButton.isHidden = true
    }
    
    @objc private func dismissKeyboard() {
        searchTextField.resignFirstResponder()
    }
}

extension SearchBarView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

import SwiftUI

struct SearchBarViewController_Previews: PreviewProvider {
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



import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - Internal properties
    
    var presenter: MainPresenterProtocol?
    
    //MARK: - Private properties
    
    private let sizeOfImage: CGFloat = 200
    private let sizeOfSpinner: CGFloat = 50
    
    private let generateTextfield: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter your text here"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        field.leftViewMode = .always
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let generateImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .green
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    private let generateButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitle("Generate", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.isHidden = true
        spinner.color = .red
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setup()
    }
    
    //MARK: - Override methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - Private methods
    
    private func setupLayout() {
        view.backgroundColor = .white

        view.addSubview(generateTextfield)
        view.addSubview(generateImage)
        generateImage.addSubview(spinner)
        view.addSubview(generateButton)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            generateTextfield.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            generateTextfield.heightAnchor.constraint(equalToConstant: 50),
            generateTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            generateTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),

            generateImage.topAnchor.constraint(equalTo: generateTextfield.bottomAnchor, constant: 20),
            generateImage.heightAnchor.constraint(equalToConstant: sizeOfImage),
            generateImage.widthAnchor.constraint(equalToConstant: sizeOfImage),
            generateImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            spinner.centerYAnchor.constraint(equalTo: generateImage.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: generateImage.centerXAnchor),
            spinner.heightAnchor.constraint(equalToConstant: sizeOfSpinner),
            spinner.widthAnchor.constraint(equalToConstant: sizeOfSpinner),
    
            generateButton.topAnchor.constraint(equalTo: generateImage.bottomAnchor, constant: 20),
            generateButton.heightAnchor.constraint(equalToConstant: 50),
            generateButton.widthAnchor.constraint(equalToConstant: sizeOfImage),
            generateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
     
            saveButton.topAnchor.constraint(equalTo: generateButton.bottomAnchor, constant: 20),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: sizeOfImage),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setup() {
        generateTextfield.delegate = self
        generateButton.addTarget(self, action: #selector(generateImageTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveImageToFavorite), for: .touchUpInside)
        
        generateButton.accessibilityIdentifier = "generateButton"
        generateTextfield.accessibilityIdentifier = "generateTextfield"
    }
    
    private func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionCopy = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(actionCopy)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    
    @objc private func generateImageTapped() {
        presenter?.generateImage(with: generateTextfield.text)
    }
    
    @objc private func saveImageToFavorite() {
        if let image = generateImage.image, let text = generateTextfield.text {
            presenter?.addToFavorite(with: image, text: text)
        }
    }
}

//MARK: - Extension: UITextFieldDelegate

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}

//MARK: - Extension: MainViewProtocol

extension MainViewController: MainViewProtocol {
    func startSpinner() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func stopSpinner() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    
    func showAlert(title: String, message: String) {
        self.createAlert(title: title, message: message)
    }
    
    func updateImage(with image: UIImage) {
        self.generateImage.image = image
    }
}

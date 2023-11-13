import UIKit
import RealmSwift

class DownloadModalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var completionHandler: (() -> Void)?
    var pickedImageData: Data?

    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter title"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter movie description"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let selectImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Image", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(selectImageButton)
        view.addSubview(imageView)
        view.addSubview(downloadButton)
        
        selectImageButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        downloadButton.addTarget(self, action: #selector(saveToRealm), for: .touchUpInside)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            selectImageButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20),
            selectImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            selectImageButton.heightAnchor.constraint(equalToConstant: 50),
            
            imageView.topAnchor.constraint(equalTo: selectImageButton.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            downloadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            downloadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            downloadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            downloadButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            pickedImageData = selectedImage.jpegData(compressionQuality: 0.5) // Compress image
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

    @objc func saveToRealm() {
        
        guard let title = titleTextField.text, !title.isEmpty,
              let description = descriptionTextField.text, !description.isEmpty,
              let imageData = pickedImageData else {
            showAlert("Validation failed", "Please ensure all fields are filled.")
            return
        }
        
        let downloadItem = DownloadModel() // Assuming DownloadModel is a Realm object
        downloadItem.title = title
        downloadItem.movieDescription = description
        downloadItem.imageData = imageData
        
        do {
               let realm = try Realm()
               try realm.write {
                   realm.add(downloadItem)
               }
               showAlert("Success", "Data saved successfully.") {
                   self.completionHandler?()
                   self.navigationController?.popViewController(animated: true)
               }
           } catch let error {
               showAlert("Error saving to Realm", error.localizedDescription)
           }
       }

       private func showAlert(_ title: String, _ message: String, completion: @escaping () -> Void = {}) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
               completion()
           })
           present(alert, animated: true)
       }

    private func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

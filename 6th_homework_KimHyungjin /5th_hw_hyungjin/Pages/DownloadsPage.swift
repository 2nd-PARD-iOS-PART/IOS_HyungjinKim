//
//  DownloadsPage.swift
//  3rd_redo
//
//  Created by hyungjin kim on 2023/10/07.
//

import UIKit
import RealmSwift

class DownloadsPage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var downloadItems: Results<DownloadModel>?

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()


    private let downloadImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Download")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let downloadText: UILabel = {
        let text = UILabel()
        text.text = "Movies and TV shows that you\ndownload appear here"
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.textColor = .systemGray
        text.textAlignment = .center
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false

        return text
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Find Something to Download", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(downloadImage)
            view.addSubview(downloadText)
            view.addSubview(downloadButton)
            view.addSubview(tableView)
            
            configureConstraints()
            setupNavigationBar()
            downloadButton.addTarget(self, action: #selector(openNavigation), for: .touchUpInside)
            tableView.register(DownloadTableViewCell.self, forCellReuseIdentifier: DownloadTableViewCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
            loadDownloadItems()
        }
    
    private func setupNavigationBar() {
        navigationItem.title = "Downloads"

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteSelectedItems))
        navigationItem.rightBarButtonItems = [addButton, deleteButton]
    }

    private func loadDownloadItems() {
        let realm = try! Realm()
        downloadItems = realm.objects(DownloadModel.self)
        
        let hasItems = !(downloadItems?.isEmpty ?? true)
        tableView.isHidden = !hasItems
        [downloadImage, downloadText, downloadButton].forEach { $0.isHidden = hasItems }

        tableView.reloadData()
    }
    
    func configureConstraints(){
        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 650),
            downloadButton.widthAnchor.constraint(equalToConstant: 300),
            downloadButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let downloadTextConstraints = [
            downloadText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadText.topAnchor.constraint(equalTo: downloadImage.bottomAnchor, constant: 30),
        ]
        let downloadImageConstraints = [
            downloadImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadText.topAnchor.constraint(equalTo: view.topAnchor, constant: 450),
            downloadImage.widthAnchor.constraint(equalToConstant: 300),
            downloadImage.heightAnchor.constraint(equalToConstant: 200),

        ]
        
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(downloadButtonConstraints)
        NSLayoutConstraint.activate(downloadTextConstraints)
        NSLayoutConstraint.activate(downloadImageConstraints)
        NSLayoutConstraint.activate(tableViewConstraints)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadItems?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DownloadTableViewCell.identifier, for: indexPath) as? DownloadTableViewCell,
              let downloadModel = downloadItems?[indexPath.row] else {
            fatalError("Cell not found or downloadItems not retrievable")
        }
        cell.configure(with: downloadModel.title, description: downloadModel.movieDescription, imageData: downloadModel.imageData)
        return cell
    }


    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let item = downloadItems?[indexPath.row] {
                deleteItem(item)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    private func deleteItem(_ item: DownloadModel) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(item)
        }
        loadDownloadItems()
    }

    @objc func addNewItem() {
        let downloadModalVC = DownloadModalViewController()
        downloadModalVC.completionHandler = { [weak self] in
            self?.loadDownloadItems()
        }
        self.navigationController?.pushViewController(downloadModalVC, animated: true)
    }
    
    @objc func deleteSelectedItems() {
        guard let selectedItems = tableView.indexPathsForSelectedRows else {
            showAlert("No Selection", "Please select at least one item to delete.")
            return
        }

        let alert = UIAlertController(title: "Delete selected items?", message: "This action cannot be undone.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            do {
                let realm = try Realm()
                try realm.write {
                    for indexPath in selectedItems {
                        if let itemToDelete = self?.downloadItems?[indexPath.row] {
                            realm.delete(itemToDelete)
                        }
                    }
                    self?.loadDownloadItems()
                }
            } catch let error {
                print("Error deleting from Realm: \(error)")
            }
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }

    private func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

    
    @objc func openNavigation() {
        let secondVC = DownloadModalViewController()
        secondVC.completionHandler = { [weak self] in
            self?.loadDownloadItems()
        }
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

}

class DownloadTableViewCell: UITableViewCell {
    
    static let identifier = "DownloadTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(titleLabel)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints() {
        let labelSpacing: CGFloat = 5
        let imagePadding: CGFloat = 20
        let imageHeight: CGFloat = 80
        let imageWidth: CGFloat = 150

        NSLayoutConstraint.activate([
            // Constraints for titleImageView
            titleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: imagePadding),
            titleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            titleImageView.heightAnchor.constraint(equalToConstant: imageHeight),

            // Constraints for titleLabel
            titleLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: imagePadding),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: imagePadding),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -imagePadding),

            // Constraints for descriptionLabel
            descriptionLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: imagePadding),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: labelSpacing),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -imagePadding),
        ])
    }

    //데이터를 가져올떄 data type의 변화이 필요해서 만든 함수. 테이블에서 이미지를 불러낼때 사용된다
    func configure(with title: String, description: String, imageData: Data?) {
        titleLabel.text = title
        descriptionLabel.text = description
        if let imageData = imageData {
            titleImageView.image = UIImage(data: imageData)
        } else {
            titleImageView.image = nil
        }
    }

}


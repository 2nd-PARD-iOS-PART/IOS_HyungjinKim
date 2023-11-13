//
//  DownloadsPage.swift
//  3rd_redo
//
//  Created by hyungjin kim on 2023/10/07.
//

import UIKit

class DownloadsPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(downloadImage)
        view.addSubview(downloadText)
        view.addSubview(downloadButton)
        configureConstraints()
        downloadButton.addTarget(self, action: #selector(openNavigation), for: .touchUpInside)

    }
    
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
        
        NSLayoutConstraint.activate(downloadButtonConstraints)
        NSLayoutConstraint.activate(downloadTextConstraints)
        NSLayoutConstraint.activate(downloadImageConstraints)

    }
    
    @objc func openNavigation() {
        let secondVC = DownloadModalViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

}

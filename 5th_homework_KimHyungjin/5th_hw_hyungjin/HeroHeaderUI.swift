//
//  HeroHeader.swift
//  3rd_homework_KimHyungjin
//
//  Created by hyungjin kim on 2023/10/07.
//

import UIKit

class HeroHeaderUI: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(titleImage)
        applyConstraints()
    }
    
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            titleImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 100),
            titleImage.widthAnchor.constraint(equalToConstant: 300),
            titleImage.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    

    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "HeroImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Stranger Things")
        imageView.contentMode = .scaleAspectFit 
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

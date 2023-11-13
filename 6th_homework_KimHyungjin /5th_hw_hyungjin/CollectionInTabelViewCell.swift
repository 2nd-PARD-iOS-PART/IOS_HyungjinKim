//  CollectionInTableViewCell.swift
//  3rd_homework_KimHyungjin
//
//  Created by hyungjin kim on 2023/10/07.
//

import UIKit

class CollectionInTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    
    var models: [Model] = []
    var tableViewSection: Int = 0

   static let identifier = "CollectionInTableViewCell"
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    func configure(with models: [Model]) {
        self.models = models
        collectionView.reloadData()
    }
}

extension CollectionInTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as? MyCollectionViewCell else {
            fatalError("Could not dequeue MyCollectionViewCell")
        }
        
        let model = models[indexPath.item]

        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch tableViewSection {
        case 0:
            return CGSize(width: 150, height: 170)
        case 1:
            return CGSize(width: 126, height: 227)
        default:
            return CGSize(width: 125, height: 200) // Default size
        }
        
    }
}

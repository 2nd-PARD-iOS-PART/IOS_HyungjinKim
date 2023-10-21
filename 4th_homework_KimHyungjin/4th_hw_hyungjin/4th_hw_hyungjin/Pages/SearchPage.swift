//
//  SearchPage.swift
//  3rd_redo
//
//  Created by hyungjin kim on 2023/10/07.
//

import UIKit

class SearchPage: UIViewController {
    var models: [PopularSearchModel] = []

    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(MyTitleTableViewCell.self, forCellReuseIdentifier: MyTitleTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Popular Searches"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        configure(with: PopularSearchModel.modelData)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
    func configure(with models: [PopularSearchModel]) {
        self.models = models
        discoverTable.reloadData()
    }
}


extension SearchPage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTitleTableViewCell.identifier, for: indexPath) as? MyTitleTableViewCell else {
            fatalError("Could not dequeue MyTitleTableViewCell")
        }

        // Get the model for the current row
        let model = models[indexPath.row]

        // Use the new configure method to set the cell's data
        cell.configure(with: model)

        return cell
    }
    

}

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
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a movie or a TV show"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        // Creating a search controller
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search for a movie or a TV show"
        
        // Adding the search controller to the navigation item
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        configure(with: PopularSearchModel.modelData)
        setupConstraints()
        
        setupTableViewHeader()
    }
    
    private func setupTableViewHeader() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let label = UILabel()
        label.text = "Popular Searches"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.frame = headerView.bounds
        headerView.addSubview(label)
        discoverTable.tableHeaderView = headerView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
                discoverTable.frame = view.bounds
    }
    
    func configure(with models: [PopularSearchModel]) {
        self.models = models
        discoverTable.reloadData()
    }
    
    private func setupConstraints() {
        let discoverTableConstraints = [
            discoverTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            discoverTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            discoverTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            discoverTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        discoverTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(discoverTableConstraints)
    }
    
//    constraints for the search bar and the table.
//    private func setupConstraints() {
//        let searchBarConstraints = [
//            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ]
//
//        let discoverTableConstraints = [
//            discoverTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
//            discoverTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            discoverTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            discoverTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ]
//
//        NSLayoutConstraint.activate(searchBarConstraints)
//        NSLayoutConstraint.activate(discoverTableConstraints)
//    }
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

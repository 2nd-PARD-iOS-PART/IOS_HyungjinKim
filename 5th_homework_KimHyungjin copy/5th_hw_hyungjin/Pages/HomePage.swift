//
//  HomePage.swift
//  3rd_redo
//
//  Created by hyungjin kim on 2023/10/07.
//

import UIKit

class HomePage: UIViewController{
    
    let sectionTitles: [String] = ["Previews", "Continue Watching for Hyungjin", "My List", "Europe movie", "Romace/Drama", "Action/Thriller"]
    
    private let MyTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionInTableViewCell.self, forCellReuseIdentifier: "CollectionInTableViewCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(MyTable)
        
        MyTable.delegate = self
        MyTable.dataSource = self
        
        mainNavigationBar()
    
        let headerView = HeroHeaderUI(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        MyTable.tableHeaderView = headerView
    }
    
    func mainNavigationBar(){
        let navigationBarAppearance = UINavigationBarAppearance()
        
        var logo = UIImage(named: "Logo")
        logo = logo?.withRenderingMode(.alwaysOriginal)
        var movies = UIImage(named: "Movies")
        movies = movies?.withRenderingMode(.alwaysOriginal)
        var myList = UIImage(named: "My List")
        myList = myList?.withRenderingMode(.alwaysOriginal)
        var tvShows = UIImage(named: "TV Shows")
        tvShows = tvShows?.withRenderingMode(.alwaysOriginal)
        
        
        let moviesButton = UIBarButtonItem(image: movies, style: .plain, target: nil, action: nil)
        let myListButton = UIBarButtonItem(image: myList, style: .plain, target: nil, action: nil)
        let tvShowsButton = UIBarButtonItem(image: tvShows, style: .plain, target: nil, action: nil)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logo, style: .plain, target: nil, action: nil)
      
        navigationItem.rightBarButtonItems = [flexibleSpace, moviesButton, myListButton, tvShowsButton, flexibleSpace]
        
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationBarAppearance.configureWithTransparentBackground()
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationBarAppearance.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        navigationItem.standardAppearance = navigationBarAppearance
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.isTranslucent = true
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        MyTable.frame = view.bounds
    }
}



extension HomePage: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionInTableViewCell.identifier, for: indexPath) as? CollectionInTableViewCell
            else{
                print("fail to start CollectionInTableViewCell")
                return UITableViewCell()
        }
        let data = Model.ModelData[indexPath.section]  // Use the ModelData array for each section
        cell.configure(with: data)
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 167
        case 1:
            return 250
        default:
            return 200
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection  section: Int) -> CGFloat {
        return 50
    }
    
    //Header related
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.lowercased()
    }
}

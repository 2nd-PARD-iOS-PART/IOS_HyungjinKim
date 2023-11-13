//
//  DownloadModalViewController.swift
//  5th_hw_hyungjin
//
//  Created by hyungjin kim on 2023/11/13.
//

import UIKit
import RealmSwift

let realm = try! Realm()

class DownloadModalViewController: UIViewController {
    var member: [Data] = []
    var selected: IndexPath = []
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    let homeTitle: UILabel = {
        let label = UILabel()
        label.text = "🏄‍♀️ PARD 타는 사람들 🏄🏻‍♂️"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.systemCyan, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.systemCyan, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(addButton)
        view.addSubview(editButton)
        view.addSubview(homeTitle)
        view.addSubview(deleteButton)
        loadMemberList()
        addConstraints()
        tableView.dataSource = self
        tableView.delegate = self
        addButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editData), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteWord), for: .touchUpInside)

        
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: homeTitle.topAnchor, constant: 100),
            tableView.widthAnchor.constraint(equalToConstant: view.frame.width),
            tableView.heightAnchor.constraint(equalToConstant: view.frame.height),
            
            addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            deleteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            deleteButton.leadingAnchor.constraint(equalTo: editButton.trailingAnchor, constant: 20),
            
            homeTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            homeTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    @objc func add() {
        print("buttonPRessed")
        let alert = UIAlertController(title: "데이터를 추가하시겠습니까?", message: nil, preferredStyle: .alert)
        alert.addTextField{ text in
            text.placeholder = "이름을 입력하세요."
        }
        alert.addTextField { text in
            text.placeholder = "나이를 입력하세요."
        }
        alert.addTextField { text in
            text.placeholder = "파트를 입력하세요."
        }
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            guard
                let name = alert.textFields?[0].text, !name.isEmpty,
                let ageString = alert.textFields?[1].text, let age = Int(ageString),
                let part = alert.textFields?[2].text, !part.isEmpty
                    
            else {
                print("텍스트 입력에 오류가 발생했습니다.")
                return
            }
            
            let newMember = Data()
            newMember.name = name
            newMember.age = age
            newMember.part = part
            
            do {
                try realm.write {
                    realm.add(newMember)
                    self.loadMemberList()
                }
            } catch let error {
                print("Error saving to Realm: \(error)")
            }
        })
        self.present(alert, animated: true)
    }
    
    @objc func editData() {
        print("edit button Pressed")
        let indexPath = selected.row
        let memberedit = member[indexPath]
        
        let alert = UIAlertController(title: "데이터를 수정하시겠습니까?", message: nil, preferredStyle: .alert)
        alert.addTextField{ text in
            text.placeholder = "이름을 입력하세요."
            text.text = memberedit.name
        }
        alert.addTextField { text in
            text.placeholder = "나이를 입력하세요."
            text.text = String(memberedit.age)
        }
        alert.addTextField { text in
            text.placeholder = "파트를 입력하세요."
            text.text = memberedit.part
        }
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            guard
                let name = alert.textFields?[0].text, !name.isEmpty,
                let ageString = alert.textFields?[1].text, let age = Int(ageString),
                let part = alert.textFields?[2].text, !part.isEmpty
                    
            else {
                print("텍스트 입력에 오류가 발생했습니다.")
                return
            }
    
            do {
                try realm.write {
                    memberedit.name = name
                    memberedit.age = age
                    memberedit.part = part
                    self.loadMemberList()
                }
            } catch let error {
                print("Error saving to Realm: \(error)")
            }
        })
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        self.present(alert, animated: true)
    }
    
    @objc func deleteWord() {
        print("delete button Pressed")
        let indexPath = selected.row
        let memberedit = member[indexPath]
        
        let alert = UIAlertController(title: "데이터를 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default)
        { _ in
            do {
                try realm.write {
                    realm.delete(memberedit)
                    self.loadMemberList()
                }
            } catch let error {
                print("Error deleting to Realm: \(error)")
            }
        })
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        self.present(alert, animated: true)
    }
    
    
    func loadMemberList() {
        let member = realm.objects(Data.self)
        self.member = Array(member)
        print("input : \(member)")
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let members = member[indexPath.row]
        cell.textLabel?.text = "[ \(members.part) ] \(members.name)"
        
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return member.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = indexPath
        print(selected)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
               let memberToDelete = member[indexPath.row]
               do {
                   try realm.write {
                       realm.delete(memberToDelete)
                   }
                   // 로컬에서 해당 데이터 삭제
                   member.remove(at: indexPath.row)
                   // 테이블 뷰에서 해당 row 삭제
                   tableView.deleteRows(at: [indexPath], with: .middle)
               } catch let error {
                   print("Error deleting from Realm: \(error)")
               }
           }
        }
}

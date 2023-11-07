//
//  ViewController.swift
//  Advanced Table View
//
//  Created by Macbook Air 2017 on 2. 11. 2023..
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [CellModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setUpModels()
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
    }
    
    private func setUpModels() {
        models.append(.collectionView(models: [
            CollectionTableCellModel(title: "Car 1", imageName: "car1"),
            CollectionTableCellModel(title: "Car 2", imageName: "car2"),
            CollectionTableCellModel(title: "Car 3", imageName: "car3"),
            CollectionTableCellModel(title: "Car 4", imageName: "car4"),
            CollectionTableCellModel(title: "Car 5", imageName: "car5"),
            CollectionTableCellModel(title: "Car 6", imageName: "car6"),
            CollectionTableCellModel(title: "Car 7", imageName: "car7")], rows: 2))
        
        models.append(.list(models: [
            ListCellModel(title: "First thing"),
            ListCellModel(title: "Second thing"),
            ListCellModel(title: "Third thing"),
            ListCellModel(title: "Forth thing"),
            ListCellModel(title: "Fifth thing")]))
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch models[section] {
        case .list(let models): return models.count
        case .collectionView(_, _): return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch models[indexPath.section] {
        case .list(let models):
            let model = models[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = model.title
            return cell
        case .collectionView(let models, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            cell.configure(with: models)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch models[indexPath.section] {
        case .list(_): return 50
        case .collectionView(_, let rows): return 180 * CGFloat(rows)
        }
    }
}

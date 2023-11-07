//
//  ViewController.swift
//  Advanced Table View
//
//  Created by Macbook Air 2017 on 2. 11. 2023..
//

import UIKit
import AVFoundation

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
        setTableHeader()
    }
    
    private func setTableHeader() {
        guard let path = Bundle.main.path(forResource: "video", ofType: "mp4")
        else {
            return
        }
        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        player.volume = 0
        
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.frame.size.width,
                                              height: view.frame.size.width))
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = headerView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        headerView.layer.addSublayer(playerLayer)
        player.play()
        
        tableView.tableHeaderView = headerView
    }
    
    private func setUpModels() {
        models.append(.collectionView(models: [
            CollectionTableCellModel(title: "BMW 3 Series", imageName: "car1"),
            CollectionTableCellModel(title: "Hyundai Elantra", imageName: "car2"),
            CollectionTableCellModel(title: "Jaguar F-Type", imageName: "car3"),
            CollectionTableCellModel(title: "Mercedes Amg Gt", imageName: "car4"),
            CollectionTableCellModel(title: "Porsche 911 Junior", imageName: "car5"),
            CollectionTableCellModel(title: "Porsche 718 Cayman", imageName: "car6"),
            CollectionTableCellModel(title: "Acura Integra", imageName: "car7")], rows: 2))
        
        models.append(.list(models: [
            ListCellModel(title: "BMW 3 Series"),
            ListCellModel(title: "Hyundai Elantra"),
            ListCellModel(title: "Jaguar F-Type"),
            ListCellModel(title: "Mercedes Amg Gt"),
            ListCellModel(title: "Porsche 911 Junior"),
            ListCellModel(title: "Porsche 718 Cayman"),
            ListCellModel(title: "Acura Integra")]))
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

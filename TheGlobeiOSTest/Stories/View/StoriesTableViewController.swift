//
//  StoriesTableViewController.swift
//  TheGlobeiOSTest
//
//  Created by Raphael Araújo on 2024-10-15.
//

import UIKit

protocol StoriesViewControllerProtocol: AnyObject {
    func display(cellContent: [StoryCellData])
    func hideData()
}

class StoriesTableViewController: UITableViewController, StoriesViewControllerProtocol {
    private var cellData: [StoryCellData] = []
    private var viewModel: StoriesViewModel = StoriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    
        viewModel.viewController = self
        viewModel.update()
    }
    
    func display(cellContent: [StoryCellData]) {
        cellData = cellContent
        tableView.reloadData()
    }
    
    func hideData() {
        cellData = []
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(StoryTableViewCell.self, forCellReuseIdentifier: "StoryTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
    }
}

extension StoriesTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell" , for: indexPath) as? StoryTableViewCell else { return UITableViewCell() }
        
        let story = cellData[indexPath.row]
        
        cell.configure(with: story)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}


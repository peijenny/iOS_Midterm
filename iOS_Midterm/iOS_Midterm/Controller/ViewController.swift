//
//  ViewController.swift
//  iOS_Midterm
//
//  Created by Jenny Hung on 2022/4/2.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var publisherTableView: UITableView! {
        
        didSet {
            
            publisherTableView.delegate = self
            
            publisherTableView.dataSource = self
            
        }
        
    }
    
    var publisherManager = PublisherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 註冊 Publisher TableView Cell
        publisherTableView.register(UINib(nibName: String(describing: PublisherTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PublisherTableViewCell.self))
        
        //publisherManager.addData()
        
        publisherManager.fetchData()
        
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PublisherTableViewCell.self), for: indexPath)
        
        guard let cell = cell as? PublisherTableViewCell else { return cell }
        
        // 顯示所有 TableViewCell 內容
        
        cell.articleTitleLabel.text = "Test Title"
        
        cell.authorNameLabel.text = "Test Name"
        
        cell.createdTimeLabel.text = "20220402"
        
        cell.categoryLabel.text = "Other"
        
        cell.articleContentLabel.text = "Test Content"
        
        
        
        return cell
    }
}

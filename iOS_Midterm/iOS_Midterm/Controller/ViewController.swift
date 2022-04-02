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
    
    @IBOutlet weak var AddArticleButton: UIButton!
    
    var publisherManager = PublisherManager()
    
    var publishers: [Publisher] = [] {
        
        didSet {
            
            publisherTableView.reloadData()
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 註冊 Publisher TableView Cell
        publisherTableView.register(UINib(nibName: String(describing: PublisherTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PublisherTableViewCell.self))
        
        fetchData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        AddArticleButton.layer.cornerRadius = AddArticleButton.frame.width / 2
        
    }
    
    func fetchData() {
        
        publisherManager.getData(completion: { [weak self] result in
            
            switch result {

            case .success(let data):

                self?.publishers = data
                
            case .failure(let error):

                print(error)
                
            }
            
            
        })
    }

    @IBAction func presentToArticlePage(_ sender: UIButton) {
        
        let articleviewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ArticleViewController.self))
        
        guard let articleviewController = articleviewController as? ArticleViewController else { return }
        
        let navgationController = UINavigationController(rootViewController: articleviewController)

        navgationController.modalPresentationStyle = .fullScreen
        
        navgationController.navigationBar.topItem?.title = "Publisher"
        
        self.present(navgationController, animated: true, completion: nil)
        
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return publishers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PublisherTableViewCell.self), for: indexPath)
        
        guard let cell = cell as? PublisherTableViewCell else { return cell }
        
        cell.showData(publisher: publishers[indexPath.row])
        
        return cell
    }
}

//
//  ArticleViewController.swift
//  iOS_Midterm
//
//  Created by Jenny Hung on 2022/4/2.
//

import UIKit

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var inputTitleTextField: UITextField!
    
    @IBOutlet weak var inputCategoryTextField: UITextField!
    
    @IBOutlet weak var inputContentTextField: UITextField!
    
    var publisherManager = PublisherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func sendArticleButton(_ sender: UIButton) {
        
        guard let inputTitle = inputTitleTextField.text,
              let inputCategory = inputCategoryTextField.text,
              let inputContent = inputContentTextField.text
        else { return }
        
        if inputTitle == "" || inputCategory == "" || inputContent == "" {
            
            print("Input textField can't not be empty!")
            
        } else {
            
            publisherManager.addData(
                title: inputTitle,
                category: inputCategory,
                content: inputContent
            )
            
            self.dismiss(animated: true)
            
        }
        
    }
    
}

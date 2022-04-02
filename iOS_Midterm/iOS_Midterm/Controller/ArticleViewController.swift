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
    
    @IBOutlet weak var inputContentTextView: UITextView!
    
    var publisherManager = PublisherManager()
    
    var placeholder = UILabel()
    
    var donebtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputContentTextView.layer.borderColor = UIColor.systemGray5.cgColor
        
        inputContentTextView.layer.borderWidth = 1
        
        inputContentTextView.layer.cornerRadius = 5
        
        inputContentTextView.text = "input content"
        
        inputContentTextView.textColor = UIColor.systemGray3
        
        inputTitleTextField.delegate = self
        
        inputCategoryTextField.delegate = self
        
        inputContentTextView.delegate = self
        


    }
    
    
    @IBAction func sendArticleButton(_ sender: UIButton) {
        
        guard let inputTitle = inputTitleTextField.text,
              let inputCategory = inputCategoryTextField.text,
              let inputContent = inputContentTextView.text
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


extension ArticleViewController: UITextFieldDelegate {
    
    // 當點擊 view 任何一處時，鍵盤收起
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)

    }
    
    // 前兩個 TextField 改成顯示 Next，並且可以跳到下一個 TextField
    // 而最後一個 TextView 則顯示 Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
       let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            
            nextResponder.becomeFirstResponder()
            
        } else {
            
            textField.resignFirstResponder()
            
        }
        
        return true
    }
    
}

extension ArticleViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.systemGray3 {
            
            textView.text = nil
            
            textView.textColor = UIColor.black
            
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            
            textView.text = "input content"
            
            textView.textColor = UIColor.systemGray3
            
        }
    }
}


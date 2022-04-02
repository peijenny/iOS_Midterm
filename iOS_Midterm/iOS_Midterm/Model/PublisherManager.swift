//
//  PublisherManager.swift
//  iOS_Midterm
//
//  Created by Jenny Hung on 2022/4/2.
//

import Foundation
import FirebaseFirestore

enum Result<T> {

    case success(T)

    case failure(Error)
}

class PublisherManager {
    
    let articles = Firestore.firestore().collection("articles")
    
    let authorEmail = "Jenny.Hung@gmail.com"
    
    let authorId = "JennyHung0402"
    
    let authorName = "Jenny Hung"
    
    // 新增
    func addData(title: String, category: String, content: String) {
        
        let document = articles.document()
        
        let data: [String: Any] = [
            "author": [
                "email": authorEmail,
                "id": authorId,
                "name": authorName
            ],
            "title": title,
            "content": content,
            "createdTime": NSDate().timeIntervalSince1970,
            "id": document.documentID,
            "category": category
        ]
        
        articles.document(document.documentID).setData(data)
        
    }
    
    // MARK: - 取得 Firebase Data (所有 Articles)
    func getData(completion: @escaping (Result<[Publisher]>) -> Void) {
        
        articles.addSnapshotListener { (snapshot, error) in
            
            var publishers: [Publisher] = []
            
            guard let snapshot = snapshot else {

                print("Error fetching document: \(error!)")

                completion(Result.failure(error!))

                return
            }
            
            for document in snapshot.documents {
                
                let data = document.data()
                
                guard let authorData = data["author"] as? Dictionary<String, String> else { return }
                
                let author: Author = Author(
                    email: authorData["email"] ?? "",
                    id: authorData["id"] ?? "",
                    name: authorData["name"] ?? ""
                )
                
                let title = data["title"] as? String ?? ""
                
                let content = data["content"] as? String ?? ""
                
                let id = data["id"] as? String ?? ""
                
                let category = data["category"] as? String ?? ""
                
                guard let createdTime = data["createdTime"] as? TimeInterval else { return }
                
                let date = Date(timeIntervalSince1970: createdTime)
                
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
                
                let createDate = dateFormatter.string(from: date)

                let publisher: Publisher = Publisher(
                    author: author,
                    title: title,
                    content: content,
                    createdTime: createDate,
                    id: id,
                    category: category
                )
                
                publishers.append(publisher)
                
            }
            
            let sortedPublisher: [Publisher] = publishers.sorted { (lhs, rhs) in
                
                return lhs.createdTime > rhs.createdTime // 由新到舊排序
                
            }
            
            completion(Result.success(sortedPublisher))
            
            if let error = error {
                
                completion(Result.failure(error))
                
            }
            
        }
        
    }

}

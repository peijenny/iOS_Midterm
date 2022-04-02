//
//  PublisherTableViewCell.swift
//  iOS_Midterm
//
//  Created by Jenny Hung on 2022/4/2.
//

import UIKit

class PublisherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    
    @IBOutlet weak var createdTimeLabel: UILabel!
    
    @IBOutlet weak var articleContentLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

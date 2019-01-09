//
//  CommentCell.swift
//  StepsChallenge
//
//  Created by dreams on 1/9/19.
//  Copyright © 2019 Steps. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var labelPostId: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var textViewBody: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(comment: Comment) {
        self.labelPostId.text = "\(comment.postId)"
        self.labelName.text = comment.name
        self.labelEmail.text = comment.email
        self.textViewBody.text = comment.body
        self.adjustUITextViewHeight(arg: self.textViewBody)
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }

}

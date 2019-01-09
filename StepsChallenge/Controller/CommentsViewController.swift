//
//  CommentsViewController.swift
//  StepsChallenge
//
//  Created by dreams on 1/9/19.
//  Copyright © 2019 Steps. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    var firstNum = 1
    var lastNum = 500
    
    var currentPage = 1
    
    var commentArr = [Comment]()
    
    var fetchedLast = false
    
    var webservice: CommentService!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webservice = self
    }
    
}

extension CommentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentCell
        let comment = self.commentArr[indexPath.row]
        cell.setContent(comment: comment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == self.commentArr.count - 1) && !fetchedLast {
            self.currentPage = self.currentPage + 1
            self.webservice.fetchComments(firstNum: self.firstNum, lastNum: self.lastNum, page: self.currentPage)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CommentsViewController: CommentService {
    func webServiceGetError(receivedError: String) {
        StepsHelper.shared.showAlertViewWithTitle("", message: "Error to get comments. try again later.", buttonTitles: ["OK"], viewController: self, completion: nil)
    }
    
    func webServiceGetResponse(comments: [Comment]) {
        if comments.count < 1{
            self.fetchedLast = true
        }
        self.commentArr.append(contentsOf: comments)
        tableView.reloadData()
    }
    
    
}

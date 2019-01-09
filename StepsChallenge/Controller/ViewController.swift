//
//  ViewController.swift
//  StepsChallenge
//
//  Created by dreams on 1/9/19.
//  Copyright © 2019 Steps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textNumberFirst: UITextField!
    @IBOutlet weak var textNumberLast: UITextField!
    
    var firstNum = 1
    var lastNum = 500
    
    var webservice: CommentService!
    
    var commentArr = [Comment]()
    
    var canceledLoad = false
    
    enum textType: Int{
        case TEXT_FIRST = 0, TEXT_LAST
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.webservice = self
    }
    
    func initUI() {
        textNumberFirst.tag = textType.TEXT_FIRST.rawValue
        textNumberLast.tag = textType.TEXT_LAST.rawValue
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(onClickCancel))
    }

    
    //MARK:- IBActions
    @IBAction func onClickLoad(_ sender: Any) {
        StepsHelper.shared.startLoader(view: self.view)
        self.canceledLoad = false
        self.webservice.fetchComments(firstNum: self.firstNum, lastNum: self.lastNum, page: 1)
    }
    
    @objc func onClickCancel(_: Any) {
        StepsHelper.shared.stopLoader()
        self.canceledLoad = true
        self.commentArr.removeAll()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueComment" {
            if let destinationVC = segue.destination as? CommentsViewController {
                destinationVC.firstNum = self.firstNum
                destinationVC.lastNum = self.lastNum
                destinationVC.commentArr = self.commentArr
            }
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case textType.TEXT_FIRST.rawValue:
            if !textField.text!.isEmpty {
                self.firstNum = Int(textField.text!)!
            }else {
                self.firstNum = 0
            }
        case textType.TEXT_LAST.rawValue:
            if !textField.text!.isEmpty {
                self.lastNum = Int(textField.text!)!
            } else {
                self.lastNum = 500
            }
            
        default:
            return false
        }
        return true
    }
}

extension ViewController: CommentService {
    func webServiceGetError(receivedError: String) {
        StepsHelper.shared.stopLoader()
        StepsHelper.shared.showAlertViewWithTitle("Error", message: "Failed to get comment list. try again later.", buttonTitles: ["OK"], viewController: self, completion: nil)
    }
    
    func webServiceGetResponse(comments: [Comment]) {
        guard !self.canceledLoad else {
            self.canceledLoad = false
            return
        }
        StepsHelper.shared.stopLoader()
        self.commentArr = comments
        if self.commentArr.count > 0 {
            self.performSegue(withIdentifier: "segueComment", sender: self)
        } else {
            StepsHelper.shared.showAlertViewWithTitle("Warning", message: "No comments to show.", buttonTitles: ["OK"], viewController: self, completion: nil)
        }
    }
}

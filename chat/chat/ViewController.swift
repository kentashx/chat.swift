//
//  ViewController.swift
//  chat
//
//  Created by 新冨健太 on 2017/10/25.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseDatabase

class ViewController: UIViewController,UITextFieldDelegate{
  
    @IBOutlet weak var contentName: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var talkText: UITextView!
    @IBOutlet weak var messageText: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBAction func onPressedSendButton(_ sender: Any) {
        guard let name = nameText.text, let message = messageText.text else {
            fatalError("no name or message")
        }
        
        let chunk = ["name": name, "message": message]
        database.childByAutoId().setValue(chunk)
        
        messageText.text = ""
    }
    
    var database:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Database.database().reference()
        database.observe(.childAdded, with: { [weak self] snapshot in
            if let chunk = snapshot.value as? Dictionary<String, AnyObject> {
                
                if let name = chunk["name"], let message = chunk["message"] {
                    self?.talkText.text.append("\(name): \(message)\n")
                    return
                }
            }
            print("Data format is invalid.")
        })
        
     
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


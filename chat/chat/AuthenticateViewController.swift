//
//  AuthenticateViewController.swift
//  chat
//
//  Created by 新冨健太 on 2017/10/25.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class AuthenticateViewController: UIViewController {
    @IBOutlet weak var mailAddressText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    //アカウント作成
    @IBAction func onTouchedSignUpButton(_ sender: Any) {
        if let email = mailAddressText.text, let password = passwordText.text {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
                self?.validateAuthenticationResult(user, error: error)
            }
        }
    }
    
    //ログイン
    @IBAction func onTouchedLogInButton(_ sender: Any) {
        if let email = mailAddressText.text, let password = passwordText.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
                self?.validateAuthenticationResult(user, error: error)
            }
        }
    }
    
    //エラー処理，画面遷移処理関数
    private func validateAuthenticationResult(_ user: User?, error: Error?) {
        if let error = error{
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "talkSegue", sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  LoginViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            self.modalPresentationStyle = .overFullScreen
            self.dismiss(animated: true, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController = TabViewController.storyboardINstance()
        }
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    public static func storyboardINstance() -> LoginViewController {
        let storyboard = UIStoryboard(name: "", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return loginViewController
    }
    
    @IBAction func loginOrRegister(_ sender: UIButton) {
        guard !(emailTF.text?.isEmpty)! else {
            showAlert(title: "Error", message: "Email cannt be empty")
            return
        }
        guard !(passwordTF.text?.isEmpty)! else {
            showAlert(title: "Error", message: "Password cannot be empty")
            return
        }
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!, completion: { (user, error) in
                if let error = error {
                    print(error)
//                    self.showAlert(title: "Error", message: "\(error.localizedDescription)")
                    Auth.auth().signIn(withEmail: self.emailTF.text!, password: self.passwordTF.text!, completion: { (user, error) in
                        if let error = error {
                            self.showAlert(title: "Error", message: "\(error.localizedDescription)")
                        } else {
                            self.dismiss(animated: true, completion: nil)
                            //self.performSegue(withIdentifier: "LoginSegue", sender: self)
                            UIApplication.shared.keyWindow?.rootViewController = TabViewController.storyboardINstance()
                        }
                    })
                } else {
                    self.showAlert(title: "Success", message: "New user created!")
                }
            })
    }
}

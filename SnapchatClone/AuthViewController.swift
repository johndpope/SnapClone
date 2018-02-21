//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Windmolders Joris on 03/01/2018.
//  Copyright © 2018 Joris. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var toggleButton: UIButton!
    
    var loginMode : Bool = true {
        didSet {
            if loginMode {
                self.actionButton.setTitle("Login", for: .normal)
                self.toggleButton.setTitle("Switch to Sign Up", for: .normal)
            }
            else {
                self.actionButton.setTitle("Sign Up", for: .normal)
                self.toggleButton.setTitle("Switch to Login", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionButtonTapped(_ sender: Any) {
        guard let email = self.emailTextField.text,
            let password = self.passwordTextField.text else {
                return;
        }
        
        if loginMode {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    print(error)
                    return
                }
                print("sign in succeeded")
                
                self.performSegue(withIdentifier: "authToSnaps", sender: nil)
            }
        }
        else {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    print(error)
                    return
                }

                print("sign up succeeded")
                self.performSegue(withIdentifier: "authToSnaps", sender: nil)
            }
        }
    }

    @IBAction func toggleButtonTapped(_ sender: Any) {
        self.loginMode = !self.loginMode
    }    
}


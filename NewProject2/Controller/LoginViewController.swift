//
//  LoginViewController.swift
//  NewProject2
//
//  Created by Diyorbek Xikmatullayev on 26/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var nameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        if let password = nameTF.text, let email = emailTF.text {
            Firestore.firestore().signInFirebase(email: email, password: password) { error, result in
                if error != nil {
                    self.showErrorAlert(message: error?.localizedDescription)
                } else {
                    UserDefaults.standard.setUserEmail(email: email)
                    UserDefaults.standard.setUserAuthorized()
                    self.vcSceneDelegate()?.setChatVCAsRootVC()
                }
            }
            
        }
        
    }
    

}

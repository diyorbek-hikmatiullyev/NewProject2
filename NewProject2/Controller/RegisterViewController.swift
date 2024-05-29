//
//  RegisterViewController.swift
//  NewProject2
//
//  Created by Diyorbek Xikmatullayev on 26/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var nameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        if let email = emailTF.text, let password = nameTF.text {
            Firestore.firestore().createUserInFirebase(email: email, password: password) { error, result in
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

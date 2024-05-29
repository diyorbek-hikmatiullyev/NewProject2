//
//  ChatViewController.swift
//  NewProject2
//
//  Created by Diyorbek Xikmatullayev on 26/05/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var writeTextTF: UITextField!
    private let dataBase = Firestore.firestore()
    private var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        title = "FireChat"
        tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        tableView.dataSource = self
        tableView.delegate = self
        loadMessagesFromFB()
    }
    
    @IBAction func sendTapped(_ sender: Any) {
        if writeTextTF.text != "" {
            let messageBody = writeTextTF.text
            let sender = Auth.auth().currentUser?.email
            
            Firestore.firestore().sendMessage(message: messageBody) { error, resposnse in
                if let e = error {
                    self.showErrorAlert(message: e.localizedDescription)
                } else {
                    self.writeTextTF.text = ""
                    print("Saved!!!!!")
            }
        }
    }
}
    
    
    
    func loadMessagesFromFB() {
        
        Firestore.firestore().listenMessage { error, message in
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.messages.removeAll()
                self.messages.append(contentsOf: message ?? [])
                
                self.tableView.reloadData()
                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
            }
        }
    }
    
    @IBAction func LogOutTapped(_ sender: Any) {
        let fireBaseAuth = Auth.auth()
        do {
            try fireBaseAuth.signOut()
            UserDefaults.standard.logOut()
            self.vcSceneDelegate()?.setLoginVCAsRootVC()
        } catch let signOutError as NSError {
            self.showErrorAlert(message: signOutError.localizedDescription)
        }
    }
    
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
        cell.configure(message: messages[indexPath.row])
        return cell
    }
    
    
}

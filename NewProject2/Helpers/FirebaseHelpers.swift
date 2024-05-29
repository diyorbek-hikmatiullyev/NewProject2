//
//  FirebaseHelpers.swift
//  NewProject2
//
//  Created by Diyorbek Xikmatullayev on 29/05/24.
//

import FirebaseAuth
import FirebaseFirestoreInternal

extension Firestore {
    func createUserInFirebase(email: String, password: String, completeHandler: @escaping (_ error: Error?,_ result: AuthDataResult?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            completeHandler(error, result)
        }
    }
    
    func signInFirebase(email: String, password: String, completeHandler: @escaping (_ error: Error?,_ result: AuthDataResult?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            completeHandler(error, result)
        }
    }
    
    func sendMessage(message: String?, complateHandler: @escaping (_ error: Error?,_ resposnse: Message?) -> ()) {
        let senderEmail = UserDefaults.standard.getUserEmail()
        //let sender = data[Constants.sender] as? String, let body = data[Constants.body] as? String
        guard let body = message else { return }
        let data: [String: Any] = [
            Constants.sender: senderEmail,
            Constants.body: body,
            Constants.date: Date().timeIntervalSince1970
        ]
       
        Firestore.firestore().collection(Constants.messages).addDocument(data: data) { error in
            if let error = error {
                complateHandler(error, nil)
                return
            }
            
            complateHandler(nil, Message(sender: senderEmail, message: body))
        }
    }
    
    func listenMessage(completeHandler: @escaping (_ error: Error?, _ message: [Message]?) -> ()) {
        Firestore.firestore().collection(Constants.messages)
            .order(by: Constants.date)
            .addSnapshotListener { querySnapshot, error in
                
                if let error = error {
                    completeHandler(error, nil)
                    return
                }
                
                var messages: [Message] = []
                
                guard let snapShotMessages = querySnapshot?.documents else {
                    completeHandler(nil, messages)
                    return
                }
                
                for doc in snapShotMessages {
                    let data = doc.data()
                    
                    guard let messageSender = data[Constants.sender] as? String, let messageBody = data[Constants.body] as? String else { continue }
                    let newMessage = Message(sender: messageSender, message: messageBody)
                    messages.append(newMessage)
                }
                completeHandler(nil, messages)
        }
    }
}


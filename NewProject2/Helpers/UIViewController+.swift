//
//  UIViewController.swift
//  NewProject2
//
//  Created by Diyorbek Xikmatullayev on 27/05/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate(from: AppStoryBoard) -> Self {
        return from.viewController(viewControllerClass: self)
    }
    
    func vcSceneDelegate() -> SceneDelegate? {
        return view.window?.windowScene?.delegate as? SceneDelegate
    }
    
    func showErrorAlert(message: String?) {
        let alert = UIAlertController(title: "error occured", message: "Error: \(message ?? "")", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
}

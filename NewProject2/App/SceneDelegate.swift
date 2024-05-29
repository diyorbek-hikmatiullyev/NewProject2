//
//  SceneDelegate.swift
//  NewProject2
//
//  Created by Diyorbek Xikmatullayev on 26/05/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        initRootVC(windowScene: windowScene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension SceneDelegate {
    
    func initRootVC(windowScene: UIWindowScene) {
        let mainNav = MainNavController.instantiate(from: .Main)
        
        if !UserDefaults.standard.isUserAuthorized() {
            setVCAsNavRootVc(nav: mainNav, rootVC: OnBoardingViewController.instantiate(from: .Main))
        }
        
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        window?.windowScene = windowScene
        window?.rootViewController = mainNav
        window?.makeKeyAndVisible()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = window
    }
    
    func setVCAsNavRootVc(nav: UINavigationController, rootVC: UIViewController) {
        nav.viewControllers.removeAll()
        nav.viewControllers = [rootVC]
    }
    
    func setChatVCAsRootVC() {
        let mainNav = MainNavController.instantiate(from: .Main)
        setVCAsNavRootVc(nav: mainNav, rootVC: ChatViewController.instantiate(from: .Main))
        window?.rootViewController = mainNav
    }
    
    func setLoginVCAsRootVC() {
        let mainNav = MainNavController.instantiate(from: .Main)
        setVCAsNavRootVc(nav: mainNav, rootVC: OnBoardingViewController.instantiate(from: .Main))
        window?.rootViewController = mainNav
    }
}

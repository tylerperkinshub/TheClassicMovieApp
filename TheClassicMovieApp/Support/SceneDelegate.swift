//
//  SceneDelegate.swift
//  TheClassicMovieApp
//
//  Created by Tyler Perkins on 9/20/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabbar()
        
        window?.makeKeyAndVisible()
    }
    
    func createHomeNC() -> UINavigationController {
        let homeVC = HomeViewController()
        homeVC.title = "On Tonight"
        let home = UIImage(systemName: "house.fill")
        homeVC.tabBarItem = UITabBarItem(title: "", image: home, selectedImage: nil)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    func createFutureNC() -> UINavigationController {
        let futureVC = FutureMoviesViewController()
        futureVC.title = "Future Movies"
        let futureMovies = UIImage(systemName: "eyeglasses")
        futureVC.tabBarItem = UITabBarItem(title: "", image: futureMovies, selectedImage: nil)
        
        return UINavigationController(rootViewController: futureVC)
    }
    
    func createUserProfileNC() -> UINavigationController {
        let userProfileVC = UserProfileViewController()
        userProfileVC.title = "Schedule"
        let scheduled = UIImage(systemName: "alarm")
        userProfileVC.tabBarItem = UITabBarItem(title: "", image: scheduled, selectedImage: nil)
        
        return UINavigationController(rootViewController: userProfileVC)
    }
    
    func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
//        let cgColor = CGColor(red: 185, green: 152, blue: 73, alpha: 1)
//        let color = UIColor(cgColor: cgColor)
        UITabBar.appearance().tintColor = .systemGray
        
        tabbar.viewControllers = [createHomeNC(), createFutureNC(), createUserProfileNC()]
        
        return tabbar
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}


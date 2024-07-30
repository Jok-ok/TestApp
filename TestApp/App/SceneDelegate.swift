import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        initializeRootViewController()
    }
}

private extension SceneDelegate {
    func initializeRootViewController() {
        let navigationController = UINavigationController()
        let viewController = ProductListModuleConfigurator.configure()
        navigationController.viewControllers = [viewController]
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}


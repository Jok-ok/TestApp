import UIKit.UIAlertController

final class ProductListRouter: IProductListRouter {
    private let navigationController: IModuleTransitionable
    
    init(navigationController: IModuleTransitionable) {
        self.navigationController = navigationController
    }
    
    func showError(title: String, message: String, cancelButtonTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: cancelButtonTitle, style: .cancel))
        
        navigationController.present(module: alertController, animated: true)
    }
}

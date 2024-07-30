import Foundation

final class ProductListRouter: IProductListRouter {
    private let navigationController: IModuleTransitionable
    
    init(navigationController: IModuleTransitionable) {
        self.navigationController = navigationController
    }
    
    func showDetailProduct() {
        
    }
}

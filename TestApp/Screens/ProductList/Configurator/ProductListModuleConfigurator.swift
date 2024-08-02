import UIKit.UIViewController

final class ProductListModuleConfigurator {
    
    struct Dependencies {
        let navigationController: IModuleTransitionable
        let productNetworkService: IProductNetworkService
    }
    
    static func configure(with dependencies: Dependencies) -> UIViewController {
        let router = ProductListRouter(navigationController: dependencies.navigationController)
        let ineractor = ProductListInteractor(productService: dependencies.productNetworkService)
        let presenter = ProductListPresenter(router: router, interactor: ineractor)
        let view = ProductListViewController(presenter: presenter)
        
        return view
    }
}

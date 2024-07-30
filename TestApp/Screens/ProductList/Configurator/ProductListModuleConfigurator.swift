import UIKit.UIViewController

final class ProductListModuleConfigurator {
    
    struct Dependencies {
        let navigationController: IModuleTransitionable
    }
    
    static func configure(with dependencies: Dependencies) -> UIViewController {
        let router = ProductListRouter(navigationController: dependencies.navigationController)
        let presenter = ProductListPresenter(router: router)
        let view = ProductListViewController(presenter: presenter)
        
        return view
    }
}

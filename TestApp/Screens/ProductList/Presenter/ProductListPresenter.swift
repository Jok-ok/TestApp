import Foundation

final class ProductListPresenter: IProductListPresenter {
    private weak var view: IProductListView?
    private let router: IProductListRouter
    
    init(router: IProductListRouter) {
        self.router = router
    }
    
    func viewDidLoad(with view: IProductListView) {
        self.view = view
        
        view.setupInitialState()
    }
}

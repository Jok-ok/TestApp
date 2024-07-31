import Foundation

final class ProductListPresenter: IProductListPresenter {
    private weak var view: IProductListView?
    private let router: IProductListRouter
    private let productService: IProductNetworkService
    
    init(router: IProductListRouter, productService: IProductNetworkService) {
        self.router = router
        self.productService = productService
    }
    
    func viewDidLoad(with view: IProductListView) {
        self.view = view
        
        view.setupInitialState()
    }
}

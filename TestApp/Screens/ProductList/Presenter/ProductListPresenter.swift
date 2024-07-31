import Foundation

final class ProductListPresenter: IProductListPresenter {
    private weak var view: IProductListView?
    private let router: IProductListRouter
    private let productService: IProductNetworkService
    
    private let staticStrings = ProductListStaticStrings()
    private var categoriesCellModels = [ProductCategoryCellModel]()
    
    init(router: IProductListRouter, productService: IProductNetworkService) {
        self.router = router
        self.productService = productService
    }
    
    func viewDidLoad(with view: IProductListView) {
        self.view = view
        
        productService.getCategories { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let categories):
                categoriesCellModels = categories.map({ categoryDTO in
                    ProductCategoryCellModel(
                        imagePath: self.staticStrings.apiURL + categoryDTO.image,
                        id: categoryDTO.menuID,
                        name: categoryDTO.name,
                        subMenuItemsText: "\(categoryDTO.subMenuCount) \(self.staticStrings.goodsText)")
                })
                view.setupInitialState(with: categoriesCellModels)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
}

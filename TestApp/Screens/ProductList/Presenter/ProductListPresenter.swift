import Foundation

final class ProductListPresenter: IProductListPresenter {
    //MARK: - Private properties
    private weak var view: IProductListView?
    private var router: IProductListRouter
    private let productService: IProductNetworkService
    
    private let staticStrings = ProductListStaticStrings()
    private var categoriesCellModels = [ProductCategoryCellModel]()
    private var productsCellModels = [ProductItemCellModel]()
    
    init(router: IProductListRouter, productService: IProductNetworkService) {
        self.router = router
        self.productService = productService
    }
    
    //MARK: - IProductListPresenter
    func viewDidLoad(with view: IProductListView) {
        self.view = view

        productService.getCategories { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let categories):
                categoriesCellModels = categories.compactMap({ categoryDTO in
                    guard categoryDTO.subMenuCount > 0 else { return nil }
                    return ProductCategoryCellModel(
                        imagePath: self.staticStrings.apiURL + categoryDTO.image,
                        id: categoryDTO.menuID,
                        name: categoryDTO.name,
                        subMenuItemsText: "\(categoryDTO.subMenuCount) \(self.staticStrings.goodsText)")
                })
                view.setupInitialState(with: categoriesCellModels, categoriesHeader: staticStrings.screenTitle, productsHeader: staticStrings.chooseCategory)
            case .failure(let error):
                showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func categoryDidTapped(_ category: ProductCategoryCellModel) {
        view?.configureProductListHeader(with: category.name)
        productService.getProducts(inCategory: category.category_id) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let products):
                productsCellModels = products.map { ProductItemCellModel(with: $0, addToShopButtonText: self.staticStrings.addToShopButtonText, imagePath: self.staticStrings.apiURL + $0.image)}
                view?.configureProductList(with: productsCellModels)
            case .failure(let error):
                showAlert(message: error.localizedDescription)
            }
        }
    }
}

//MARK: - private methods
private extension ProductListPresenter {
    func showAlert(message: String) {
        router.showError(title: staticStrings.errorTitle, message: message, cancelButtonTitle: staticStrings.cancelErrorButtonTitle)
    }
}

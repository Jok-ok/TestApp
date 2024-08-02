import Foundation

final class ProductListPresenter: IProductListPresenter {
    //MARK: - Private properties
    private weak var view: IProductListView?
    private let router: IProductListRouter
    private let interactor: IProductListInteractor
    
    private var categoriesCellModels = [ProductCategoryCellModel]()
    private var productsCellModels = [ProductItemCellModel]()
    
    init(router: IProductListRouter, interactor: IProductListInteractor) {
        self.router = router
        self.interactor = interactor
        interactor.configure(with: self)
    }
    
    //MARK: - IProductListPresenter
    func viewDidLoad(with view: IProductListView) {
        self.view = view
        view.configureInitialState()
        view.configureProductCategoriesSectionHeader(ProductListStaticStrings.screenTitle)
        view.configureProductListHeader(with: ProductListStaticStrings.chooseCategory)
        interactor.fecthCategories()
    }
    
    func categoryDidTapped(_ category: ProductCategoryCellModel) {
        view?.configureProductListHeader(with: category.name)
        interactor.fetchProducts(for: category.category_id)
    }
    
    func present(products: [ProductItemCellModel]) {
        view?.configureProductList(with: products)
    }
    
    func present(categories: [ProductCategoryCellModel]) {
        view?.configureCategoriesSection(with: categories)
    }
    
    func showAlert(message: String) {
        router.showError(title: ProductListStaticStrings.errorTitle, message: message, cancelButtonTitle: ProductListStaticStrings.cancelErrorButtonTitle)
    }
}

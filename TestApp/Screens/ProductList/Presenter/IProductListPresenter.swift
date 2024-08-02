import Foundation

protocol IProductListPresenter: AnyObject {
    func viewDidLoad(with view: IProductListView)
    func categoryDidTapped(_ category: ProductCategoryCellModel)
    func present(products: [ProductItemCellModel])
    func present(categories: [ProductCategoryCellModel])
    func showAlert(message: String)
}

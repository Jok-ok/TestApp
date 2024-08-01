import Foundation

protocol IProductListPresenter {
    func viewDidLoad(with view: IProductListView)
    func categoryDidTapped(_ category: ProductCategoryCellModel)
}

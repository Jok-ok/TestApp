import Foundation

protocol IProductListInteractor: AnyObject {
    func configure(with presenter: IProductListPresenter)
    func fetchProducts(for category: String)
    func fecthCategories()
}

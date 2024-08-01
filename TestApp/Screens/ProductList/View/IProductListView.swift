import Foundation

protocol IProductListView: AnyObject {
    func setupInitialState(with categories: [ProductCategoryCellModel], categoriesHeader: String, productsHeader: String)
    func configureProductListHeader(with header: String)
    func configureProductList(with products: [ProductItemCellModel])
}

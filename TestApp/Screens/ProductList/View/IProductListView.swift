import Foundation

protocol IProductListView: AnyObject {
    func configureInitialState()
    func configureProductListHeader(with header: String)
    func configureProductCategoriesSectionHeader(_ header: String)
    func configureProductList(with products: [ProductItemCellModel])
    func configureCategoriesSection(with categories: [ProductCategoryCellModel])
}

import Foundation

protocol IProductListView: AnyObject {
    func setupInitialState(with categories: [ProductCategoryCellModel])
}

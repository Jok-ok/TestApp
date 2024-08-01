import Foundation

final class ProductListInteractor: IProductListInteractor {
    private let productService: IProductNetworkService
    private weak var presenter: IProductListPresenter?
    
    init(productService: IProductNetworkService) {
        self.productService = productService
    }
    
    func configure(with presenter: any IProductListPresenter) {
        self.presenter = presenter
    }
    
    func fetchProducts(for category_id: String) {
        productService.getProducts(inCategory: category_id) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let products):
                let productsCellModels = products.compactMap(prepareProductToPresentation)
                presenter?.present(products: productsCellModels)
            case .failure(let error):
                presenter?.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func fecthCategories() {
        productService.getCategories { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let categories):
                let categoriesCellModels: [ProductCategoryCellModel] = categories.compactMap(prepareCategoryToPresentation)
                presenter?.present(categories: categoriesCellModels)
            case .failure(let error):
                presenter?.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func prepareProductToPresentation(_ product: ProductDTO) -> ProductItemCellModel? {
        guard let htmlDecodedProductName = String(htmlEncodedString: product.name),
              let htmlDecodedContent = String(htmlEncodedString: product.content)
        else { return nil }
        
        let model = ProductItemCellModel(
            id: product.id,
            imagePath: ProductListStaticStrings.apiURL + product.image,
            name: htmlDecodedProductName,
            content: htmlDecodedContent,
            price: product.price.replacing(".00", with: "", maxReplacements: 1) + "₽",
            weight: "/ " + (product.weight ?? "-"),
            spicy: product.spicy == "Y" ? true : false,
            addToShopButtonText: ProductListStaticStrings.addToShopButtonText
        )
        return model
    }
    
    private func prepareCategoryToPresentation(_ category: CategoryDTO) -> ProductCategoryCellModel? {
        guard category.subMenuCount > 0 else { return nil }
        
        let model = ProductCategoryCellModel(
            imagePath: ProductListStaticStrings.apiURL + category.image,
            id: category.menuID,
            name: category.name,
            subMenuItemsText: "\(category.subMenuCount) \(ProductListStaticStrings.goodsText)"
        )
        return model
    }
}

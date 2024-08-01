import UIKit

final class ProductListViewController: UICollectionViewController {
    //MARK: - Private properties
    private let presenter: IProductListPresenter
    private lazy var productCollectionView = ProductCollectionView()
    private lazy var colletionViewAdapter = DiffableCollectionViewAdapter(collectionView: productCollectionView)
    
    //MARK: - init
    init(presenter: IProductListPresenter) {
        self.presenter = presenter
        super.init(collectionViewLayout: .init())
        
        configureAppearance()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - iOS Application lifecycle
    override func loadView() {
        super.loadView()
        collectionView = productCollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad(with: self)
    }
}

//MARK: - IProductListView
extension ProductListViewController: IProductListView {
    func setupInitialState(with categories: [ProductCategoryCellModel], categoriesHeader: String, productsHeader: String) {
        setupProductCategorySection(with: categories, title: categoriesHeader)
        setupProductSection(with: productsHeader)
    }
    
    func configureProductListHeader(with header: String) {
        let headerCellModel = ProductHeaderCellModel(headerText: header)
                                                            
        let productHeader = CollectionViewHeaderFooter<ProductHeaderCell>(cellModel: headerCellModel)
                
        productCollectionView.productSection.setHeaderCell(with: productHeader)
    }
    
    func configureProductList(with products: [ProductItemCellModel]) {
        productCollectionView.productSection.items = products
        colletionViewAdapter.reloadSection(section: productCollectionView.productSection)
    }
}

//MARK: - CollectionViewConfiguration
private extension ProductListViewController {
    func setupProductCategorySection(with categories: [ProductCategoryCellModel], title: String) {

        productCollectionView.productCategoriesSection.items = categories
        
        productCollectionView.productCategoriesSection.setTapHandler(onCategoryTapped)
        
        
        colletionViewAdapter.register(cellType: ProductCategoryCell.self)
        colletionViewAdapter.register(headerFooterType: CategoriesHeaderCell.self)
        
        let categoriesListHeaderModel = CategoriesHeaderCellModel(title: title)
        
        let categoriesListHeader = CollectionViewHeaderFooter<CategoriesHeaderCell>(cellModel: categoriesListHeaderModel)

        productCollectionView.productCategoriesSection.setHeaderCell(with: categoriesListHeader)
        
        colletionViewAdapter.append(section: productCollectionView.productCategoriesSection)
    }
    
    func setupProductSection(with header: String) {
        colletionViewAdapter.register(cellType: ProductItemCell.self)
        colletionViewAdapter.register(headerFooterType: ProductHeaderCell.self)
        
        configureProductListHeader(with: header)
        
        colletionViewAdapter.append(section: productCollectionView.productSection)
    }
}

//MARK: - Actions
private extension ProductListViewController {
    func onCategoryTapped(_ category: ProductCategoryCellModel) {
        presenter.categoryDidTapped(category)
    }
}


//MARK: - Appearance
private extension ProductListViewController {
    func configureAppearance() {
        collectionView.backgroundColor = .background
    }
}

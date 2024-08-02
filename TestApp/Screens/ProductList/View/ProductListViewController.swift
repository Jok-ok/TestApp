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
    func configureInitialState() {
        setupProductCategorySection()
        setupProductSection()
    }
    
    func configureProductListHeader(with header: String) {
        let headerCellModel = ProductHeaderCellModel(headerText: header)
        let productHeader = CollectionViewHeaderFooter<ProductHeaderCell>(cellModel: headerCellModel)
        productCollectionView.productSection.setHeaderCell(with: productHeader)
    }
    
    func configureProductCategoriesSectionHeader(_ header: String) {
        let categoriesListHeaderModel = CategoriesHeaderCellModel(title: header)
        let categoriesListHeader = CollectionViewHeaderFooter<CategoriesHeaderCell>(cellModel: categoriesListHeaderModel)
        productCollectionView.productCategoriesSection.setHeaderCell(with: categoriesListHeader)
    }
    
    func configureCategoriesSection(with categories: [ProductCategoryCellModel]) {
        productCollectionView.productCategoriesSection.items = categories
        colletionViewAdapter.reloadSection(section: productCollectionView.productCategoriesSection)
    }
    
    func configureProductList(with products: [ProductItemCellModel]) {
        productCollectionView.productSection.items = products
        colletionViewAdapter.reloadSection(section: productCollectionView.productSection)
    }
}

//MARK: - CollectionViewConfiguration
private extension ProductListViewController {
    func setupProductCategorySection() {
        colletionViewAdapter.register(cellType: ProductCategoryCell.self)
        colletionViewAdapter.register(headerFooterType: CategoriesHeaderCell.self)

        productCollectionView.productCategoriesSection.setTapHandler(onCategoryTapped)

        colletionViewAdapter.append(section: productCollectionView.productCategoriesSection)
    }
    
    func setupProductSection() {
        colletionViewAdapter.register(cellType: ProductItemCell.self)
        colletionViewAdapter.register(headerFooterType: ProductHeaderCell.self)
        
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

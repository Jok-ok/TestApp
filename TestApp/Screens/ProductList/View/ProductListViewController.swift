import UIKit

final class ProductListViewController: UICollectionViewController {
    private let presenter: IProductListPresenter
    private lazy var productCollectionView = ProductCollectionView()
    private lazy var colletionViewAdapter = CollectionViewAdapter(collectionView: productCollectionView)
    
    init(presenter: IProductListPresenter) {
        self.presenter = presenter
        super.init(collectionViewLayout: .init())
        
        configureAppearance()
    }
    
    override func loadView() {
        super.loadView()
        collectionView = productCollectionView
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad(with: self)
    }
}

extension ProductListViewController: IProductListView {
    func setupInitialState() {
        
    }
}

private extension ProductListViewController {
    func configureAppearance() {
        
    }
}

private extension ProductListViewController {
    
}

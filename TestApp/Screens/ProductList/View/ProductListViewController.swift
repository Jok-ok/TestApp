import UIKit

final class ProductListViewController: UIViewController {
    private let presenter: IProductListPresenter
    
    init(presenter: IProductListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
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


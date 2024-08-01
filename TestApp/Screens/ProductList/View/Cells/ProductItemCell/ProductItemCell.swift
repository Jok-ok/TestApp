import UIKit

final class ProductItemCell: UICollectionViewCell, CellConfigurableProtocol, CellIdentifiableProtocol {
    //MARK: - Private properties
    private lazy var productView = ProductView()
    private lazy var addToShopButton = UIButton()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - CellConfigurableProtocol
    typealias Model = ProductItemCellModel
    
    override func prepareForReuse() {
        productView.prepareForReuse()
    }
    
    func configure(with model: ProductItemCellModel) {
        productView.configure(with: model)
        addToShopButton.setTitle(model.addToShopButtonText, for: .normal)
    }
}

//MARK: - Appearance
private extension ProductItemCell {
    func configureAppearance() {
        
        configureAddToShopButtonAppearance()
        addSubviews()
        
        constraintProductView()
        constraintAddToShopButton()
    }
    
    func addSubviews() {
        contentView.addSubview(productView)
        contentView.addSubview(addToShopButton)
    }
    
    //MARK: - UI configuration
    func configureAddToShopButtonAppearance() {
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = .init(top: 15, leading: 20, bottom: 15, trailing: 20)
        configuration.baseBackgroundColor = .accent
        configuration.background.cornerRadius = 10
        addToShopButton.configuration = configuration
    }
    
    func constraintProductView() {
        productView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productView.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
    
    func constraintAddToShopButton() {
        addToShopButton.translatesAutoresizingMaskIntoConstraints = false
        
        addToShopButton.setContentHuggingPriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            addToShopButton.centerYAnchor.constraint(equalTo: productView.bottomAnchor),
            addToShopButton.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            addToShopButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            addToShopButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addToShopButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}


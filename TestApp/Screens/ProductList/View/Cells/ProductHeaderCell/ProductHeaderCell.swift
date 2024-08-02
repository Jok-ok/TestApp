import UIKit

final class ProductHeaderCell: UICollectionReusableView, CellIdentifiableProtocol, CellConfigurableProtocol {
    typealias Model = ProductHeaderCellModel
    
    private lazy var label = UILabel()
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - CellConfigurableProtocol
    func configure(with model: ProductHeaderCellModel) {
        label.text = model.headerText
    }
    
}

//MARK: - Appearance
private extension ProductHeaderCell {
    func configureAppearance() {
        configureLabelAppearance()
        
        addSubviews()
        
        constraintLabel()
    }
    
    func addSubviews() {
        addSubview(label)
    }
    
    func configureLabelAppearance() {
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = FontLib.sectionHeader
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
    }
    
    func constraintLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

    }
}

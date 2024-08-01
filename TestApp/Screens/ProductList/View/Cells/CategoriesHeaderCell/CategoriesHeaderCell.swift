import UIKit

final class CategoriesHeaderCell: UICollectionReusableView, CellIdentifiableProtocol, CellConfigurableProtocol {
    typealias Model = CategoriesHeaderCellModel
    
    private lazy var label = UILabel()
    private lazy var logoImage = UIImageView(image: .logo)
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
    func configure(with model: CategoriesHeaderCellModel) {
        label.text = model.title
    }
    
}

//MARK: - Appearance
private extension CategoriesHeaderCell {
    func configureAppearance() {
        configureLabelAppearance()
        
        addSubviews()
        
        constraintLabel()
        constraintLogoImageView()
    }
    
    func addSubviews() {
        addSubview(label)
        addSubview(logoImage)
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
        let offset = 10.0
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: offset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

    }
    
    func constraintLogoImageView() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        logoImage.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            logoImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoImage.widthAnchor.constraint(equalTo: logoImage.heightAnchor),
            logoImage.topAnchor.constraint(equalTo: topAnchor),
            logoImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

    }
}

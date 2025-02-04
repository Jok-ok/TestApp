import UIKit

final class ProductCategoryCell: UICollectionViewCell, CellConfigurableProtocol, CellIdentifiableProtocol {
    //MARK: - Private properties
    private lazy var cellImageView = UIImageView()
    private lazy var categoryLabel = UILabel()
    private lazy var productCountLabel = UILabel()
    private lazy var activityIndicator = UIActivityIndicatorView(style: .medium)
    private var imageConstraint: NSLayoutConstraint?
    
    override var isSelected: Bool {
        didSet{
            if isSelected {
                UIView.animate(withDuration: 0.3) {
                    self.contentView.backgroundColor = .accent
                }
            }
            else {
                UIView.animate(withDuration: 0.3) {
                    self.contentView.backgroundColor = .categoryCellBackground
                }
            }
        }
    }
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureAppearance()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Cell configurable protocol
    typealias Model = ProductCategoryCellModel
    
    func configure(with model: ProductCategoryCellModel) {
        cellImageView.image = nil
        activityIndicator.startAnimating()
        categoryLabel.text = model.name
        productCountLabel.text = model.subMenuItemsText
        downloadImageIfNeeded(for: model)
    }
}
//MARK: - Image downloading
private extension ProductCategoryCell {
    func downloadImageIfNeeded(for model: ProductCategoryCellModel) {
        if model.image == nil {
            loadImage(from: model.imagePath, for: model)
        } else {
            guard let image = model.image else { return }
            cellImageView.image = image
            activityIndicator.stopAnimating()
        }
    }
    
    func loadImage(from path: String, for model: ProductCategoryCellModel) {
        cellImageView.downloaded(from: path, contentMode: .scaleAspectFill, compressionFactor: 0.2) { [weak self] image in
            self?.activityIndicator.stopAnimating()
            model.image = image
        }
    }
}

//MARK: - Appearance
private extension ProductCategoryCell {
    func configureAppearance() {
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        contentView.backgroundColor = .categoryCellBackground
        
        configureCellImageViewAppearance()
        configureCategoryLabelAppearance()
        configureProductCountLabelAppearance()
        configureProductActivityIndicatorAppearance()
        
        addSubviews()
        
        constraintCellImageView()
        constraintCategoryLabel()
        constraintProductCountLabel()
        constraintActivityIndicator()
    }
    
    func addSubviews() {
        contentView.addSubview(cellImageView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(productCountLabel)
        contentView.addSubview(activityIndicator)
    }
    
    //MARK: - UI configuration
    func configureCategoryLabelAppearance() {
        categoryLabel.textColor = .font
        categoryLabel.font = FontLib.cellTitile
        categoryLabel.textAlignment = .center
        categoryLabel.numberOfLines = 2
        categoryLabel.adjustsFontSizeToFitWidth = true
        categoryLabel.minimumScaleFactor = 0.5
    }
    
    func configureProductCountLabelAppearance() {
        productCountLabel.textColor = .secondaryLabel
        productCountLabel.font = FontLib.cellSubtitle
        productCountLabel.textAlignment = .center
    }
    
    func configureProductActivityIndicatorAppearance() {
        activityIndicator.hidesWhenStopped = true
    }
    
    func configureCellImageViewAppearance() {
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.clipsToBounds = true
    }
    
    //MARK: - Constraints
    func constraintCellImageView() {
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.55),
        ])
    }
    
    func constraintCategoryLabel() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topOffset = 10.0
        let offsets = 6.0
        
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: offsets),
            categoryLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -offsets),
            categoryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryLabel.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: topOffset),
        ])
    }
    
    func constraintProductCountLabel() {
        productCountLabel.translatesAutoresizingMaskIntoConstraints = false
        let bottomOffset = 10.0
        let topOffset = 10.0
        let offset = 6.0
        
        productCountLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            productCountLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: offset),
            productCountLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -offset),
            productCountLabel.topAnchor.constraint(greaterThanOrEqualTo: categoryLabel.bottomAnchor, constant: topOffset),
            productCountLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            productCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -bottomOffset)
        ])
    }
    func constraintActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.leadingAnchor.constraint(equalTo: cellImageView.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: cellImageView.trailingAnchor),
            activityIndicator.topAnchor.constraint(equalTo: cellImageView.topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: cellImageView.bottomAnchor)
        ])
    }
}

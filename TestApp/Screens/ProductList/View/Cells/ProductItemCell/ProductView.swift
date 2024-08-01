import UIKit

final class ProductView: UIView {
    private lazy var productNameLabel = UILabel()
    private lazy var contentLabel = UILabel()
    private lazy var costWeightStackView: UIStackView = {
        UIStackView(arrangedSubviews: [costLabel, weightLabel])
    }()
    private lazy var activityIndicator = UIActivityIndicatorView(style: .medium)
    private lazy var productImageView = UIImageView()
    private lazy var costLabel = UILabel()
    private lazy var weightLabel = UILabel()
    private lazy var spicyImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareForReuse() {
        productImageView.image = nil
        productNameLabel.text = nil
        contentLabel.text = nil
        costLabel.text = nil
        weightLabel.text = nil
        spicyImageView.image = nil
    }
    
    func configure(with model: ProductItemCellModel) {
        productImageView.image = nil
        activityIndicator.startAnimating()

        productNameLabel.text = model.name
        contentLabel.text = model.content
        costLabel.text = model.price
        weightLabel.text = model.weight
        downloadImageIfNeeded(for: model)
        spicyImageView.image = model.spicy ? .pepper : nil
    }
}

private extension ProductView {
    func downloadImageIfNeeded(for model: ProductItemCellModel) {
        if model.image == nil {
            loadImage(from: model.imagePath, for: model)
        } else {
            guard let image = model.image else {
                activityIndicator.stopAnimating()
                return
            }
            productImageView.image = image
            activityIndicator.stopAnimating()
        }

    }
    
    func loadImage(from path: String, for model: ProductItemCellModel) {
        productImageView.downloaded(from: path, contentMode: .scaleAspectFill, compressionFactor: 0.2) { [weak self] image in
            self?.activityIndicator.stopAnimating()
            model.image = image
        }
    }
}

private extension ProductView {
    func configureAppearance() {
        backgroundColor = .productCellBackground
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        addSubviews()
        
        configureViewsAppearance()
        
        constraintProductNameLabel()
        constraintContentLabel()
        constraintCostWeightStackView()
        constraintActivityIndicator()
        constraintProductImageView()
        constraintSpicyImageView()
    }
    
    func configureViewsAppearance() {
        configureProductNameLabelAppearance()
        configureContentLabelAppearance()
        configureCostWeightStackViewAppearance()
        configureCostLabelAppearance()
        configureWeightLabelAppearance()
        configureActivityIndicatorAppearance()
        configureProductImageViewAppearance()
    }
    
    func addSubviews() {
        addSubview(productNameLabel)
        addSubview(contentLabel)
        addSubview(costWeightStackView)
        addSubview(activityIndicator)
        addSubview(productImageView)
        addSubview(spicyImageView)
    }
    
    func configureProductNameLabelAppearance() {
        productNameLabel.font = FontLib.cellTitile
        productNameLabel.textAlignment = .center
        productNameLabel.textColor = .font
        productNameLabel.adjustsFontSizeToFitWidth = true
        productNameLabel.numberOfLines = 0
    }
    
    func configureContentLabelAppearance() {
        contentLabel.font = FontLib.cellSubtitle
        contentLabel.textAlignment = .center
        contentLabel.numberOfLines = 0
        contentLabel.textColor = .secondaryLabel
        contentLabel.lineBreakStrategy = .hangulWordPriority
    }
    
    func configureCostWeightStackViewAppearance() {
        costWeightStackView.axis = .horizontal
        costWeightStackView.alignment = .center
        costWeightStackView.spacing = 5
        costWeightStackView.distribution = .fillEqually
    }
    
    func configureCostLabelAppearance() {
        costLabel.font = FontLib.cellTitile
        costLabel.textAlignment = .right
        costLabel.textColor = .font
    }
    
    func configureWeightLabelAppearance() {
        weightLabel.font = FontLib.cellSubtitle
        weightLabel.textAlignment = .left
        weightLabel.textColor = .secondaryLabel
    }
    
    func configureActivityIndicatorAppearance(){
        activityIndicator.hidesWhenStopped = true
    }
    
    func configureProductImageViewAppearance() {
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
    }
    
    func constraintProductNameLabel() {
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let offset = 10.0
        productNameLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        NSLayoutConstraint.activate([
            productNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
            productNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: offset),
            productNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func constraintContentLabel() {
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        let offset = 10.0
        
        contentLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
            contentLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: offset),
            contentLabel.bottomAnchor.constraint(lessThanOrEqualTo: costWeightStackView.topAnchor, constant: -offset),
            contentLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func constraintCostWeightStackView() {
        costWeightStackView.translatesAutoresizingMaskIntoConstraints = false
        let offset = 10.0

        NSLayoutConstraint.activate([
            costWeightStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset),
            costWeightStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
            costWeightStackView.bottomAnchor.constraint(lessThanOrEqualTo: productImageView.topAnchor, constant: -offset)
        ])
    }
    
    func constraintActivityIndicator(){
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            activityIndicator.topAnchor.constraint(equalTo: productImageView.topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor),
        ])
    }
    
    func constraintSpicyImageView() {
        spicyImageView.translatesAutoresizingMaskIntoConstraints = false
        let offset = 10.0
        
        NSLayoutConstraint.activate([
            spicyImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset),
            spicyImageView.bottomAnchor.constraint(equalTo: productImageView.topAnchor, constant: -offset),
        ])
    }
    
    func constraintProductImageView() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        
        productImageView.setContentHuggingPriority(.required, for: .vertical)
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            productImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            productImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }
}

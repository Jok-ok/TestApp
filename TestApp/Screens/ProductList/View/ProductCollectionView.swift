import UIKit

final class ProductCollectionView: UICollectionView {
    //MARK: - public properties
    lazy var productCategoriesSection = CollectionViewSection<ProductCategoryCell>(sectionId: ProductListSections.categories.rawValue)
    lazy var productSection = CollectionViewSection<ProductItemCell>(sectionId: ProductListSections.products.rawValue, allowSelection: false)
    
    //MARK: - init
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        configureAppearance()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Appearance & CollectionViewLayout
private extension ProductCollectionView {
    func configureAppearance() {
        collectionViewLayout = makeLayout()
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            
            if sectionIndex == 0 {
                return self?.makeProductCategoriesSection()
            }
            if sectionIndex == 1 {
                return self?.makeProductListSection()
            }
            
            return nil
        }
        
        return layout
    }
    
    func makeProductCategoriesSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .estimated(200),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.edgeSpacing = .init(leading: .fixed(10), top: .fixed(5), trailing: .fixed(10), bottom: .fixed(5))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .estimated(frame.width),
                heightDimension: .estimated(160)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(50)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading)
        
        headerItem.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        section.boundarySupplementaryItems = [headerItem]
        
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
    func makeProductListSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.38)
            ),
            repeatingSubitem: item, count: 2
        )
        
        group.interItemSpacing = .fixed(22)
    
        let section = NSCollectionLayoutSection(group: group)
        
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(50)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading)
        
        headerItem.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        section.boundarySupplementaryItems = [headerItem]
        
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        
        return section
    }
}

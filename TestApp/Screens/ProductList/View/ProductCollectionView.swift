import UIKit

final class ProductCollectionView: UICollectionView {
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        configureAppearance()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
                return self?.makeProductCategoriesSection()
            }
            
            return nil
        }
        
        return layout
    }
    
    func makeProductCategoriesSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.3),
                heightDimension: .fractionalHeight(0.2)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.25)
            ),
            subitems: [item]
        )
        
        group.interItemSpacing = .fixed(5)
    
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
    func makeProductListSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.4),
                heightDimension: .fractionalHeight(0.4)
            )
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(400)
            ),
            subitems: [item]
        )
        group.interItemSpacing = .fixed(10)
    
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
}

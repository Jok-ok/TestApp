import UIKit.UIFont

enum FontLib {
    static let title = UIFont.systemFont(ofSize: 24, weight: .bold)
    static let sectionHeader = UIFont.systemFont(ofSize: 32, weight: .bold)
    
    static let cellTitile = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static let cellSubtitle = UIFont.systemFont(ofSize: 12, weight: .regular)
    
    static let cellProductPrice = cellTitile
    static let cellProductWeight = cellSubtitle
    
    static let buttonText = UIFont.systemFont(ofSize: 18, weight: .regular)
}

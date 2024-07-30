import UIKit

protocol IModuleTransitionable: AnyObject {
    func push(module: UIViewController, animated: Bool)

    func pop(animated: Bool)

    func present(module: UIViewController, animated: Bool)

    func dismiss()

}
// MARK: - UIViewController
extension IModuleTransitionable where Self: UIViewController {
    func push(module: UIViewController, animated: Bool) {
        navigationController?.pushViewController(module, animated: true)
    }

    func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }

    func present(module: UIViewController, animated: Bool) {
        self.present(module, animated: true)
    }

    func dismiss() {
        self.dismiss(animated: true)
    }
}
// MARK: - UINavigationController
extension IModuleTransitionable where Self: UINavigationController {
    func push(module: UIViewController, animated: Bool) {
        pushViewController(module, animated: true)
    }

    func pop(animated: Bool) {
        popViewController(animated: animated)
    }

    func present(module: UIViewController, animated: Bool) {
        present(module, animated: true)
    }

    func dismiss() {
        dismiss(animated: true)
    }
}

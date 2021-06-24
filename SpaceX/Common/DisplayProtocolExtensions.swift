import UIKit

extension DisplayProtocol {
    func displayError(_ error: Error) {
//        (self as? UIViewController)?.showAlert(title: "Error", message: error.localizedDescription)
        print("Error: \(error.localizedDescription)")
    }
}

extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

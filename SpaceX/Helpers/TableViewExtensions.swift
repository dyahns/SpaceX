import UIKit

extension UITableView {
    func addBackView(text: String?) {
        guard let text = text else {
            backgroundView = nil
            return
        }
        
        let backview = UIView()
        self.backgroundView = backview
        
        // prevent the view jumping after scroll
        backview.frame.origin.y = 0
        
        let labelFrame = CGRect(x: 20, y: 0, width: backview.frame.width - 40, height: backview.frame.height).inset(by: safeAreaInsets)
        let label = UILabel(text: text, textAlignment: .center, font: UIFont.systemFont(ofSize: 16, weight: .medium), colour: .darkGray, frame: labelFrame)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        backview.addSubview(label)
    }
}

extension UILabel {
    convenience init(text: String, textAlignment: NSTextAlignment, font: UIFont, colour: UIColor, frame: CGRect) {
        self.init(frame: frame)
        self.backgroundColor = .clear
        self.textColor = colour
        self.font = font
        self.textAlignment = textAlignment
        self.text = text
    }
}

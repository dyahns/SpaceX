import UIKit

class LaunchCell: UITableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.bounds = CGRect(x: 0, y: 0, width: 32, height: 32);
    }
}

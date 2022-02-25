import UIKit

final class MenuTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    internal func configure(name:String){
        self.nameLabel.text = name
    }
}

import UIKit

final class CustomTableViewCell: UITableViewCell {
    @IBOutlet private weak var bookImageV: UIImageView!
    @IBOutlet private weak var bookNameLabel: UILabel!
    
    internal func configure(model:CategoryModel){
        self.bookNameLabel.text = model.title
    }
}

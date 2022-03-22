import UIKit

final class SearchBookTableViewCell: UITableViewCell {
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    internal func configure(model:VolumeInfo){
        self.titleLabel.text = model.title
        if let author = model.authors?[0]{
            self.authorLabel.text = author
        }
    }
}

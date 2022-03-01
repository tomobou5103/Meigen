import UIKit

final class MenuTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    internal func configure(name:String){
        self.nameLabel.text = name
    }
    internal func firstCellConfigure(){
        self.nameLabel.text = "カテゴリーを追加する"
        self.nameLabel.textColor = .white
        self.backgroundColor = .systemBlue
    }
    override func prepareForReuse() {
        self.backgroundColor = .white
        self.nameLabel.textColor = .black
    }
}

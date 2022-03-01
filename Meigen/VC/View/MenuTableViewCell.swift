import UIKit

final class MenuTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    internal func configure(categoryId:String){
        
        self.nameLabel.text = convertFromCategoryIdToTitle(id: categoryId)
    }
    internal func firstCellConfigure(){
        self.nameLabel.text = "カテゴリーを追加する"
        self.nameLabel.textColor = .white
        self.backgroundColor = .systemBlue
    }
    private func convertFromCategoryIdToTitle(id:String)->String{
        let title = id.components(separatedBy: "&")
        return title[0]
    }
    override func prepareForReuse() {
        self.backgroundColor = .white
        self.nameLabel.textColor = .black
    }
}

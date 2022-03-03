import UIKit

final class MenuTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var renameButton: UIButton!
    @IBAction func renameAction(_ sender: Any) {
    }
    
    internal func configure(categoryId:String,index:Int){
        self.renameButton.tag = index
        self.nameLabel.text = convertFromCategoryIdToTitle(id: categoryId)
    }
    internal func firstCellConfigure(){
        self.nameLabel.text = "カテゴリを追加する"
        self.nameLabel.textColor = .white
        self.backgroundColor = .systemBlue
        self.renameButton.isHidden = true
    }
    internal func secondCellConfigure(){
        self.nameLabel.text = "カテゴリを削除する"
        self.nameLabel.textColor = .white
        self.backgroundColor = .systemGray2
        self.renameButton.isHidden = true
    }
    private func convertFromCategoryIdToTitle(id:String)->String{
        let title = id.components(separatedBy: "&")
        return title[0]
    }
    override func prepareForReuse() {
        self.backgroundColor = .white
        self.nameLabel.textColor = .black
        self.renameButton.isHidden = false
    }
}

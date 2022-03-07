import UIKit
protocol MenuTableViewCellDelegate:AnyObject{
    func launchAlert(index:Int)
}
final class MenuTableViewCell: UITableViewCell {
    
    internal weak var delegate:MenuTableViewCellDelegate?
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var renameButton: UIButton!
    @IBAction func renameAction(_ sender: Any) {
        delegate?.launchAlert(index:self.renameButton.tag)
    }
    internal func configure(categoryId:String,index:Int,delegate:MenuTableViewCellDelegate){
        self.renameButton.tag = index
        self.nameLabel.text = convertFromCategoryIdToTitle(id: categoryId)
        self.delegate = delegate
    }
    internal func firstCellConfigure(){
        self.nameLabel.text = "カテゴリを追加する"
        self.nameLabel.textColor = .white
        self.backgroundColor = .systemBlue
        self.renameButton.isHidden = true
        addCorner(cell: self)
    }
    private func convertFromCategoryIdToTitle(id:String)->String{
        let title = id.components(separatedBy: "&")
        return title[0]
    }
    private func addCorner(cell:UITableViewCell){
        cell.layer.cornerRadius = 10
    }
    override func prepareForReuse() {
        self.backgroundColor = .white
        self.nameLabel.textColor = .black
        self.renameButton.isHidden = false
        self.layer.cornerRadius = 0
    }
}

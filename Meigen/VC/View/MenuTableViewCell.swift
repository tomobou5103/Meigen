import UIKit
protocol MenuTableViewCellDelegate:AnyObject{
    func launchRenameAlert(index:Int)
    func launchRemoveAlert(index:Int)
}
final class MenuTableViewCell: UITableViewCell {
    
    internal weak var delegate:MenuTableViewCellDelegate?
    private var index:Int = 0
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var renameButton: UIButton!
    @IBOutlet private weak var removeButton: UIButton!
    @IBAction func renameAction(_ sender: Any) {
        delegate?.launchRenameAlert(index:index)
    }
    @IBAction func removeAction(_ sender: Any) {
        delegate?.launchRemoveAlert(index:index)
    }
    internal func configure(categoryId:String,index:Int,delegate:MenuTableViewCellDelegate){
        self.index = index
        self.nameLabel.text = convertFromCategoryIdToTitle(id: categoryId)
        self.delegate = delegate
    }
    internal func firstCellConfigure(){
        self.nameLabel.text = "カテゴリを追加する"
        self.nameLabel.textColor = .white
        self.backgroundColor = .systemBlue
        self.renameButton.isHidden = true
        self.removeButton.isHidden = true
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
        self.removeButton.isHidden = false
        self.layer.cornerRadius = 0

        
    }
}

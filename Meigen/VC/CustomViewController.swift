import UIKit
final class CustomViewController: UIViewController {
//MARK: -Property
    private let CustomTableViewCellId = "CustomTableViewCell"
    private let toAddMeigenVCId = "showAddMeigen"
    private let toDetailVCId = "showDetail"
    private var categoryId = ""
    private var categoryIndex = 0
    private var model:[MeigenModel]?
    private var modelIndex = 0
    private weak var delegate:ReloadTopViewControllerDelegate?
//MARK: -IBOutlet
    @IBOutlet private weak var tableV: UITableView!{didSet{tableViewConfigure()}}
//MARK: -IBAction
    @IBAction private func showSelectVCButton(_ sender: Any) {
        performSegue(withIdentifier: toAddMeigenVCId, sender: nil)
    }
//MARK: -Configure
    private func tableViewConfigure(){
        tableV.delegate = self
        tableV.dataSource = self
        tableV.register(UINib(nibName: CustomTableViewCellId, bundle: nil), forCellReuseIdentifier: CustomTableViewCellId)
    }
    internal func configure(model:[MeigenModel],categoryId:String,categoryIndex:Int,delegate:ReloadTopViewControllerDelegate){
        self.model = model
        self.categoryId = categoryId
        self.categoryIndex = categoryIndex
        self.title = convertFromIdToTitle(id: categoryId)
        self.delegate = delegate

    }
    private func convertFromIdToTitle(id:String)->String{
        let title = id.components(separatedBy: "&")
        return title[0]
    }
//MARK: -LifeCycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toAddMeigenVCId{
            let nextVC = segue.destination as? AddMeigenViewController
            nextVC?.configure(categoryId: self.categoryId,categoryIndex:self.categoryIndex, searchedBookModel: nil,delegate:self.delegate)
        }else if segue.identifier == toDetailVCId{
            let nextVC = segue.destination as? DetailViewController
            guard let meigenModel = model?[modelIndex]else{return}
            nextVC?.configure(model:meigenModel)
        }
    }
}
//MARK: -Extension
extension CustomViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let model  = self.model?[indexPath.row],
            let cell = tableV.dequeueReusableCell(withIdentifier: CustomTableViewCellId)as? CustomTableViewCell
        else{
            return UITableViewCell()
        }
        cell.configure(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.modelIndex = indexPath.row
        self.performSegue(withIdentifier: toDetailVCId, sender: nil)
    }
}

import UIKit
protocol DetailViewControllerDelegate:AnyObject{
    func removeCell(index:IndexPath)
    func reloadTableView()
}
final class CustomViewController: UIViewController {
//MARK: -Property
    private let CustomTableViewCellId = "CustomTableViewCell"
    private let toDetailVCId = "showDetail"
    private var categoryId = ""
    private var categoryIndex = 0
    private var model:[MeigenModel]?
    private var modelIndex:IndexPath?
//MARK: -IBOutlet
    @IBOutlet private weak var tableV: UITableView!{didSet{tableViewConfigure()}}
//MARK: -Configure
    private func tableViewConfigure(){
        tableV.delegate = self
        tableV.dataSource = self
        tableV.register(UINib(nibName: CustomTableViewCellId, bundle: nil), forCellReuseIdentifier: CustomTableViewCellId)
    }
    internal func configure(model:[MeigenModel]?,categoryId:String,categoryIndex:Int){
        self.model = model
        self.categoryId = categoryId
        self.categoryIndex = categoryIndex
        self.title = convertFromIdToTitle(id: categoryId)
    }
    private func convertFromIdToTitle(id:String)->String{
        let title = id.components(separatedBy: "&")
        return title[0]
    }
//MARK: -LifeCycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toDetailVCId{
            let nextVC = segue.destination as? DetailViewController
            guard let meigenModel = model?[modelIndex!.row]else{return}
            nextVC?.configure(model:meigenModel,index: self.modelIndex!,delegate: self)
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
        self.modelIndex = indexPath
        self.performSegue(withIdentifier: toDetailVCId, sender: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
extension CustomViewController:DetailViewControllerDelegate{
    func removeCell(index:IndexPath) {
        self.model?.remove(at: modelIndex!.row)
        self.tableV.deleteRows(at: [index as IndexPath], with: .automatic)
        self.tableV.reloadData()
    }
    func reloadTableView(){
        self.tableV.reloadData()
    }
}

import UIKit
final class CustomViewController: UIViewController {
//MARK: -Property
    private let CustomTableViewCellId = "CustomTableViewCell"
    private let CustomVCtoSlectSegueId = "showSelect"
    private var categoryId = ""
    private var model:[MeigenModel]?
//MARK: -IBOutlet
    @IBOutlet private weak var tableV: UITableView!{didSet{tableViewConfigure()}}
//MARK: -IBAction
    @IBAction private func showSelectVCButton(_ sender: Any) {
//        performSegue(withIdentifier: CustomVCtoSlectSegueId, sender: nil)
        performSegue(withIdentifier: "showAddMeigen", sender: nil)
    }
//MARK: -Configure
    private func tableViewConfigure(){
        tableV.delegate = self
        tableV.dataSource = self
        tableV.register(UINib(nibName: CustomTableViewCellId, bundle: nil), forCellReuseIdentifier: CustomTableViewCellId)
    }
    internal func configure(model:[MeigenModel],categoryId:String){
        self.model = model
        self.categoryId = categoryId
        self.title = convertFromIdToTitle(id: categoryId)
    }
    private func convertFromIdToTitle(id:String)->String{
        let title = id.components(separatedBy: "&")
        return title[0]
    }
//MARK: -LifeCycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CustomVCtoSlectSegueId{
            let nextVC = segue.destination as? SelectViewController
            nextVC?.configure(categoryId: self.categoryId)
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
}

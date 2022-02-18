import UIKit
final class CustomViewController: UIViewController {
//MARK: -Property
    private let CustomTableViewCellId = "CustomTableViewCell"
    private let CustomVCtoSlectSegueId = "showSelect"
    private var categoryIndex = 0
    private var model:[CategoryModel]?
//MARK: -IBOutlet
    @IBOutlet private weak var tableV: UITableView!{didSet{tableViewConfigure()}}
//MARK: -IBAction
    @IBAction private func showSelectVCButton(_ sender: Any) {
        performSegue(withIdentifier: CustomVCtoSlectSegueId, sender: nil)
    }
//MARK: -Configure
    private func tableViewConfigure(){
        tableV.delegate = self
        tableV.dataSource = self
        tableV.register(UINib(nibName: CustomTableViewCellId, bundle: nil), forCellReuseIdentifier: CustomTableViewCellId)
    }
    internal func configure(model:[CategoryModel],index:Int,title:String){
        self.model = model
        self.categoryIndex = index
        self.title = title
    }
//MARK: -LifeCycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CustomVCtoSlectSegueId{
            let nextVC = segue.destination as? SelectViewController
            nextVC?.configure(categoryIndex: self.categoryIndex)
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

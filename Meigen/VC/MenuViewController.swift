import UIKit
protocol MenuViewControllerDelegate:AnyObject{
    func reloadView()
}
final class MenuViewController: UIViewController {
//MARK: -Property
    private let cellId = "MenuTableViewCell"
    private var categories:[String] = []
    private var text = ""
    internal weak var delegate:MenuViewControllerDelegate?
//MARK: -IBOutlet
    @IBOutlet private weak var menuView: UIView!
    @IBOutlet private weak var tableV: UITableView!{didSet{tableViewConfigure()}}
//MARK: -Configure
    private func tableViewConfigure(){
        self.tableV.delegate = self
        self.tableV.dataSource = self
        self.tableV.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    internal func configure(categories:[String],delegate:MenuViewControllerDelegate){
        self.categories = categories
        self.delegate = delegate
    }
    private func addCategoryUd(){
        let ud = UserDefaults.standard
        ud.set(categories, forKey: "categories")
    }
//MARK: -LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let menuPos = self.menuView.layer.position
        self.menuView.layer.position.x = -self.menuView.frame.width
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.menuView.layer.position.x = menuPos.x
        },
            completion: { bool in
        })
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 1 {
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.menuView.layer.position.x = -self.menuView.frame.width
                },
                    completion: { bool in
                        self.dismiss(animated: true, completion: nil)
                }
                )
            }
        }
    }
}
//MARK: -Extension
extension MenuViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
            return categories.count
        }else{
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableV.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MenuTableViewCell
        else{
            return UITableViewCell()
        }
        switch indexPath.section{
        case 0:
            cell.firstCellConfigure()
        case 1:
            cell.secondCellConfigure()
        case 2:
            cell.configure(categoryId: categories[indexPath.row], index: indexPath.row,delegate:self)
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            makeTextAlert(title: "新規カテゴリ", message: "カテゴリ名", okActionTitle: "追加する", textPlaceholder: "例:江戸川乱歩") { text in
                let category = text + "&" + UUID().uuidString
                self.categories.append(category)
                self.addCategoryUd()
                self.delegate?.reloadView()
                self.tableV.reloadData()
            }
        }else if indexPath.section == 1{
            
        }
    }
}
extension MenuViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
extension MenuViewController:MenuTableViewCellDelegate{
    func launchAlert(index:Int) {
        makeTextAlert(title: "カテゴリ名を変更", message: "カテゴリ名", okActionTitle: "変更する", textPlaceholder: "変更後のカテゴリ名") { text in
            print("rename")
        }
    }
}

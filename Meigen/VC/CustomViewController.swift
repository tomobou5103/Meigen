import UIKit
final class CustomViewController: UIViewController {
    
//MARK: -Property
    let CustomTableViewCellId = "CustomTableViewCell"
//MARK: -IBOutlet
    @IBOutlet weak var tableV: UITableView!{
        didSet{
            tableV.delegate = self
            tableV.dataSource = self
            tableV.register(UINib(nibName: CustomTableViewCellId, bundle: nil), forCellReuseIdentifier: CustomTableViewCellId)
        }
    }
//MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
//MARK: -Extension
extension CustomViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableV.dequeueReusableCell(withIdentifier: CustomTableViewCellId)as? CustomTableViewCell
        else{
            return UITableViewCell()
        }
        return cell
    }
}


import UIKit

class CategoryViewController: UIViewController {
    
//MARK: Property
private let categoryId = "TopTableViewCell"
    
//MARK: IBOutlet
    @IBOutlet weak var tableV: UITableView!{
        didSet{
            tableV.delegate = self
            tableV.dataSource = self
            tableV.register(UINib(nibName: categoryId, bundle: nil), forCellReuseIdentifier: categoryId)
        }
    }

//MARK: LifeScycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension CategoryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableV.dequeueReusableCell(withIdentifier: categoryId, for: indexPath) as? TopTableViewCell
        cell?.textLabel?.text = "本のタイトル"
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToMeigenSegue", sender: nil)
    }

}

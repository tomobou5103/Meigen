import UIKit
final class CustomViewController: UIViewController {
    
//MARK: -IBOutlet
    @IBOutlet weak var tableV: UITableView!{
        didSet{
            tableV.delegate = self
            tableV.dataSource = self
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
        
    }
}

import UIKit
final class CustomViewController: UIViewController {
    
//MARK: -Property
    private let CustomTableViewCellId = "CustomTableViewCell"
    private let CustomVCtoSlectSegueId = "showSelect"
    internal var categoryIndex = 0
    
//MARK: -IBOutlet
    @IBOutlet weak var tableV: UITableView!{
        didSet{
            tableV.delegate = self
            tableV.dataSource = self
            tableV.register(UINib(nibName: CustomTableViewCellId, bundle: nil), forCellReuseIdentifier: CustomTableViewCellId)
        }
    }
    @IBAction func showSelectVCButton(_ sender: Any) {
        performSegue(withIdentifier: CustomVCtoSlectSegueId, sender: nil)
    }
//MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
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

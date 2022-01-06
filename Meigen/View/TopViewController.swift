import UIKit

class TopViewController: UIViewController{
    
//MARK: Property-
   
    private let topTableId = "TopTableViewCell" //TableViewCellID
    private let meigens:[[Meigen]] = []
    
//MARK: IBOutlet-

    @IBOutlet weak var tableV: UITableView!{
        didSet{
            tableV.delegate = self
            tableV.dataSource = self
            tableV.register(UINib(nibName: topTableId, bundle: nil), forCellReuseIdentifier: topTableId)
        }
    }
    @IBOutlet weak var bottomV: UIView!
    @IBOutlet weak var bottomButton: UIButton!

//MARK: IBAction-
    
    @IBAction func buttomButtonAction(_ sender: Any) {
    }
    
//MARK: LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
extension TopViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //UserDefaults()
        return meigens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableV.dequeueReusableCell(withIdentifier: topTableId, for: indexPath) as? TopTableViewCell
        cell?.textLabel?.text = "カテゴリー名"
        cell?.textLabel?.text = meigens[indexPath.section][indexPath.row].bookName
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToCategorySegue", sender: nil)
    }
    
    
}

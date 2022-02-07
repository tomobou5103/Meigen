import UIKit
import Parchment

final class TopViewController: UIViewController{
    
//MARK: Property-
    private let topTableId = "TopTableViewCell" //TableViewCellID
    private let customVCId = "CustomViewController"//CustomViewControllerID for Parchment
//MARK: IBOutlet-
    @IBOutlet weak var backgroundV: UIView!
    @IBOutlet weak var bottomV: UIView!
    @IBOutlet weak var bottomButton: UIButton!
//MARK: Configure
    func vcConfigure(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: customVCId)
        let vc2 = storyBoard.instantiateViewController(withIdentifier: customVCId)
        vc.title = "Category"
        vc2.title = "Category2"
        let pagingVC = PagingViewController(viewControllers: [vc,vc2])
        addChild(pagingVC)
        view.addSubview(pagingVC.view)
        pagingVC.didMove(toParent: self)
        pagingVC.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
          pagingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          pagingVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          pagingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
          pagingVC.view.topAnchor.constraint(equalTo: backgroundV.topAnchor)
        ])
        pagingVC.selectedBackgroundColor = .clear
        pagingVC.indicatorColor = .green
        pagingVC.textColor = .white
        pagingVC.selectedTextColor = .green
        pagingVC.menuBackgroundColor = .clear
        pagingVC.borderColor = .clear
        pagingVC.select(index: 0)
    }
//MARK: IBAction-
    @IBAction func buttomButtonAction(_ sender: Any) {
    }
//MARK: LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        vcConfigure()
    }
}

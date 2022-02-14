import UIKit
import Parchment

final class TopViewController: UIViewController{
    
//MARK: -Property
    private let customVCId = "CustomViewController"//CustomViewControllerID for Parchment
    private var categories:[String] = ["カテゴリ1","カテゴリ2","カテゴリ3"]
//MARK: -IBOutlet
    @IBOutlet weak var backgroundV: UIView!
    @IBOutlet weak var bottomV: UIView!
//MARK: -Configure
    func generateVCS()->[UIViewController]{
        var vcs:[UIViewController] = []
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        for (index,st) in categories.enumerated(){
            guard
                let vc = storyBoard.instantiateViewController(withIdentifier: customVCId) as? CustomViewController
            else{
                return [UIViewController]()
            }
            vc.title = st
            vc.categoryIndex = index
            vcs.append(vc)
        }
        return vcs
    }
    func topViewControllerConfigure(){
        let vcs = generateVCS()
        let pagingVC = PagingViewController(viewControllers: vcs)
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
//MARK: -IBAction
    @IBAction func buttomButtonAction(_ sender: Any) {
    }
//MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        topViewControllerConfigure()
    }
}

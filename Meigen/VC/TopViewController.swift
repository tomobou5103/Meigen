import UIKit
import Parchment
import RealmSwift

final class TopViewController: UIViewController{
//MARK: -Property
    private let customVCId = "CustomViewController"//CustomViewControllerID for Parchment
    private var categories:[String] = ["category1","category2","category3"]
    private var pagingVC:PagingViewController?
//MARK: -IBOutlet
    @IBOutlet private weak var backgroundV: UIView!
    @IBOutlet private weak var bottomV: UIView!
//MARK: -Configure
    private func generateVCS()->[UIViewController]{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var vcs:[UIViewController] = []
        let realm = try! Realm()
        let res = realm.objects(CategoryModel.self)
        for (index,st) in categories.enumerated(){
            guard
                let vc = storyBoard.instantiateViewController(withIdentifier: customVCId) as? CustomViewController
            else{
                return [UIViewController]()
            }
            vc.configure(model: res.filter{$0.categoryIndex == index}, index: index, title: st)
            vcs.append(vc)
        }
        return vcs
    }
    private func removePagingView(){
        self.pagingVC?.view.removeFromSuperview()
    }
    private func pagingViewConfigure(){
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
        self.pagingVC = pagingVC
    }
//MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
    }
}
extension TopViewController:UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        removePagingView()
        pagingViewConfigure()
    }
}

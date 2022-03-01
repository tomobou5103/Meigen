import UIKit
import Parchment
import RealmSwift

final class TopViewController: UIViewController{
//MARK: -Property
    private let customVCId = "CustomViewController"//CustomViewControllerID for Parchment
    private var categories:[String] = ["category1"]{
        didSet{
            self.categories = categoryConfigure()
        }
    }
    private var pagingVC:PagingViewController?
    private let toMenuSegueId = "showMenu"
//MARK: -IBOutlet
    @IBOutlet private weak var backgroundV: UIView!
    @IBOutlet private weak var bottomV: UIView!
    @IBAction func toMenuButton(_ sender: Any) {
        performSegue(withIdentifier: toMenuSegueId, sender: nil)
    }
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
    private func categoryConfigure()->[String]{
        let ud = UserDefaults.standard
        guard let res = ud.stringArray(forKey: "categories")else{return self.categories}
        return res
    }
//MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toMenuSegueId{
            let nextVC = segue.destination as? MenuViewController
            nextVC?.delegate = self
            nextVC?.configure(categories: categories)
        }
    }
    
}
extension TopViewController:UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        removePagingView()
        pagingViewConfigure()
    }
}
extension TopViewController:MenuViewControllerDelegate{
    func reloadView() {
        self.categories = categoryConfigure()
        removePagingView()
        pagingViewConfigure()
    }
}

import UIKit
import Parchment
import RealmSwift

final class TopViewController: UIViewController{
//MARK: -Property
    private let customVCId = "CustomViewController"//CustomViewControllerID for Parchment
    private var categories:[String] = ["初期カテゴリ&uuid"]
    private var pagingVC:PagingViewController?
    private let toMenuSegueId = "showMenu"
    private let realm = try! Realm()
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
        let res = realm.objects(MeigenModel.self)
        print(res)
        for (index,id) in categories.enumerated(){
            guard
                let vc = storyBoard.instantiateViewController(withIdentifier: customVCId) as? CustomViewController
            else{
                return [UIViewController]()
            }
            vc.configure(model: res.filter{$0.categoryId == self.categories[index]}, categoryId: id,categoryIndex:index,delegate:self)
            vcs.append(vc)
        }
        return vcs
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
    private func categoriesConfigure(){
        let ud = UserDefaults.standard
        guard let res = ud.stringArray(forKey: "categories")else{return}
        self.categories = res
    }
//MARK: -Func
    private func removePagingView(){
        self.pagingVC?.view.removeFromSuperview()
    }
    private func reloadView() {
        categoriesConfigure()
        removePagingView()
        pagingViewConfigure()
    }
//MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        categoriesConfigure()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toMenuSegueId{
            let nextVC = segue.destination as? MenuViewController
            nextVC?.configure(categories: categories,delegate: self)
        }
    }
    
}
extension TopViewController:UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        reloadView()
    }
}
extension TopViewController:ReloadTopViewControllerDelegate{
    func renameMeigenModel(categoryId: String,newCategoryId:String) {
        let res = realm.objects(MeigenModel.self).filter("categoryId == %@",categoryId)
        try! realm.write{
            res.forEach{
                $0.categoryId = newCategoryId
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {()-> Void in
            self.reloadView()
        })
    }
    func removeMeigenModel(categoryId:String) {
        let res = realm.objects(MeigenModel.self).filter("categoryId == %@",categoryId)
        try! realm.write{
            realm.delete(res)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {()-> Void in
            self.reloadView()
        })
    }
    func reloadTopView(categoryIndex:Int?){
        reloadView()
        guard let categoryIndex = categoryIndex else {
            return
        }
        pagingVC?.select(index: categoryIndex)
    }
}

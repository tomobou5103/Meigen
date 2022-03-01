import UIKit
import RxSwift
import RxCocoa
import Alamofire

final class SearchBookViewController: UIViewController {
//MARK: -Propety
    private let disposeBag = DisposeBag()
    private var model:BooksModel?
    private let tableViewNameId = "SearchBookTableViewCell"
    private let segueId = "SearchBookRegist"
    private var keepIndexPath:Int = 0
    private var categoryId:String?
    
//MARK: -IBOutlet
    @IBOutlet weak private var textF: UITextField!{didSet{textFieldDidChangValue()}}
    @IBOutlet weak private var tableV: UITableView!{didSet{tableViewConfigure(tableView: tableV)}}
//MARK: -Configure
    private func tableViewConfigure(tableView:UITableView){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: tableViewNameId, bundle: nil), forCellReuseIdentifier: tableViewNameId)
    }
    private func textFieldDidChangValue(){
        
        textF.rx.text.orEmpty.asDriver()
            .drive(onNext:{[unowned self] text in
                GoogleBooksAPI.shared.receiveBooksData(textValue: text,completion:{ booksModel in
                    self.model = booksModel
                    DispatchQueue.main.async {
                        self.tableV.reloadData()
                    }
                })
            })
            .disposed(by: disposeBag)
    }
    internal func configure(categoryId:String){
        self.categoryId = categoryId
    }
//MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
   }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueId{
            guard
                let model = self.model?.items[self.keepIndexPath],
                let nextVC = segue.destination as? RegistViewController,
                let categoryId = self.categoryId
            else{
                return
            }
            nextVC.modelConfigure(model: model)
            nextVC.categoryIdConfigure(categoryId: categoryId)
        }
    }
}
//MARK: -Extension UITableView
extension SearchBookViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableV.dequeueReusableCell(withIdentifier: tableViewNameId, for: indexPath) as? SearchBookTableViewCell,
            let model = self.model
        else{
            return UITableViewCell()
        }
        cell.configure(model: model.items[indexPath.row].volumeInfo)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.keepIndexPath = indexPath.row
        performSegue(withIdentifier: segueId, sender: nil)
        
    }
}

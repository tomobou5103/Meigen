import UIKit
import RxSwift
import RxCocoa
import Alamofire

final class SearchBookViewController: UIViewController {

    @IBOutlet weak private var textF: UITextField!
    @IBOutlet weak private var tableV: UITableView!{
        didSet{
            self.tableV.delegate = self
            self.tableV.dataSource = self
        }
    }
    
    private let disposeBag = DisposeBag()
    private var model:BooksModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textF.rx.text
            .subscribe{text in
                GoogleBooksAPI.shared.receiveBooksData(textValue: text ?? "",completion:{ model in
                    self.model = model
                    DispatchQueue.main.async {
                        self.tableV.reloadData()
                    }
                })
            }
            .disposed(by: disposeBag)
   }
}
extension SearchBookViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.model?.items[indexPath.row].volumeInfo.title
        return cell
    }
}

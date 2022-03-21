import UIKit
import RxSwift
import RxCocoa
protocol SearchBookViewControllerDelegate:AnyObject{
    func reloadAddMeigenView(model:Item)
}
final class SearchBookViewController: UIViewController {
//MARK: -Propety
    private let disposeBag = DisposeBag()
    private var model:BooksModel?
    private let tableViewCellId = "SearchBookTableViewCell"
    private weak var delegate:SearchBookViewControllerDelegate?
//MARK: -IBOutlet
    @IBOutlet weak private var textF: UITextField!{didSet{textFieldDidChangValue()}}
    @IBOutlet weak private var tableV: UITableView!{didSet{tableViewConfigure(tableView: tableV)}}
//MARK: -Configure
    private func tableViewConfigure(tableView:UITableView){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: tableViewCellId, bundle: nil), forCellReuseIdentifier: tableViewCellId)
    }
    private func textFieldDidChangValue(){
        textF.rx.text.orEmpty.asDriver()
            .drive(onNext:{[weak self] text in
                GoogleBooksAPI.shared.receiveBooksData(textValue: text,completion:{ booksModel in
                    self?.model = booksModel
                    DispatchQueue.main.async {
                        self?.tableV.reloadData()
                    }
                })
            })
            .disposed(by: disposeBag)
    }
    internal func configure(delegate:SearchBookViewControllerDelegate){
        self.delegate = delegate
    }
//MARK: -LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let addMeigenPos = self.view.layer.position
        self.view.layer.position.x = -self.view.frame.width * 4
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.view.layer.position.x = addMeigenPos.x
            },
            completion: nil
        )
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 2 {
                UIView.animate(
                    withDuration: 0.25,
                    animations: {
                        self.view.layer.position.x = -self.view.frame.width * 4
                    },
                    completion: {_ in
                        self.dismiss(animated: true, completion: nil)
                    })
            }
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
            let cell = tableV.dequeueReusableCell(withIdentifier: tableViewCellId, for: indexPath) as? SearchBookTableViewCell,
            let model = self.model
        else{
            return UITableViewCell()
        }
        cell.configure(model: model.items[indexPath.row].volumeInfo)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = self.model else{return}
        delegate?.reloadAddMeigenView(model:model.items[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

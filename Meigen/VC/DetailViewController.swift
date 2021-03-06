import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
//MARK: -Propety
    private var model:MeigenModel = MeigenModel()
    private var index:IndexPath?
    private weak var delegate:DetailViewControllerDelegate?
    private let disposeBag = DisposeBag()
    private let themeColor = ThemeColors().loadColor()
//MARK: -IBOutlet
    @IBOutlet private weak var headerView: UIView!{didSet{headerView.backgroundColor = UIColor(hex: themeColor[0])}}
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var textView: UITextView!{
        didSet{
            self.textView.rx.text.asDriver()
                .drive(onNext: {[weak self] text in
                    guard let text = text else{return}
                    if text.count < 200{
                        if text != self?.model.meigenText{
                            self?.textView.textColor = .systemRed
                            self?.saveMeigenTextButton.alpha = 1
                        }else{
                            self?.textView.textColor = .black
                            self?.saveMeigenTextButton.alpha = 0
                        }
                    }else{
                        self?.saveMeigenTextButton.alpha = 0
                    }

                    
                })
                .disposed(by: disposeBag)
        }
    }
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var bookImageView: UIImageView!
    @IBOutlet private weak var saveMeigenTextButton: UIButton!
    //MARK: -IBAction
    @IBAction private func removeMeigenModelAction(_ sender: Any) {
        guard let title = self.model.title else{return}
        makeAlert(title: "Meigen削除", message: "\(title)を削除します", okActionTitle: "削除", textViewIsOn: false, textPlaceholder: nil, completion: {_ in
            self.model.removeModel()
            self.delegate?.removeCell(index:self.index!)
            self.dismiss(animated: true, completion: nil)
        })
    }
    @IBAction func saveMeigenTextAction(_ sender: Any) {
        guard let text = self.textView.text else{return}
        makeAlert(title: "Meigenの変更", message: "「\(text)」に変更します", okActionTitle: "変更", textViewIsOn: false, textPlaceholder: nil, completion: {_ in
            self.model.rewriteMeigenText(text: text)
            self.delegate?.reloadTableView()
        })
    }
    //MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if !self.model.isInvalidated{
            detailViewConfigure(model: self.model)
        }
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if !textView.isFirstResponder{
            return
        }
        if self.view.frame.origin.y == 0 {
            if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let bottomSpaceHeight = self.view.frame.height / 5
                self.view.frame.origin.y -= keyboardRect.height -  bottomSpaceHeight
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 3 {
                dismiss(animated: true, completion: nil)
            }
        }
    }
//MARK: -Configure
    internal func configure(model:MeigenModel,index:IndexPath,delegate:DetailViewControllerDelegate){
        self.model = model
        self.index = index
        self.delegate = delegate
    }
    private func detailViewConfigure(model:MeigenModel){
        self.titleLabel.text = model.title
        self.authorLabel.text = model.author
        self.commentLabel.text = model.comment
        stringToImage(imageSt: model.bookImage, completion: {image in
            DispatchQueue.main.async {
                self.bookImageView.image = image
            }
        })
        if let meigenImage = model.meigenImage{
            let fileURL = URL(string: meigenImage)
            let filePath = fileURL?.path
            self.imageView.image = UIImage(contentsOfFile: filePath!)
            self.textView.alpha = 0
        }else{
            self.imageView.alpha = 0
            self.textView.text = model.meigenText
        }
    }
    private func stringToImage(imageSt:String?,completion:@escaping(UIImage)->Void){
        DispatchQueue.global().async {
            guard
                let imageSt = imageSt,
                let imageUrl = URL(string: imageSt),
                let imageData = try? Data(contentsOf: imageUrl),
                let image = UIImage(data: imageData)
            else{
                return
            }
            completion(image)
        }
    }
}

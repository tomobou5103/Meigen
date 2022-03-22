import UIKit
import KMPlaceholderTextView
import Photos
import RxSwift
import RxCocoa

final class AddMeigenViewController: UIViewController {
//MARK: -Property
    private let toSearchBookId = "toSearchBook"
    private var categoryId:String = ""
    private var categoryIndex:Int = 0
    private var searedBookModel:Item?
    private weak var delegate:ReloadTopViewControllerDelegate?
    private var bookModelImageSt:String?
    private let disposeBag = DisposeBag()
    
//MARK: -IBOutlet
    @IBOutlet private weak var addMeigenView: UIView!
    @IBOutlet private weak var bookNameTextField: UITextField!
    @IBOutlet private weak var authorTextField: UITextField!
    @IBOutlet private weak var commentTextField: UITextField!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textView: KMPlaceholderTextView!
    @IBOutlet private weak var saveButton: UIButton!
    //MARK: -IBAction
    @IBAction private func searchBookAction(_ sender: Any) {
        performSegue(withIdentifier: toSearchBookId, sender: nil)
    }
    @IBAction private func saveAction(_ sender: Any) {
        makeMeigenModel().saveModel()
        delegate?.reloadTopView(categoryIndex: self.categoryIndex)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func textViewEndEditingAction(_ sender: Any) {
        self.textView.endEditing(true)
    }
    @IBAction func cameraAction(_ sender: Any) {
        makeAlert(title: "名言をカメラで撮影", message: nil, okActionTitle: "カメラ", textViewIsOn: false, textPlaceholder: nil, completion:{Void in
            self.selectImage(type: .camera)
        })
    }
    @IBAction func cameraRollAction(_ sender: Any) {
        makeAlert(title: "名言をカメラロールから追加", message: nil, okActionTitle: "カメラロール", textViewIsOn: false, textPlaceholder: nil, completion:{Void in
            self.selectImage(type: .photoLibrary)
        })
    }
    //MARK: -Configure
    internal func configure(categoryId:String?,categoryIndex:Int,searchedBookModel:Item?,delegate:ReloadTopViewControllerDelegate?){
        self.categoryIndex = categoryIndex
        if let categoryId = categoryId {
            self.categoryId = categoryId
        }
        if let searedBookModel = searedBookModel {
            self.searedBookModel = searedBookModel
        }
        if let delegate = delegate {
            self.delegate = delegate
        }
    }
    private func textFieldConfigure(){
        lazy var textFields = [
            self.bookNameTextField,
            self.authorTextField,
            self.commentTextField
        ]
        textFields.forEach{field in
            guard let field = field else{return}
            field.delegate = self
            let countLabel = UILabel()
            countLabel.translatesAutoresizingMaskIntoConstraints = false
            countLabel.textAlignment = .right
            countLabel.textColor = .gray
            field.addSubview(countLabel)
            countLabel.centerYAnchor.constraint(equalTo: field.centerYAnchor).isActive = true
            let _ = NSLayoutConstraint.init(item: countLabel, attribute: .right, relatedBy: .equal, toItem: field, attribute: .right, multiplier: 1.0, constant: -10).isActive = true
            field.rx.text.asDriver()
                .drive(onNext: {[unowned self]text in
                    if let text = text{
                        let saveButtonIsOnCounter = 20 - text.count
                        countLabel.text = "\(saveButtonIsOnCounter)"
                        if saveButtonIsOnCounter < 0{
                            saveButton.backgroundColor = .lightGray
                            saveButton.isEnabled = false
                            countLabel.textColor = .systemRed
                        }else{
                            saveButton.backgroundColor = .systemBlue
                            saveButton.isEnabled = true
                            countLabel.textColor = .gray
                        }
                    }else{
                        countLabel.text = "0"
                    }
                })
                .disposed(by: disposeBag)
            
        }
    }
//MARK: -MakeMeigenModel
    private func makeMeigenModel()->MeigenModel{
        let model = MeigenModel()
        model.title = bookNameTextField.text
        model.author = authorTextField.text
        model.comment = commentTextField.text
        model.meigenText = textView.text
        model.bookImage = self.bookModelImageSt
        model.saveImage(image: self.imageView.image)
        model.categoryId = self.categoryId
        model.generateUUID()
        return model
    }
//MARK: -LefeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldConfigure()
        if let searedBookModel = self.searedBookModel {
            self.bookNameTextField.text = searedBookModel.volumeInfo.title
            self.authorTextField.text = searedBookModel.volumeInfo.authors?[0]
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
                self.view.frame.origin.y -= keyboardRect.height
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let addMeigenPos = self.addMeigenView.layer.position
        self.addMeigenView.layer.position.y = self.addMeigenView.frame.height * 4
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.addMeigenView.layer.position.y = addMeigenPos.y
            },
            completion: nil
        )
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 1 {
                UIView.animate(
                    withDuration: 0.25,
                    animations: {
                        self.addMeigenView.layer.position.y = self.addMeigenView.frame.height * 4
                    },
                    completion: {_ in
                        self.dismiss(animated: true, completion: nil)
                    })
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toSearchBookId{
            let nextVC = segue.destination as? SearchBookViewController
            nextVC?.configure(delegate: self)
        }
    }
}
//MARK: -Extension
extension AddMeigenViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
}
extension AddMeigenViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func selectImage(type:UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController.init()
            imagePicker.delegate = self
            imagePicker.sourceType = type
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[UIImagePickerController.InfoKey.originalImage] != nil {
            let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
            imageView.alpha = 1
            textView.alpha = 0
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
extension AddMeigenViewController:SearchBookViewControllerDelegate{
    func reloadAddMeigenView(model:Item) {
        self.bookNameTextField.text = model.volumeInfo.title
        self.authorTextField.text = model.volumeInfo.authors?[0]
        guard let imageSt = model.volumeInfo.imageLinks.thumbnail else{return}
        self.bookModelImageSt = imageSt
    }
}

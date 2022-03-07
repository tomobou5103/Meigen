import UIKit
import RxSwift
import RxCocoa
import Photos
import RealmSwift

final class RegistViewController: UIViewController {

//MARK: -Property
    private var toTopVCSegueId = "showTop"
    private var model:Item?
    private var categoryId = ""
    private var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//MARK: -IBOutlet
    @IBOutlet weak private var MeigenTextView: UITextView!
    @IBOutlet weak private var barButton: UIBarButtonItem!
    @IBOutlet weak private var bookNameTextField: UITextField!
    @IBOutlet weak private var authorTextField: UITextField!
    @IBOutlet weak private var commentTextField: UITextField!
    @IBOutlet weak private var imageV: UIImageView!{didSet{imageV.alpha = 0}}
//MARK: -IBAction
    
    @IBAction private func insertImageButton(_ sender: Any) {
        makePhotoAlert()
    }
    
    @IBAction private func barButtonAction(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write{
            realm.add(makeMeigenModel())
        }
        print("----------ToTopVC----------")
        self.navigationController?.popToRootViewController(animated: true)
    }
    internal func modelConfigure(model:Item){
        self.model = model
    }
    internal func categoryIdConfigure(categoryId:String){
        self.categoryId = categoryId
    }
//MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let model = self.model else{return}
        self.bookNameTextField.text = model.volumeInfo.title
        self.authorTextField.text = model.volumeInfo.authors?[0]
    }
//MARK: -MakeAlert
    private func makePhotoAlert(){
        let alert = UIAlertController(title: "名言を写真で追加します", message: "選択してください", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "カメラで撮影する", style: .default, handler:{(action:UIAlertAction!)->Void in
            self.selectImage(type: .camera)
        })
        let cameraRollAction = UIAlertAction(title: "カメラロール", style: .default, handler: {(action:UIAlertAction!)->Void in
            self.checkPermission()
            self.selectImage(type: .photoLibrary)
        })
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: {(action:UIAlertAction!)->Void in
            print("cancel")
        })
        alert.addAction(cameraAction)
        alert.addAction(cameraRollAction)
        alert.addAction(cancelAction)
        present(alert,animated:true,completion:nil)
    }
//MARK: -MakeRegistBookModel
    private func makeMeigenModel()->MeigenModel{
        let model = MeigenModel()
        model.title = bookNameTextField.text
        model.author = authorTextField.text
        model.comment = commentTextField.text
        model.meigenText = MeigenTextView.text
        model.bookImage = self.model?.volumeInfo.imageLinks.thumbnail
        model.categoryId = self.categoryId
        saveImage()
        model.meigenImage = documentDirectoryFileURL.absoluteString
        return model
    }
    private func createLocalDataFile(){
        let fileName = "\(NSUUID().uuidString).png"
        let path = documentDirectoryFileURL.appendingPathComponent(fileName)
        documentDirectoryFileURL = path
    }
    private func saveImage(){
        createLocalDataFile()
        let pngImageData = imageV.image?.pngData()
        do {
            try pngImageData?.write(to: documentDirectoryFileURL)
        } catch {
            print("エラー")
        }
    }
}
//MARK: -Extension
extension RegistViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func selectImage(type:UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController.init()
            imagePicker.delegate = self
            imagePicker.sourceType = type
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func checkPermission(){
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("auth")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({(newStatus) in
                print("status is \(newStatus)")
                if newStatus == PHAuthorizationStatus.authorized{
                    print("Success")
                }
            })
            print("not Determind")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .limited:
            print("limited")
        default:
            print("default")
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if info[UIImagePickerController.InfoKey.originalImage] != nil {
            let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
            imageV.alpha = 1
            MeigenTextView.alpha = 0
            imageV.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

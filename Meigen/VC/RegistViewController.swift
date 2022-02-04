import UIKit
import RxSwift
import RxCocoa
import Photos


final class RegistViewController: UIViewController {

//MARK: -Property
    private var model:Item?
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
        //UD()
        //rx isHidden
    }
    internal func configure(model:Item){
        self.model = model
    }
//MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let model = self.model else{
            return
        }
        self.bookNameTextField.text = model.volumeInfo.title
        self.authorTextField.text = model.volumeInfo.authors?[0]
    }
//MARK: -MakeAlert
    func makePhotoAlert(){
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
            imageV.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

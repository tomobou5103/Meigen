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
        checkPermission()
        selectImage()
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
}
//MARK: -Extension
extension RegistViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func selectImage(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController.init()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
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

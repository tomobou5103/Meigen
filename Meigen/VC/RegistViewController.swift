import UIKit
import RxSwift
import RxCocoa


final class RegistViewController: UIViewController {

//MARK: Property-
    private var model:Item?
//MARK: IBOutlet-
    @IBOutlet weak var MeigenTextView: UITextView!
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet weak var bookNameTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
//MARK: IBAction-
    
    @IBAction private func insertImageButton(_ sender: Any) {
    }
    
    @IBAction private func barButtonAction(_ sender: Any) {
        //UD()
        
        
        
        
        //rx isHidden
    }
    internal func configure(model:Item){
        self.model = model
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let model = self.model else{
            return
        }
        self.bookNameTextField.text = model.volumeInfo.title
        self.authorTextField.text = model.volumeInfo.authors?[0]
    }
}

import UIKit
import RxSwift
import RxCocoa


class RegistViewController: UIViewController {

//MARK: IBOutlet-
    @IBOutlet weak var MeigenTextView: UITextView!
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet weak var bookNameTextField: UITextField!
    @IBOutlet weak var quoteTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    //MARK: IBAction-
    
    @IBAction func barButtonAction(_ sender: Any) {
        let nameText = self.bookNameTextField.text ?? ""
        let meigenText = MeigenTextView.text ?? ""
        let quoteText = quoteTextField.text ?? ""
        let authorText = authorTextField.text ?? ""
        let commentText = commentTextField.text ?? ""
        let meigen = Meigen(name: nameText, meigen: meigenText, quote: quoteText, author: authorText, comment: commentText)
        
        //UD()
        
        
        
        
        //rx isHidden
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
}

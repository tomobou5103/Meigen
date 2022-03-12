import UIKit

public extension UIViewController{
    internal func makeAlert(title:String,message:String?,okActionTitle:String,textViewIsOn:Bool,textPlaceholder:String?,completion:@escaping(String)->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var okAction = UIAlertAction()
        if textViewIsOn{
            alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
                text.placeholder = textPlaceholder
            })
            okAction = UIAlertAction(title: okActionTitle, style: .default, handler: {(action:UIAlertAction!)->Void in
                guard let text = alert.textFields?.first?.text else {return}
                if text != ""{
                    completion(text)
                }
            })
        }else{
            okAction = UIAlertAction(title: okActionTitle, style: .default, handler: {(action:UIAlertAction!)->Void in
                    completion("")
            })
        }
        let cancelAction = UIAlertAction(title: "やめる", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

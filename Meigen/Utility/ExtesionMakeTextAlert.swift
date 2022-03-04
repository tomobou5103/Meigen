import UIKit

public extension UIViewController{
    func makeTextAlert(title:String,message:String,okActionTitle:String,textPlaceholder:String,completion:@escaping(String)->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActionTitle, style: .default, handler: {(action:UIAlertAction!)->Void in
            guard let text = alert.textFields?.first?.text else {return}
            if text != ""{
                completion(text)
            }
        })
        let cancelAction = UIAlertAction(title: "やめる", style: .cancel, handler: {(action:UIAlertAction!) -> Void in
            print("cancel")
        })
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
            text.placeholder = textPlaceholder
        })
        present(alert, animated: true, completion: nil)
    }
}

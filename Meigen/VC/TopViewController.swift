import UIKit
import Parchment

final class TopViewController: UIViewController{
    
//MARK: Property-
   
    private let topTableId = "TopTableViewCell" //TableViewCellID

    
//MARK: Configure
    private func vcConfigure(){
        
    }
//MARK: IBOutlet-
    @IBOutlet weak var backgroundV: UIView!
    @IBOutlet weak var bottomV: UIView!
    @IBOutlet weak var bottomButton: UIButton!

//MARK: IBAction-
    
    @IBAction func buttomButtonAction(_ sender: Any) {
    }
    
//MARK: LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

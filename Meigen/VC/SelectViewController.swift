import UIKit

final class SelectViewController: UIViewController {
    private var categoryIndex:Int?
    private let toSearchBookVCSegueId = "showSearchBook"
    private let toRegistVCSegueId = "showRegist"
    internal func configure(categoryIndex:Int){
        self.categoryIndex = categoryIndex
    }
    @IBAction func bookSearchButton(_ sender: Any) {
        performSegue(withIdentifier: toSearchBookVCSegueId, sender: nil)
    }
    @IBAction func fullScratchButton(_ sender: Any) {
        performSegue(withIdentifier: toRegistVCSegueId, sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = self.categoryIndex else{return}
        switch segue.identifier{
        case toSearchBookVCSegueId:
            guard let nextVC = segue.destination as? SearchBookViewController else{return}
            nextVC.configure(categoryIndex: index)
        case toRegistVCSegueId:
            guard let nextVC = segue.destination as? RegistViewController else{return}
            nextVC.categoryIndexConfigure(categoryIndex: index)
        default:
            return
        }
    }
}

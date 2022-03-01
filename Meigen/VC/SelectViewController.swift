import UIKit

final class SelectViewController: UIViewController {
    private var categoryId:String?
    private let toSearchBookVCSegueId = "showSearchBook"
    private let toRegistVCSegueId = "showRegist"
    internal func configure(categoryId:String){
        self.categoryId = categoryId
    }
    @IBAction private func bookSearchButton(_ sender: Any) {
        performSegue(withIdentifier: toSearchBookVCSegueId, sender: nil)
    }
    @IBAction private func fullScratchButton(_ sender: Any) {
        performSegue(withIdentifier: toRegistVCSegueId, sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let categoryId = self.categoryId else{return}
        switch segue.identifier{
        case toSearchBookVCSegueId:
            guard let nextVC = segue.destination as? SearchBookViewController else{return}
            nextVC.configure(categoryId: categoryId)
        case toRegistVCSegueId:
            guard let nextVC = segue.destination as? RegistViewController else{return}
            nextVC.categoryIdConfigure(categoryId: categoryId)
        default:
            return
        }
    }
}

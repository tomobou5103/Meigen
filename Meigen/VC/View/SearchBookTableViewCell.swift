import UIKit

final class SearchBookTableViewCell: UITableViewCell {
    @IBOutlet private weak var imageV: UIImageView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    internal func configure(model:VolumeInfo){
        self.titleLabel.text = model.title
        if let author = model.authors?[0]{
            self.authorLabel.text = author
        }
        getImageData(model: model.imageLinks) { image in
            DispatchQueue.main.async {
                self.imageV.image = image
            }
        }

    }
    
    private func getImageData(model:ImageLinks,completion:@escaping(UIImage)->Void){
        DispatchQueue.global().async {
            if let imageSt = model.thumbnail{
                let imageUrl = URL(string: imageSt)
                do{
                let imageData = try? Data(contentsOf: imageUrl!)
                    
                    completion(UIImage(data: imageData!)!)
                }catch{
                    print("Could not load image file")
                }
            }else{
                completion(UIImage())
            }
        }
    }
}

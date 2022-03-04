import UIKit

final class CustomTableViewCell: UITableViewCell {
    @IBOutlet private weak var bookImageV: UIImageView!
    @IBOutlet private weak var bookNameLabel: UILabel!
    @IBOutlet private weak var bookAuthorLabel: UILabel!
    @IBOutlet private weak var meigenTextLabel: UILabel!
    
    internal func configure(model:MeigenModel){
        self.bookNameLabel.text = model.title
        if let author = model.author{
            self.bookAuthorLabel.text = author
        }
        if let meigenText = model.meigenText{
            self.meigenTextLabel.text = meigenText
        }
                
            
                
        stringToImage(imageSt: model.bookImage, completion: {image in
            DispatchQueue.main.async {
                self.bookImageV.image = image
            }
        })
    }
    private func stringToImage(imageSt:String?,completion:@escaping(UIImage)->Void){
        DispatchQueue.global().async {
            guard
                let imageSt = imageSt,
                let imageUrl = URL(string: imageSt),
                let imageData = try? Data(contentsOf: imageUrl),
                let image = UIImage(data: imageData)
            else{
                return
            }
            completion(image)
        }
    }
}

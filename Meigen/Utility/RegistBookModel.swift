import UIKit

struct CategoryModel{
    internal var title:String = ""
    internal var author:[String?]
    internal var comment:String?
    internal var meigenText:String?
    internal var bookImage:UIImage?
    internal var meigenImage:UIImage?
    
    init(
        title:String,
        _ author:[String?],
        _ comment:String?,
        _ meigenText:String?,
        _ bookImage:UIImage?,
        _ meigenImage:UIImage?
    ){
        self.title = title
        self.author = author
        self.comment = comment
        self.meigenText = meigenText
        self.bookImage = bookImage
        self.meigenImage = meigenImage
    }
}
 

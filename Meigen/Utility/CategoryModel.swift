import UIKit

struct CategoryModel{
    internal var title:String?
    internal var author:String?
    internal var comment:String?
    internal var meigenText:String?
    internal var bookImage:String?
    internal var meigenImage:UIImage?
    
    init(
        title:String?,
        author:String?,
        comment:String?,
        meigenText:String?,
        bookImage:String?,
        meigenImage:UIImage?
    ){
        self.title = title
        self.author = author
        self.comment = comment
        self.meigenText = meigenText
        self.bookImage = bookImage
        self.meigenImage = meigenImage
    }
}
//RegistViewControllerでCategoryModelを作成、TopViewContorllerの[CategoryModel]に入れる


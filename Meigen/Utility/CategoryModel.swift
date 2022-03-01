import RealmSwift

final class CategoryModel:Object{
    @objc dynamic internal var title:String?
    @objc dynamic internal var author:String?
    @objc dynamic internal var comment:String?
    @objc dynamic internal var meigenText:String?
    @objc dynamic internal var bookImage:String?
    @objc dynamic internal var meigenImage:String?
    @objc dynamic internal var categoryId:String = ""
}

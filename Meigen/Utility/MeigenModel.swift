import RealmSwift

final class MeigenModel:Object{
    @objc dynamic internal var title:String?
    @objc dynamic internal var author:String?
    @objc dynamic internal var comment:String?
    @objc dynamic internal var meigenText:String?
    @objc dynamic internal var bookImage:String?
    @objc dynamic internal var meigenImage:String?
    @objc dynamic internal var categoryId:String = ""
    
    internal func saveModel(){
        let realm = try! Realm()
        try! realm.write{
            realm.add(self)
        }
    }
}

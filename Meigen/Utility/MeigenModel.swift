import RealmSwift

final class MeigenModel:Object{
    @objc dynamic internal var title:String?
    @objc dynamic internal var author:String?
    @objc dynamic internal var comment:String?
    @objc dynamic internal var meigenText:String?
    @objc dynamic internal var bookImage:String?
    @objc dynamic internal var meigenImage:String?
    @objc dynamic internal var categoryId:String = ""
    @objc dynamic internal var id:String = ""
    
    internal func saveModel(){
        let realm = try! Realm()
        try! realm.write{
            realm.add(self)
        }
    }
    internal func removeModel(){
        let realm = try! Realm()
        let targetModel = realm.objects(MeigenModel.self).filter("id == %@",id)
        try! realm.write{
            realm.delete(targetModel)
        }
    }
    internal func rewriteMeigfenText(text:String){
        let realm = try! Realm()
        let targetModel = realm.objects(MeigenModel.self).filter("id == %@",id).first
        try! realm.write{
            targetModel?.meigenText = text
        }
    }
    private var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private func createLocalDataFile(){
        let fileName = "\(NSUUID().uuidString).png"
        let path = documentDirectoryFileURL.appendingPathComponent(fileName)
        documentDirectoryFileURL = path
    }
    internal func saveImage(image:UIImage?){
        if let pngImageData = image?.pngData(){
            createLocalDataFile()
            do {
                try pngImageData.write(to: documentDirectoryFileURL)
                self.meigenImage = documentDirectoryFileURL.absoluteString
            } catch {
                print("failed to write: \(error)")
            }
        }
    }
    internal func generateUUID(){
        self.id = UUID().uuidString
    }
}

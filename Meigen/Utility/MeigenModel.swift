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
    private var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    private func createLocalDataFile(){
        let fileName = "\(NSUUID().uuidString).png"
        let path = documentDirectoryFileURL.appendingPathComponent(fileName)
        documentDirectoryFileURL = path
    }
    internal func saveImage(image:UIImage?){
        createLocalDataFile()
        let pngImageData = image?.pngData()
        do {
            try pngImageData?.write(to: documentDirectoryFileURL)
        } catch {
            print("エラー")
        }
    }
}

import UIKit

struct BooksModel:Codable{
    var items:[Item]
}
struct Item:Codable{
    var volumeInfo:VolumeInfo
}
struct VolumeInfo:Codable{
    var title:String
    var subtitle:String?
    var authors:[String]?
}

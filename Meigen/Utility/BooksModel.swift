import UIKit

struct BooksModel:Codable{
    var items:[Item]
}
struct Item:Codable{
    var volumeInfo:VolumeInfo
    var imageLinks:ImageLinks
}
struct VolumeInfo:Codable{
    var title:String
    var subtitle:String?
    var authors:[String]?
}
struct ImageLinks:Codable{
    var smallThumbnail:String?
    var thumbnail:String?
}

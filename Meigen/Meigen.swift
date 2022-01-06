import Foundation
import UIKit
struct Meigen{
    public var bookName:String?
    private var meigen:String?
    private var image:UIImage?
    private var quote:String?
    private var author:String?
    private var comment:String?
    private let date:Date?
    
    init(name:String,meigen:String,quote:String,author:String,comment:String) {
        self.bookName = name
        self.meigen = meigen
        self.image = UIImage()
        self.quote = quote
        self.author = author
        self.comment = comment
        self.date = Date()
    }
}

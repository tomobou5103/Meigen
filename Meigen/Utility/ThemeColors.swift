import UIKit

struct ThemeColors{
    private let colors:[[String]] = [
        ["5857D5","00FF00","CCCCF1"],
        ["f1ac9d","6abe83","dee2d1"],
        ["f9fbba","f6c2c2","e2f2d5"],
        ["014955","1687a7","e4d1d3"],
        ["e59572","2694ab","fdc4b6"],
        ["ddecef","c7afbd","f8f2da"],
        ["8f9435","585d37","fffadf"],
        ["95e1d3","fce38a","eaffd0"],
        ["5ad0e8","ff424e","f4efdb"],
        ["9881f5","f97d81","82aff9"],
        ["68a8ad","737495","c4d4af"],
        ["f9ce00","09194f","fdfdeb"],
        ["1f192b","4e706a","eec7bb"]
        ]
    internal func returnColor(num:Int)->[String]{
        return colors[num]
    }
}
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}

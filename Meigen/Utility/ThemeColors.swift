import UIKit

struct ThemeColors{
    private let ud = UserDefaults.standard
    private let udKey = "ThemeColor"
    private let udColor:[String] = []
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
        ["1f192b","4e706a","eec7bb"],
        ["393e46","fd7013","eeeeee"],
        ["20366b","2d095c","eae3e3"],
        ["1f640a","260033","ffffff"],
        ["a4bf5b","79a2a6","dcdede"],
        ["7d6e70","ac5850","c8c8c0"],
        ["424242","8a0651","ffffff"],
        ["b5838d","6d6875","ffb4a2"],
        ["d9ad9a","29000a","e8e1e4"],
        ["d693bd","9c0063","efd3e7"],
        ["3366cc","99ccff","ffffff"],
        ["999999","336666","ffffff"],
        ["ff6600","cc3333","ffffcc"],
        ["ffcccc","ff99cc","ffffcc"],
        ["ff6699","ccffcc","ccffff"],
        ["660099","00FF00","ffffff"]
        ]
    internal func returnColor(num:Int)->[String]{
        return colors[num]
    }
    internal func loadColor() -> [String]{
        let colorIndex = ud.integer(forKey: udKey)
        return colors[colorIndex]
    }
    internal func saveColor(index:Int){
        ud.set(index, forKey: udKey)
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

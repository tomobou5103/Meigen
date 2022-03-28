import UIKit

final class ThemeColorCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var firstColorView: UIView!
    @IBOutlet private weak var secondColorView: UIView!
    @IBOutlet private weak var thirdColorView: UIView!
    func configure(index:Int){
        let colors = ThemeColors().returnColor(num: index)
        self.firstColorView.backgroundColor = UIColor(hex: colors[0])
        self.secondColorView.backgroundColor = UIColor(hex: colors[1])
        self.thirdColorView.backgroundColor = UIColor(hex: colors[2])
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
    }
}

import UIKit

final class ThemeColorViewController: UIViewController {
//MARK: -Property
    private let themeColorCollectionViewCellId = "ThemeColorCollectionViewCell"
    private weak var delegate:ThemeColorViewControllerDelegate?
//MARK: -IBOutlet
    @IBOutlet private weak var menuView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!{didSet{collectionViewConfigure(view: collectionView)}}
//MARK: -Configure
    internal func configure(delegate:ThemeColorViewControllerDelegate){
        self.delegate = delegate
    }
    private func collectionViewConfigure(view:UICollectionView){
        view.delegate = self
        view.dataSource = self
        view.register(UINib(nibName: themeColorCollectionViewCellId, bundle: nil), forCellWithReuseIdentifier: themeColorCollectionViewCellId)
    }
//MARK: -LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let menuPos = self.menuView.layer.position
        self.menuView.layer.position.x = self.menuView.frame.width
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.menuView.layer.position.x = menuPos.x
            },
            completion: nil
        )
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 6 {
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.menuView.layer.position.x = self.menuView.frame.width
                },
                    completion: {_ in
                        self.dismiss(animated: true, completion: nil)
                }
                )
            }
        }
    }
}
extension ThemeColorViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: themeColorCollectionViewCellId, for: indexPath) as? ThemeColorCollectionViewCell
        else{
            return UICollectionViewCell()
        }
        cell.configure(index: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ThemeColors().saveColor(index: indexPath.row)
        delegate?.reloadTopView()
    }
}
extension ThemeColorViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.width / 4.5
        let height = width
        return CGSize(width: width, height: height)
    }
}

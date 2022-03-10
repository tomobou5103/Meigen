import UIKit

class AddMeigenViewController: UIViewController {
    @IBOutlet weak var addMeigenView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let addMeigenPos = self.addMeigenView.layer.position
        self.addMeigenView.layer.position.y = self.addMeigenView.frame.height * 4
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.addMeigenView.layer.position.y = addMeigenPos.y
            },
            completion: nil
        )
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 1 {
                UIView.animate(
                    withDuration: 0.25,
                    animations: {
                        self.addMeigenView.layer.position.y = self.addMeigenView.frame.height * 4
                    },
                    completion: {_ in
                        self.dismiss(animated: true, completion: nil)
                    })
            }
        }
    }
}

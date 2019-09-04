
import UIKit
import PlayerView

class ViewController: UIViewController, PlayerViewDelegate {
    
    @IBOutlet weak var blurBgImage: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ipv: PlayerView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playPauseButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.layoutIfNeeded()
        self.view.backgroundColor = UIColor.clear
        self.makeItRounded(view: self.playPauseButtonView, newSize: self.playPauseButtonView.frame.width)
        
        self.ipv!.delegate = self
        
        // duration of music
        self.ipv.progress = 20.0
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK: -
    
    
    func action1ButtonTapped(sender: UIButton, isSelected: Bool) {
        print("shuffle \(isSelected.description)")
    }
    
    func action2ButtonTapped(sender: UIButton, isSelected: Bool) {
        print("like \(isSelected.description)")
        
    }
    
    func action3ButtonTapped(sender: UIButton, isSelected: Bool) {
        print("replay \(isSelected.description)")
        
    }
    
    func playerView(didStartPlaying player: PlayerView) {
        print("interactive player did start")
        
    }
    
    func playerView(didStopPlaying player: PlayerView) {
        print("interactive player did stop")
        
    }
    
    func playerView(didChangeDuration player: PlayerView, currentDuration: Double) {
        print("current Duration : \(currentDuration)")
    }
    
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        
        self.ipv.start()
        
        self.playButton.isHidden = true
        self.pauseButton.isHidden = false
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        
        self.ipv.stop()
        
        self.playButton.isHidden = false
        self.pauseButton.isHidden = true
    }
    
    
    @IBAction func nextTapped(sender: AnyObject) {
        self.ipv.restartWithProgress(duration: 50)
    }
    
    @IBAction func previousTapped(sender: AnyObject) {
        self.ipv.restartWithProgress(duration: 10)
    }
    
    
    func makeItRounded(view : UIView!, newSize : CGFloat!){
        let saveCenter = view.center
        let newFrame = CGRect(x: view.frame.origin.x,y: view.frame.origin.y,width: newSize,height : newSize)
        view.frame = newFrame
        view.layer.cornerRadius = newSize / 2.0
        view.clipsToBounds = true
        view.center = saveCenter
    }
}

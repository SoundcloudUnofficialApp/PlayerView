

import UIKit

public protocol PlayerViewDelegate {
    
    func action1ButtonTapped(sender: UIButton, isSelected: Bool)
    func action2ButtonTapped(sender: UIButton, isSelected: Bool)
    func action3ButtonTapped(sender: UIButton, isSelected: Bool)
    
    func playerView(didStartPlaying player: PlayerView)
    
    func playerView(didStopPlaying player: PlayerView)
    
    func playerView(didChangeDuration player:PlayerView, currentDuration: Double)
}

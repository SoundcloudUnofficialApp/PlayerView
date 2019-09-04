

import UIKit

//TODO:
// fix code repetition with buttons, separate logics into extensions
@IBDesignable
open class PlayerView: UIView {
    
    public var view: UIView!
    public var delegate: PlayerViewDelegate?
    
    @IBOutlet private var coverImageView: UIImageView!
    @IBOutlet private var timeLabel: UILabel!
    
    @IBOutlet private var action1: UIButton!
    @IBOutlet private var action2: UIButton!
    @IBOutlet private var action3: UIButton!
    
    @IBOutlet private var action1ButtonWidth: NSLayoutConstraint!
    @IBOutlet private var action1ButtonHeight: NSLayoutConstraint!
    
    @IBOutlet private var action2ButtonWidth: NSLayoutConstraint!
    @IBOutlet private var action2ButtonHeight: NSLayoutConstraint!
    
    @IBOutlet private var action3ButtonWidth: NSLayoutConstraint!
    @IBOutlet private var action3ButtonHeight: NSLayoutConstraint!
    
    /// duration of song
    public var progress = 0.0
    
    var isPlaying = false
    
    // action button images
    public var action1SelectedImg: UIImage?
    public var action1UnselectedImg: UIImage?
    
    public var action2SelectedImg: UIImage?
    public var action2UnselectedImg: UIImage?
    
    public var action3SelectedImg: UIImage?
    public var action3UnselectedImg: UIImage?
    
    
    /// progress colors
    public var progressEmptyColor = UIColor.white
    public var progressFullColor = UIColor.red
    
    /// used to change current time of the sound . default is true
    var panEnabled = true
    
    
    /// Timer for updating time
    private var timer: Timer!
    
    /// Controlling progress bar animation
    private var isAnimating = false
    
    /// increasing duration in updateTime
    private var duration: Double{
        didSet {
            redrawStrokeEnd()
            delegate?.playerView(didChangeDuration: self, currentDuration: duration)
        }
    }
    
    private var circleLayer: CAShapeLayer! = CAShapeLayer()
    
    
    //MARK: inits
    
    override init(frame: CGRect) {
        duration = 0
        super.init(frame: frame)
        createUI()
        addPanGesture()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        duration = 0
        super.init(coder: aDecoder)
        createUI()
        addPanGesture()
    }
    
    
    //MARK: setup UI
    
    private func createUI() {
        layoutIfNeeded()
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        coverImageView.backgroundColor = UIColor.clear
        view.backgroundColor = UIColor.clear
        
        makeViewRounded(view, newSize: view.bounds.width)
        backgroundColor = UIColor.clear
        
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PlayerView", bundle: bundle)
        
        //FIXME:
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    //MARK: -
    
    
    /* Start timer and animation */
    @objc public func start(){
        startTimer()
    }
    
    /* Stop timer and animation */
    public func stop(){
        stopTimer()
    }
    
    public func restartWithProgress(duration: Double) {
        progress = duration
        resetAnimationCircle()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(Self.start), userInfo: nil, repeats: false)
    }
    
    
    @objc func updateTime() {
        
        duration += 0.1
        let totalDuration = Int(duration)
        let min = totalDuration / 60
        let sec = totalDuration % 60
        
        timeLabel.text = NSString(format: "%i:%02i",min,sec ) as String
        
        if duration >= progress {
            stopTimer()
        }
    }
    
    //MARK: -
    
    var isAction1Selected: Bool = false {
        didSet {
            if isAction1Selected {
                action1.isSelected = true
                action1.setImage(action1SelectedImg, for: UIControl.State.selected)
            } else {
                action1.isSelected = false
                action1.setImage(action1UnselectedImg, for: UIControl.State.normal)
            }
        }
    }
    
    var isAction2Selected: Bool = false {
        didSet {
            if isAction2Selected {
                action2.isSelected = true
                action2.setImage(action2SelectedImg, for: UIControl.State.selected)
            }else {
                action2.isSelected = false
                action2.setImage(action2UnselectedImg, for: UIControl.State.normal)
            }
        }
    }
    
    var isAction3Selected: Bool = false {
        didSet {
            if isAction3Selected {
                action3.isSelected = true
                action3.setImage(action3SelectedImg, for: UIControl.State.selected)
                
            } else {
                action3.isSelected = false
                action3.setImage(action3UnselectedImg, for: UIControl.State.normal)
            }
        }
    }
    
    
    /* Setting action buttons constraint width - height with buttonSizes */
    @IBInspectable var buttonSizes: CGFloat = 20.0 {
        didSet {
            action1ButtonHeight.constant = buttonSizes
            action1ButtonWidth.constant = buttonSizes
            action2ButtonHeight.constant = buttonSizes
            action2ButtonWidth.constant = buttonSizes
            action3ButtonHeight.constant = buttonSizes
            action3ButtonWidth.constant = buttonSizes
        }
    }
    
    
    //MARK: images
    
    // set Images in storyBoard with IBInspectable variables
    
    @IBInspectable var coverImage: UIImage? {
        get {
            return coverImageView.image
        }
        set {
            coverImageView.image = newValue
        }
    }
    
    @IBInspectable var action1_icon_selected: UIImage? {
        get {
            return action1SelectedImg
        }
        set {
            action1.setImage(newValue, for: UIControl.State.selected)
            action1SelectedImg = newValue
        }
    }
    
    @IBInspectable var action1_icon_unselected: UIImage? {
        get {
            return action1UnselectedImg
        }
        set {
            action1.setImage(newValue, for: UIControl.State.normal)
            action1UnselectedImg = newValue
        }
    }
    
    @IBInspectable var action2_icon_selected: UIImage? {
        get {
            return action2SelectedImg
        }
        set {
            action2.setImage(newValue, for: UIControl.State.selected)
            action2SelectedImg = newValue
        }
    }
    
    @IBInspectable var action2_icon_unselected: UIImage? {
        get {
            return action2UnselectedImg
        }
        set {
            action2.setImage(newValue, for: UIControl.State.normal)
            action2UnselectedImg = newValue
        }
    }
    
    @IBInspectable var action3_icon_selected: UIImage? {
        get {
            return action3SelectedImg
        }
        set {
            action3.setImage(newValue, for: UIControl.State.selected)
            action3SelectedImg = newValue
        }
    }
    
    @IBInspectable var action3_icon_unselected: UIImage? {
        get {
            return action3UnselectedImg
        }
        set {
            action3.setImage(newValue, for: UIControl.State.normal)
            action3UnselectedImg = newValue
        }
    }
    
    //MARK: buttons
    
    @IBAction private func action1ButtonTapped(sender: UIButton) {
        
        // any better way??
        sender.isSelected = !sender.isSelected
        isAction1Selected = sender.isSelected
        
        delegate?.action1ButtonTapped(sender: sender, isSelected: sender.isSelected)
    }
    
    @IBAction private func action2ButtonTapped(sender: UIButton) {
        
        // any better way??
        sender.isSelected = !sender.isSelected
        isAction2Selected = sender.isSelected
        
        delegate?.action2ButtonTapped(sender: sender, isSelected: sender.isSelected)
    }
    
    @IBAction private func action3ButtonTapped(sender: UIButton) {
        
        // any better way??
        sender.isSelected = !sender.isSelected
        isAction3Selected = sender.isSelected
        
        delegate?.action3ButtonTapped(sender: sender, isSelected: sender.isSelected)
    }
    
    // MARK: - Gestures
    
    func addPanGesture(){
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(Self.handlePanGesture))
        gesture.maximumNumberOfTouches = 1
        addGestureRecognizer(gesture)
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer){
        
        guard panEnabled else {
            return
        }
        
        let translation = gesture.translation(in: self)
        
        let xDirection  = translation.x
        let yDirection =  -1 * translation.y
        
        // rate of forward/backwards
        let rate = yDirection+xDirection
        
        
        switch gesture.state {
        case .began:
            stopTimer()
            
        case .changed:
            duration += Double(rate/4)
            
            if duration < 0 {
                duration = 0
            } else if duration >= progress {
                duration = progress
            }
        case .ended:
            startTimer()
            
        default:
            break
        }
        
        gesture.setTranslation(CGPoint.zero, in: self)
    }
    
    
    //MARK: drawing
    
    override open func draw(_ rect: CGRect) {
        
        addCirle(arcRadius: bounds.width + 10, capRadius: 2.0, color: progressEmptyColor,strokeStart: 0.0,strokeEnd: 1.0)
        createProgressCircle()
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        
        circleLayer.strokeColor = progressFullColor.cgColor
        isAnimating = true
        duration = 0
    }
    
    func animationDidStop(_ anim: CAAnimation,
                          finished flag: Bool) {
        
        isAnimating = false
        circleLayer.strokeColor = UIColor.clear.cgColor
        
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    
    
    private func makeViewRounded(_ view: UIView,
                                 newSize: CGFloat){
        
        let saveCenter = view.center
        let newFrame = CGRect(x: view.frame.origin.x,y: view.frame.origin.y,width: newSize,height: newSize)
        view.frame = newFrame
        view.layer.cornerRadius = newSize / 2.0
        view.clipsToBounds = true
        view.center = saveCenter
    }
    
    private func addCirle(arcRadius: CGFloat,
                          capRadius: CGFloat,
                          color: UIColor,
                          strokeStart: CGFloat,
                          strokeEnd: CGFloat) {
        
        let centerPoint = CGPoint(x: bounds.midX ,y: bounds.midY)
        let startAngle = CGFloat(Double.pi/2)
        let endAngle = CGFloat(Double.pi * 2 + Double.pi/2)
        
        let path = UIBezierPath(arcCenter:centerPoint, radius: frame.width/2+5, startAngle:startAngle, endAngle:endAngle, clockwise: true).cgPath
        
        let arc = CAShapeLayer()
        arc.lineWidth = 2
        arc.path = path
        arc.strokeStart = strokeStart
        arc.strokeEnd = strokeEnd
        arc.strokeColor = color.cgColor
        arc.fillColor = UIColor.clear.cgColor
        arc.shadowColor = UIColor.black.cgColor
        arc.shadowRadius = 0
        arc.shadowOpacity = 0
        arc.shadowOffset = CGSize.zero
        layer.addSublayer(arc)
    }
    
    
    private func createProgressCircle() {
        
        let centerPoint = CGPoint(x: bounds.midX ,y: bounds.midY)
        let startAngle = CGFloat(Double.pi/2)
        let endAngle = CGFloat(Double.pi * 2 + Double.pi/2)
        
        let circlePath = UIBezierPath(arcCenter:centerPoint, radius: frame.width/2+5, startAngle:startAngle, endAngle:endAngle, clockwise: true).cgPath
        
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.shadowColor = UIColor.black.cgColor
        circleLayer.strokeColor = progressFullColor.cgColor
        circleLayer.lineWidth = 2.0
        circleLayer.strokeStart = 0.0
        circleLayer.shadowRadius = 0
        circleLayer.shadowOpacity = 0
        circleLayer.shadowOffset = CGSize.zero
        
        circleLayer.strokeEnd = CGFloat(duration/progress)
        
        layer.addSublayer(circleLayer)
    }
    
    
    private func redrawStrokeEnd(){
        circleLayer.strokeEnd = CGFloat(duration/progress)
    }
    
    private func resetAnimationCircle(){
        stopTimer()
        duration = 0
        circleLayer.strokeEnd = 0
    }
    
    
    
    //MARK: timer
    
    
    private func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(Self.updateTime), userInfo: nil, repeats: true)
        
        delegate?.playerView(didStartPlaying: self)
    }
    
    private func stopTimer(){
        
        if timer != nil {
            timer.invalidate()
            timer = nil
            delegate?.playerView(didStopPlaying: self)
        }
    }
    
    
    //???
    //    private func pause(_ layer: CALayer) {
    //        let pauseTime = layer.convertTime(CACurrentMediaTime(), from: nil)
    //        layer.speed = 0.0
    //        layer.timeOffset = pauseTime
    //    }
    
    //    private func resume(_ layer: CALayer) {
    //        let pausedTime = layer.timeOffset
    //        layer.speed = 1.0
    //        layer.timeOffset = 0.0
    //        layer.beginTime = 0.0
    //        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    //        layer.beginTime = timeSincePause
    //    }
}




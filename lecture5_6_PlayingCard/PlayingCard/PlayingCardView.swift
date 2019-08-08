//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Yun Zhang on 8/1/19.
//  Copyright © 2019 Yun Zhang. All rights reserved.
//
// go to size inspector of storyboard to modify constrains
// ctrl drag to self to specify aspect ratio
import UIKit
// to cread new UIView, go to file, create new CocoTouchClass. In storyboard library, add Playing Card View
@IBDesignable // to look view design in stoury board without simulator
class PlayingCardView: UIView {
    @IBInspectable // TO change the rank and suit in inspector
    var rank: Int = 5 { didSet { setNeedsDisplay() ; setNeedsLayout() } } // redraw the card when rank change. Image wont show
    @IBInspectable
    var suit: String = "♥️" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var isFaceUp: Bool = true { didSet { setNeedsDisplay() ; setNeedsLayout()} }
  // To make it pinchable
    var faceCardScale: CGFloat =  SizeRatio.faceCardImageSizeToBoundSize { didSet { setNeedsLayout()} }
    // Handler for "Pinch" gesture
    @objc func adjustFaceCardScale(byHandlingGestureRecognizedBy recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .changed, .ended:
            faceCardScale *= recognizer.scale
            recognizer.scale = 1.0 // [!]: Makes the changes of the scale _incremental_
        default: break
        }
    }
    
    
    private var cornerString: NSAttributedString
    {
        // rankSting defined in extension
        return centerAttributedString(rankString + "\n" + suit, fontSize: cornerFontSize)
    }
    
    // Helper function
    // Input: a [font] and [size]
    // Output: NS-attributed [font] and [size]
    private func centerAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString
    {
        // Automatic font scaling    .body is a fond style
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
     // dynamic scaling font when sliding
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        
        // Paragraph style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        // Return an NSAttributedString
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle : paragraphStyle, NSAttributedString.Key.font : font])
    }
    
    // called when app setting change
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay() // content need to redraw?
        setNeedsLayout() // adjust layout? change font etc
    }
    
    // until fully initialzed, cannot call method on ourself? lazy make it wont be initialized until be asked for it
    // https://medium.com/@abhimuralidharan/lazy-var-in-ios-swift-96c75cb8a13a
    lazy private var upperLeftCornerLabel = createCornerLabel() // here to draw label
    lazy private var lowerRightCornerLabel = createCornerLabel()
    
    private func createCornerLabel() -> UILabel
    {
        let label = UILabel()
        label.numberOfLines = 0 // Use as many as you wish
        addSubview(label) // add this label as sub view when draw, ; setNeedsLayout() is needed
        return label
    }
    
    private func configureCornerLabel(_ label: UILabel)
    {
        label.attributedText = cornerString
        label.frame.size = CGSize.zero // [!] - Reset size from original width, so to use size to fit
        label.sizeToFit()
        label.isHidden = !isFaceUp
    }


    

    
    // When compile, this function run to show view: https://stackoverflow.com/questions/728372/when-is-layoutsubviews-called
    override func layoutSubviews()
    {
        // UIView has this method use UILayout. Layout for attributed string?
        super.layoutSubviews()
        
        configureCornerLabel(upperLeftCornerLabel) // here we use the lazy variable
        
        // Card symbol: Make the bottom right corner symbol upside-down
        // identity is identity transformation
        lowerRightCornerLabel.transform = CGAffineTransform.identity
            .translatedBy(x: lowerRightCornerLabel.frame.size.width, y: lowerRightCornerLabel.frame.size.height) // Move it
            .rotated(by: CGFloat.pi)// rotate is by origion, which is topleft cornor, so need to move first
        configureCornerLabel(lowerRightCornerLabel)
        
        
        upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
            .offsetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height )
    }
    
    private func drawPips()
    {
        let pipsPerRowForRank = [[0], [1], [1,1], [1,1,1], [2,2], [2,1,2], [2,2,2], [2,1,2,2], [2,2,2,2], [2,2,1,2,2], [2,2,2,2,2]]
        
        func createPipString(thatFits pipRect: CGRect) -> NSAttributedString {
            // $0 is 0, $1 loop through each subarray. return max length as the rows of pips max pips
            let maxVerticalPipCount = CGFloat(pipsPerRowForRank.reduce(0) { max($1.count, $0)})
            //
            let maxHorizontalPipCount = CGFloat(pipsPerRowForRank.reduce(0) { max($1.max() ?? 0, $0)})
            let verticalPipRowSpacing = pipRect.size.height / maxVerticalPipCount
            let attemptedPipString = centerAttributedString(suit, fontSize: verticalPipRowSpacing)
            let probablyOkayPipStringFontSize = verticalPipRowSpacing / (attemptedPipString.size().height / verticalPipRowSpacing)
            let probablyOkayPipString = centerAttributedString(suit, fontSize: probablyOkayPipStringFontSize)
            if probablyOkayPipString.size().width > pipRect.size.width / maxHorizontalPipCount {
                return centerAttributedString(suit, fontSize: probablyOkayPipStringFontSize /
                    (probablyOkayPipString.size().width / (pipRect.size.width / maxHorizontalPipCount)))
            } else {
                return probablyOkayPipString
            }
        }
        
        if pipsPerRowForRank.indices.contains(rank) {
            let pipsPerRow = pipsPerRowForRank[rank]
            var pipRect = bounds.insetBy(dx: cornerOffset, dy: cornerOffset).insetBy(dx: cornerString.size().width, dy: cornerString.size().height / 2)
            let pipString = createPipString(thatFits: pipRect)
            let pipRowSpacing = pipRect.size.height / CGFloat(pipsPerRow.count)
            pipRect.size.height = pipString.size().height
            pipRect.origin.y += (pipRowSpacing - pipRect.size.height) / 2
            for pipCount in pipsPerRow {
                switch pipCount {
                case 1:
                    pipString.draw(in: pipRect)
                case 2:
                    pipString.draw(in: pipRect.leftHalf)
                    pipString.draw(in: pipRect.rightHalf)
                default:
                    break
                }
                pipRect.origin.y += pipRowSpacing
            }
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
//        //  chorigraphic?
//        if let context = UIGraphicsGetCurrentContext(){
//            context.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY),  radius: 100.0, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
//            // set part
//            context.setLineWidth(5.0)
//            UIColor.green.setFill()
//            UIColor.red.setStroke()
//            // actual drawing, consume the path
//            context.strokePath()
//            context.fillPath()
//        }
        
        
        // draw card
        // bounds is a default rect, white round backgound
        let rounded_rec = UIBezierPath(roundedRect: bounds, cornerRadius: 16.0) // bad stype: magic number
        rounded_rec.addClip()
        UIColor.white.setFill()
        rounded_rec.fill()

    // draw a filled circle, the first draw will be covered
            let context = UIBezierPath()
            context.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.minY + 10),  radius: 10.0, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
            // set part
            context.lineWidth = 5.0
            UIColor.green.setFill()
            UIColor.red.setStroke()
            // actual drawing, does not consume the path, so stroke and fill
            context.stroke()
            context.fill()
        // drag pin to four edges, circle to oval when turn
        // go to story board and, in View panel, change content mode to Redraw
  
    // draw card image
        // name has to be same in assest
        if isFaceUp{
                 // , in: Bundle(for: self.classForCoder), compatibleWith: traitCollection to make story board show design with @IBDesign
            if let faceCardImage = UIImage(named: rankString+suit, in: Bundle(for: self.classForCoder), compatibleWith: traitCollection){
 // to make card zoomble, change zoom(by: SizeRatio.faceCardImageSizeToBoundSize) to
                faceCardImage.draw(in: bounds.zoom(by: faceCardScale))
            }else{
                drawPips()
            }
        }else{
            if let cardBackImage = UIImage(named: "cardback", in: Bundle(for: self.classForCoder), compatibleWith: traitCollection){
                cardBackImage.draw(in: bounds)
            }
        }

        
    }


    

}

// ===============================================================================
// EXTENSIONS
// ===============================================================================
extension PlayingCardView {
    
    // Setting constants
    private struct SizeRatio
    {
        static let cornerFontSizeToBoundHeight: CGFloat     = 0.085
        static let cornerRadiusToBoundHeight: CGFloat       = 0.06
        static let cornerOffsetToCornerRadius: CGFloat      = 0.33
        static let faceCardImageSizeToBoundSize: CGFloat    = 0.63
    }
    
    private var cornerRadius: CGFloat
    {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundHeight
    }
    
    private var cornerOffset: CGFloat
    {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    
    private var cornerFontSize: CGFloat
    {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundHeight
    }
    
    private var rankString: String
    {
        switch rank
        {
        case 1:
            return "A"
        case 2...10: return
            String(rank)
        case 11:
            return "J"
        case 12:
            return "Q"
        case 13:
            return "K"
        default:
            return "?"
        }
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }
}

extension CGRect {
    func zoom(by zoomFactor: CGFloat) -> CGRect {
        let zoomedWidth = size.width * zoomFactor
        let zoomedHeight = size.height * zoomFactor
        let originX = origin.x + (size.width - zoomedWidth) / 2
        let originY = origin.y + (size.height - zoomedHeight) / 2
        return CGRect(origin: CGPoint(x: originX,y: originY) , size: CGSize(width: zoomedWidth, height: zoomedHeight))
    }
    
    var leftHalf: CGRect {
        let width = size.width / 2
        return CGRect(origin: origin, size: CGSize(width: width, height: size.height))
    }
    
    var rightHalf: CGRect {
        let width = size.width / 2
        return CGRect(origin: CGPoint(x: origin.x + width, y: origin.y), size: CGSize(width: width, height: size.height))
    }
}

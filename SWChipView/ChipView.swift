//
//  ChipView.swift
//  SWChipView
//
//  Created by kual chavhan on 6/14/16.
//  Copyright © 2016 kunal chavhan. All rights reserved.
//

import UIKit
import Kingfisher

@IBDesignable
public class ChipView: UIButton {
    
    
    // MARK: chip avatar
    
    let chipAvatar = ChipAvatar()
    
    @IBInspectable public var enableChipAvatar : Bool = false {
        didSet {
            chipAvatar.hidden = !enableChipAvatar
            updateLeftInsets()
        }
    }
    
    @IBInspectable public var chipAvatarCornerRadius : CGFloat = 12 {
        
        didSet {
            chipAvatar.layer.cornerRadius = chipAvatarCornerRadius
            updateLeftInsets()
        }
    }
    
    @IBInspectable public var chipAvatarWidth : CGFloat = 24 {
        
        didSet {
            chipAvatar.frame.size.width = chipAvatarWidth
            updateLeftInsets()
        }
    }
    
    @IBInspectable public var chipAvatarHeight : CGFloat = 24 {
        
        didSet {
            chipAvatar.frame.size.height = chipAvatarHeight
            chipAvatar.clipsToBounds = true
            updateLeftInsets()
        }
    }
    
    @IBInspectable public var setChipAvatarWithUrl : String = ""{
        
        didSet {
            chipAvatar.kf_setImageWithURL(NSURL(string : setChipAvatarWithUrl)!, placeholderImage: nil)
            updateLeftInsets()
        }
    }
    
    //    @IBInspectable public var setChipAvatarWithImage : UIImage = UIImage(named : "bg")! {
    //
    //        didSet {
    //            chipAvatar.image = setChipAvatarWithImage
    //            updateLeftInsets()
    //
    //        }
    //    }
    //
   
    
    // MARK: chip style
    
    @IBInspectable public var textColor: UIColor = UIColor.whiteColor() {
        didSet {
            reInitStyles()
        }
    }
    @IBInspectable public var selectedTextColor: UIColor = UIColor.whiteColor() {
        didSet {
            reInitStyles()
        }
    }
    @IBInspectable public var paddingY: CGFloat = 5 {
        didSet {
            titleEdgeInsets.top = paddingY
            titleEdgeInsets.bottom = paddingY
        }
    }
    @IBInspectable public var paddingX: CGFloat = 10 {
        didSet {
            titleEdgeInsets.left = paddingX
            updateRightInsets()
        }
    }

    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var borderColor: UIColor? {
        didSet {
            reInitStyles()
        }
    }
    
    
    @IBInspectable public var chipBackgroundColor : UIColor = UIColor.redColor() {
        didSet {
            reInitStyles()
        }
    }
    
    @IBInspectable public var highlightedBackgroundColor: UIColor? {
        didSet {
            reInitStyles()
        }
    }
    
    @IBInspectable public var selectedBorderColor: UIColor? {
        didSet {
            reInitStyles()
        }
    }
    
    @IBInspectable public var selectedBackgroundColor: UIColor? {
        didSet {
            reInitStyles()
        }
    }
    
    var textFont: UIFont = UIFont.systemFontOfSize(14) {
        didSet {
            titleLabel?.font = textFont
        }
    }
    
    
    private func reInitStyles() {
        if highlighted {
            if let highlightedBackgroundColor = highlightedBackgroundColor {
                backgroundColor = highlightedBackgroundColor
            }
        }
        else if selected {
            backgroundColor = selectedBackgroundColor ?? chipBackgroundColor
            layer.borderColor = selectedBorderColor?.CGColor ?? borderColor?.CGColor
            setTitleColor(selectedTextColor, forState: .Normal)
        }
        else {
            backgroundColor = chipBackgroundColor
            layer.borderColor = borderColor?.CGColor
            setTitleColor(textColor, forState: .Normal)
        }
    }
    
    override public var highlighted: Bool {
        didSet {
            reInitStyles()
        }
    }
    
    override public var selected: Bool {
        didSet {
            reInitStyles()
        }
    }
    
    
    // MARK: close button
    
    let closeButton = ChipClose()
    
    @IBInspectable public var enableCloseButton: Bool = false {
        didSet {
            closeButton.hidden = !enableCloseButton
            updateRightInsets()
        }
    }
    
    @IBInspectable public var closeButtonIconSize: CGFloat = 12 {
        didSet {
            closeButton.iconSize = closeButtonIconSize
            updateRightInsets()
        }
    }
    
    @IBInspectable public var closeIconLineWidth: CGFloat = 3 {
        didSet {
            closeButton.lineWidth = closeIconLineWidth
        }
    }
    @IBInspectable public var closeIconLineColor: UIColor = UIColor.whiteColor().colorWithAlphaComponent(0.54) {
        didSet {
            closeButton.lineColor = closeIconLineColor
        }
    }
    
    /// Handles Tap (TouchUpInside)
    public var onTap: ((ChipView) -> Void)?
    
    // MARK: - init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    public init(title: String,chipTag : Int) {
        super.init(frame: CGRectZero)
        tag = chipTag
        setTitle(title, forState: .Normal)
        
        setupView()
    }
    
    private func setupView() {
        frame.size = intrinsicContentSize()
        addSubview(closeButton)
        addSubview(chipAvatar)
        closeButton.chipView = self
        chipAvatar.chipView = self
    }
    
    // MARK: - layout
    
    private func updateRightInsets() {
        if enableCloseButton {
            titleEdgeInsets.right = paddingX  + closeButtonIconSize + paddingX
        }
        else {
            titleEdgeInsets.right = paddingX
        }
    }
    
    private func updateLeftInsets(){
        
        if enableChipAvatar {
            
            titleEdgeInsets.left = paddingX + chipAvatarWidth + paddingX
        } else {
            titleEdgeInsets.left = paddingX
            
        }
    }
    
    override public func intrinsicContentSize() -> CGSize {
        var size = titleLabel?.text?.sizeWithAttributes([NSFontAttributeName: textFont]) ?? CGSizeZero
        
        size.width += paddingX * 2
        if enableCloseButton {
            size.width += closeButtonIconSize + paddingX
        }
        
        if enableChipAvatar {
            size.height = chipAvatarHeight + paddingY   * 2
            size.width += chipAvatarWidth + paddingX
        } else {
            size.height = textFont.pointSize + paddingY * 2
            
        }
        
        return size
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if enableCloseButton {
            closeButton.frame.size.width = paddingX + closeButtonIconSize + paddingX
            closeButton.frame.origin.x = self.frame.width - closeButton.frame.width
            closeButton.frame.size.height = self.frame.height
            closeButton.frame.origin.y = 0
        }
        
        if enableChipAvatar {
            
            //chipAvatar.frame.size.width = paddingX  + chipAvatarWidth + paddingX
            chipAvatar.frame.size.width =  chipAvatarWidth
            
            // chipAvatar.frame.origin.x = self.frame.width - chipAvatarWidth
            chipAvatar.frame.origin.x =  chipAvatarWidth/2
            
            chipAvatar.frame.size.height = chipAvatarHeight
            chipAvatar.frame.origin.y = paddingY
        }
    }
}


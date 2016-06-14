//
//  ChipListView.swift
//  SWChipView
//
//  Created by kunal Chavhan on 6/14/16.
//  Copyright © 2016 kunal chavhan. All rights reserved.
//

import UIKit


@IBDesignable
public class ChipListView: UIView {
    
    
    // MARK: chip avatar style
    
    @IBInspectable public var enableChipAvatar : Bool = false {
        didSet {
            for chipView in chipViews {
                chipView.enableChipAvatar = enableChipAvatar
            }
            organiseViews()
        }
        
    }
    
    @IBInspectable public var chipAvatarWidth : CGFloat = 24 {
        didSet {
            for chipView in chipViews {
                chipView.chipAvatarWidth = chipAvatarWidth
            }
            organiseViews()
        }
        
    }
    
    @IBInspectable public var chipAvatarHeight : CGFloat = 24 {
        didSet {
            for chipView in chipViews {
                chipView.chipAvatarHeight = chipAvatarHeight
            }
            organiseViews()
        }
        
    }
    
    @IBInspectable public var setChipAvatarWithUrl : String = "" {
        didSet {
            for chipView in chipViews {
                chipView.setChipAvatarWithUrl = setChipAvatarWithUrl
            }
            organiseViews()
        }
        
    }
    
    //    @IBInspectable public var setChipAvatarWithImage : UIImage = UIImage(named : "bg")! {
    //        didSet {
    //            for chipView in chipViews {
    //                chipView.setChipAvatarWithImage = setChipAvatarWithImage
    //            }
    //            organiseViews()
    //        }
    //
    //    }
    //
    
    @IBInspectable public var chipAvatarCornerRadius : CGFloat = 12 {
        didSet {
            for chipView in chipViews {
                chipView.chipAvatarCornerRadius = chipAvatarWidth/2
                
            }
            organiseViews()
        }
        
    }
    
    // MARK: chip view style
    
    @IBInspectable public var textColor: UIColor = UIColor.whiteColor() {
        didSet {
            for chipView in chipViews {
                chipView.textColor = textColor
            }
        }
    }
    
    @IBInspectable public var selectedTextColor: UIColor = UIColor.whiteColor() {
        didSet {
            for chipView in chipViews {
                chipView.selectedTextColor = selectedTextColor
            }
        }
    }
    
    @IBInspectable public var chipBackgroundColor: UIColor = UIColor.redColor() {
        didSet {
            for chipView in chipViews {
                chipView.chipBackgroundColor = chipBackgroundColor
            }
        }
    }
    
    @IBInspectable public var chipHighlightedBackgroundColor: UIColor? {
        didSet {
            for chipView in chipViews {
                chipView.highlightedBackgroundColor = chipHighlightedBackgroundColor
            }
        }
    }
    
    @IBInspectable public var chipSelectedBackgroundColor: UIColor? {
        didSet {
            for chipView in chipViews {
                chipView.selectedBackgroundColor = chipSelectedBackgroundColor
            }
        }
    }
    
    @IBInspectable public var chipCornerRadius: CGFloat = 0 {
        didSet {
            for chipView in chipViews {
                chipView.cornerRadius = chipCornerRadius
            }
        }
    }
    @IBInspectable public var chipBorderWidth: CGFloat = 0 {
        didSet {
            for chipView in chipViews {
                chipView.borderWidth = chipBorderWidth
            }
        }
    }
    
    @IBInspectable public var chipBorderColor: UIColor? {
        didSet {
            for chipView in chipViews {
                chipView.borderColor = chipBorderColor
            }
        }
    }
    
    @IBInspectable public var selectedBorderColor: UIColor? {
        didSet {
            for chipView in chipViews {
                chipView.selectedBorderColor = selectedBorderColor
            }
        }
    }
    
    @IBInspectable public var paddingY: CGFloat = 5 {
        didSet {
            for chipView in chipViews {
                chipView.paddingY = paddingY
            }
            organiseViews()
        }
    }
    @IBInspectable public var paddingX: CGFloat = 10 {
        didSet {
            for chipView in chipViews {
                chipView.paddingX = paddingX
            }
            organiseViews()
        }
    }
    @IBInspectable public var marginY: CGFloat = 2 {
        didSet {
            organiseViews()
        }
    }
    @IBInspectable public var marginX: CGFloat = 5 {
        didSet {
            organiseViews()
        }
    }
    
    @objc public enum Alignment: Int {
        case Left
        case Center
        case Right
    }
    @IBInspectable public var alignment: Alignment = .Left {
        didSet {
            organiseViews()
        }
    }
    @IBInspectable public var shadowColor: UIColor = UIColor.whiteColor() {
        didSet {
            organiseViews()
        }
    }
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet {
            organiseViews()
        }
    }
    @IBInspectable public var shadowOffset: CGSize = CGSizeZero {
        didSet {
            organiseViews()
        }
    }
    @IBInspectable public var shadowOpacity: Float = 0 {
        didSet {
            organiseViews()
        }
    }
    
    // MARK: close button style
    
    @IBInspectable public var enableCloseButton: Bool = false {
        didSet {
            for chipView in chipViews {
                chipView.enableCloseButton = enableCloseButton
            }
            organiseViews()
        }
    }
    
    
    @IBInspectable public var closeButtonIconSize: CGFloat = 12 {
        didSet {
            for chipView in chipViews {
                chipView.closeButtonIconSize = closeButtonIconSize
            }
            organiseViews()
        }
    }
    @IBInspectable public var closeIconLineWidth: CGFloat = 1 {
        didSet {
            for chipView in chipViews {
                chipView.closeIconLineWidth = closeIconLineWidth
            }
            organiseViews()
        }
    }
    
    @IBInspectable public var closeIconLineColor: UIColor = UIColor.whiteColor().colorWithAlphaComponent(0.54) {
        didSet {
            for chipView in chipViews {
                chipView.closeIconLineColor = closeIconLineColor
            }
            organiseViews()
        }
    }
    
    
    public var textFont: UIFont = UIFont.systemFontOfSize(12) {
        didSet {
            for chipView in chipViews {
                chipView.textFont = textFont
            }
            organiseViews()
        }
    }
    
    @IBOutlet public weak var delegate: ChipListViewDelegate?
    
    private(set) var rowCount = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    public private(set) var chipViews: [ChipView] = []
    private(set) var chipBackgroundViews: [UIView] = []
    private(set) var rowViews: [UIView] = []
    private(set) var chipViewHeight: CGFloat = 0
    
    // MARK: - Interface Builder
    
    public override func prepareForInterfaceBuilder() {
        addChip("chip view",chipTag: 0)
        addChip("for",chipTag: 0).selected = true
        addChip("ios",chipTag: 0)
    }
    
    public func addChip(title: String,chipTag : Int) -> ChipView {
        let chipView = ChipView(title: title, chipTag : chipTag)
        
        // MARK: chip avatar
        chipView.chipAvatarWidth = chipAvatarWidth
        chipView.setChipAvatarWithUrl = setChipAvatarWithUrl
        // chipView.setChipAvatarWithImage = setChipAvatarWithImage
        chipView.chipAvatarHeight = chipAvatarHeight
        chipView.enableChipAvatar = enableChipAvatar
        chipView.chipAvatarCornerRadius = chipAvatarCornerRadius
        
        // MARK: chip close button
        chipView.closeIconLineWidth = closeIconLineWidth
        chipView.closeButtonIconSize = closeButtonIconSize
        chipView.enableCloseButton = enableCloseButton
        chipView.closeIconLineColor = closeIconLineColor
        
        // MARK: chip
        chipView.textColor = textColor
        chipView.selectedTextColor = selectedTextColor
        chipView.chipBackgroundColor = chipBackgroundColor
        chipView.highlightedBackgroundColor = chipHighlightedBackgroundColor
        chipView.selectedBackgroundColor = chipSelectedBackgroundColor
        chipView.cornerRadius = chipCornerRadius
        chipView.borderWidth = chipBorderWidth
        chipView.borderColor = chipBorderColor
        chipView.selectedBorderColor = selectedBorderColor
        chipView.paddingX = paddingX
        chipView.paddingY = paddingY
        chipView.textFont = textFont
        
        
        chipView.addTarget(self, action: #selector(chipTapped(_:)), forControlEvents: .TouchUpInside)
        chipView.closeButton.addTarget(self, action: #selector(closeButtonPressed(_:)), forControlEvents: .TouchUpInside)
        
        return addChipView(chipView)
    }
    
    public func addChipView(chipView: ChipView) -> ChipView {
        chipViews.append(chipView)
        chipBackgroundViews.append(UIView(frame: chipView.bounds))
        organiseViews()
        
        return chipView
    }
    

    
    // MARK: - Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        organiseViews()
    }
    
    private func organiseViews() {
        let views = chipViews as [UIView] + chipBackgroundViews + rowViews
        for view in views {
            view.removeFromSuperview()
        }
        rowViews.removeAll(keepCapacity: true)
        
        var currentRow = 0
        var currentRowView: UIView!
        var currentRowTagCount = 0
        var currentRowWidth: CGFloat = 0
        for (index, chipView) in chipViews.enumerate() {
            chipView.frame.size = chipView.intrinsicContentSize()
            chipViewHeight = chipView.frame.height + 10.0
            
            if currentRowTagCount == 0 || currentRowWidth + chipView.frame.width > frame.width {
                currentRow += 1
                currentRowWidth = 0
                currentRowTagCount = 0
                currentRowView = UIView()
                currentRowView.frame.origin.y = CGFloat(currentRow - 1) * (chipViewHeight + marginY)
                
                rowViews.append(currentRowView)
                addSubview(currentRowView)
            }
            
            let chipBackgroundView = chipBackgroundViews[index]
            chipBackgroundView.frame.origin = CGPoint(x: currentRowWidth, y: 0)
            chipBackgroundView.frame.size = chipView.bounds.size
            chipBackgroundView.layer.shadowColor = shadowColor.CGColor
            chipBackgroundView.layer.shadowPath = UIBezierPath(roundedRect: chipBackgroundView.bounds, cornerRadius: chipCornerRadius).CGPath
            chipBackgroundView.layer.shadowOffset = shadowOffset
            chipBackgroundView.layer.shadowOpacity = shadowOpacity
            chipBackgroundView.layer.shadowRadius = shadowRadius
            chipBackgroundView.addSubview(chipView)
            currentRowView.addSubview(chipBackgroundView)
            
            currentRowTagCount += 1
            currentRowWidth += chipView.frame.width + marginX
            
            switch alignment {
            case .Left:
                currentRowView.frame.origin.x = 0
            case .Center:
                currentRowView.frame.origin.x = (frame.width - (currentRowWidth - marginX)) / 2
            case .Right:
                currentRowView.frame.origin.x = frame.width - (currentRowWidth - marginX)
            }
            currentRowView.frame.size.width = currentRowWidth
            currentRowView.frame.size.height = max(chipViewHeight, currentRowView.frame.height)
        }
        rowCount = currentRow
    }
    
    // MARK: - Manage chips
    
    public override func intrinsicContentSize() -> CGSize {
        var height = CGFloat(rowCount) * (chipViewHeight + marginY)
        if rowCount > 0 {
            height -= marginY
        }
        return CGSizeMake(frame.width, height)
    }
    
      public func removeChip(title: String) {
        // loop the array in reversed order to remove items during loop
        for index in (chipViews.count - 1).stride(through: 0, by: -1) {
            let chipView = chipViews[index]
            if chipView.currentTitle == title {
                removeChipView(chipView)
            }
        }
    }
    
    public func getRowCount() -> CGFloat {
        return CGFloat(rowCount)
    }
    
    public func getChipViewHeight() -> CGFloat{
        return chipViewHeight
    }
    
    public func removeChipView(chipView: ChipView) {
        chipView.removeFromSuperview()
        if let index = chipViews.indexOf(chipView) {
            chipViews.removeAtIndex(index)
            chipBackgroundViews.removeAtIndex(index)
        }
        
        organiseViews()
    }
    
    public func removeAllChips() {
        let views = chipViews as [UIView] + chipBackgroundViews
        for view in views {
            view.removeFromSuperview()
        }
        chipViews = []
        chipBackgroundViews = []
        organiseViews()
    }
    
    public func selectedChips() -> [ChipView] {
        return chipViews.filter() { $0.selected == true }
    }
    
    // MARK: - Events
    
    func chipTapped(sender: ChipView!) {
        sender.onTap?(sender)
        delegate?.chipTapped?(sender.currentTitle ?? "", chipView: sender, sender: self)
    }
    
    func closeButtonPressed(closeButton: ChipClose!) {
        if let chipView = closeButton.chipView {
            delegate?.chipCloseButtonPressed?(chipView.currentTitle ?? "", chipView: chipView, sender: self)
        }
        
        if let chipView = closeButton.chipView {
            delegate?.chipRemoveWithTag?(chipView.currentTitle ?? "", chipView: chipView, chipTag : chipView.tag , sender: self)
        }
        
    }
}

@objc public protocol ChipListViewDelegate {
    optional func chipRemoveWithTag(title: String, chipView: ChipView,chipTag : Int, sender: ChipListView) -> Void
    optional func chipTapped(title: String, chipView: ChipView, sender: ChipListView) -> Void
    optional func chipCloseButtonPressed(title: String, chipView: ChipView, sender: ChipListView) -> Void
  
}



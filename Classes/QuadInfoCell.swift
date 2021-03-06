//
//  QuadInfoCell.swift
//  kraftstoff
//
//  Created by Ingmar Stein on 03.05.15.
//
// TableView cells with four labels for information.

import UIKit

class QuadInfoCell: UITableViewCell {

	private(set) var topLeftLabel: UILabel
	private(set) var botLeftLabel: UILabel
	private(set) var topRightLabel: UILabel
	private(set) var botRightLabel: UILabel

	var topLeftAccessibilityLabel: String?
	var botLeftAccessibilityLabel: String?
	var topRightAccessibilityLabel: String?
	var botRightAccessibilityLabel: String?

	private var separatorView: UIView
	private var cellState: UITableViewCellStateMask
	private var large: Bool

	init(style: UITableViewCellStyle, reuseIdentifier: String?, enlargeTopRightLabel: Bool) {
		cellState     = .DefaultMask
		large         = enlargeTopRightLabel
		botLeftLabel  = UILabel(frame:CGRectZero)
		topLeftLabel  = UILabel(frame:CGRectZero)
		topRightLabel = UILabel(frame:CGRectZero)
		botRightLabel = UILabel(frame:CGRectZero)
		separatorView = UIView(frame:CGRectZero)

		super.init(style: style, reuseIdentifier: reuseIdentifier)

        topLeftLabel.backgroundColor            = UIColor.clearColor()
        topLeftLabel.textColor                  = UIColor.blackColor()
        topLeftLabel.adjustsFontSizeToFitWidth  = true
		topLeftLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
		self.contentView.addSubview(topLeftLabel)

        botLeftLabel.backgroundColor            = UIColor.clearColor()
        botLeftLabel.textColor                  = UIColor(white:0.5, alpha:1.0)
        botLeftLabel.adjustsFontSizeToFitWidth  = true
		botLeftLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentView.addSubview(botLeftLabel)

        topRightLabel.backgroundColor           = UIColor.clearColor()
        topRightLabel.textColor                 = UIColor.blackColor()
        topRightLabel.adjustsFontSizeToFitWidth = true
        topRightLabel.textAlignment             = .Right
		topRightLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
		self.contentView.addSubview(topRightLabel)

        botRightLabel.backgroundColor           = UIColor.clearColor()
        botRightLabel.textColor                 = UIColor(white:0.5, alpha:1.0)
        botRightLabel.adjustsFontSizeToFitWidth = true
        botRightLabel.textAlignment             = .Right
		botRightLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentView.addSubview(botRightLabel)

		separatorView.backgroundColor = UIColor(white:200.0/255.0, alpha:1.0)
		separatorView.setTranslatesAutoresizingMaskIntoConstraints(false)
		separatorView.preservesSuperviewLayoutMargins = false
		self.contentView.addSubview(separatorView)

		// setup contraints
		let separatorHeight = 1.0 / UIScreen.mainScreen().scale
		let views = ["topLeftLabel" : topLeftLabel, "botLeftLabel" : botLeftLabel, "topRightLabel" : topRightLabel, "botRightLabel" : botRightLabel]
		contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(20)-[topLeftLabel]-(2)-[botLeftLabel]-(20)-|", options: .allZeros, metrics: nil, views: views))
		contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(15)-[topLeftLabel]-(2)-[topRightLabel]-(15)-|", options: .allZeros, metrics: nil, views: views))
		contentView.addConstraint(NSLayoutConstraint(item: topLeftLabel, attribute: .Baseline, relatedBy: .Equal, toItem: topRightLabel, attribute: .Baseline, multiplier: 1.0, constant: 0.0))
		contentView.addConstraint(NSLayoutConstraint(item: botLeftLabel, attribute: .Baseline, relatedBy: .Equal, toItem: botRightLabel, attribute: .Baseline, multiplier: 1.0, constant: 0.0))
		contentView.addConstraint(NSLayoutConstraint(item: topLeftLabel, attribute: .Left, relatedBy: .Equal, toItem: botLeftLabel, attribute: .Left, multiplier: 1.0, constant: 0.0))
		contentView.addConstraint(NSLayoutConstraint(item: topRightLabel, attribute: .Right, relatedBy: .Equal, toItem: botRightLabel, attribute: .Right, multiplier: 1.0, constant: 0.0))
		self.addConstraint(NSLayoutConstraint(item: separatorView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: 0.0))
		self.addConstraint(NSLayoutConstraint(item: separatorView, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: 0.0))
		contentView.addConstraint(NSLayoutConstraint(item: separatorView, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
		separatorView.addConstraint(NSLayoutConstraint(item: separatorView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: separatorHeight))

		setupFonts()

		NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeCategoryDidChange:", name: UIContentSizeCategoryDidChangeNotification, object: nil)

		self.accessoryType = .DisclosureIndicator
    }

	deinit {
		NSNotificationCenter.defaultCenter().removeObserver(self)
	}

	func contentSizeCategoryDidChange(notification: NSNotification!) {
		setupFonts()
	}

	private func setupFonts() {
		topLeftLabel.font                = UIFont.lightApplicationFontForStyle(UIFontTextStyleSubheadline)
		topLeftLabel.minimumScaleFactor  = 12.0/topLeftLabel.font.pointSize
		botLeftLabel.font                = UIFont.lightApplicationFontForStyle(UIFontTextStyleBody)
		botLeftLabel.minimumScaleFactor  = 12.0/botLeftLabel.font.pointSize
		topRightLabel.font               = UIFont.lightApplicationFontForStyle(large ? UIFontTextStyleHeadline : UIFontTextStyleSubheadline)
		topRightLabel.minimumScaleFactor = 12.0/topRightLabel.font.pointSize
		botRightLabel.font               = UIFont.lightApplicationFontForStyle(UIFontTextStyleBody)
		botRightLabel.minimumScaleFactor = 12.0/botRightLabel.font.pointSize
	}

	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}

	override var accessibilityLabel: String! {
		get {
			var label = String(format:"%@, %@",
							(topLeftAccessibilityLabel ?? topLeftLabel.text) ?? "",
							(botLeftAccessibilityLabel ?? botLeftLabel.text) ?? "")

			if cellState == .DefaultMask {
				if let accessibilityLabel = topRightAccessibilityLabel {
					label = "\(label), \(accessibilityLabel)"
				}

				if let accessibilityLabel = botRightAccessibilityLabel {
					label = "\(label) \(accessibilityLabel)"
				}
			}

			return label
		}
		set {
		}
	}

	// Remember target state for transition
	override func willTransitionToState(state: UITableViewCellStateMask) {
		super.willTransitionToState(state)
		cellState = state
	}

	// Reset to default state before reuse of cell
	override func prepareForReuse() {
		super.prepareForReuse()
		cellState = .DefaultMask
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		// hide right labels in editing modes
		UIView.animateWithDuration(0.5) {
			let newAlpha: CGFloat = ((self.cellState & .ShowingEditControlMask) == .ShowingEditControlMask) ? 0.0 : 1.0
			self.topRightLabel.alpha = newAlpha
			self.botRightLabel.alpha = newAlpha
		}
	}

}

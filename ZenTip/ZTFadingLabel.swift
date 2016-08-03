//
//  ZTFadingLabel.swift
//  ZenTip
//
//  Created by parry on 7/31/16.
//  Copyright © 2016 MCP. All rights reserved.
//


import UIKit

/// Animation is performed randomly and prevented from overrunning using an end count value.
class ZTFadingLabel: NSObject {

    var firstLoad: Bool = false
    var numCharacters: Int = 0
    var topLabel: UILabel?
    var bottomLabel: UILabel?
    var attributedString: NSAttributedString = NSAttributedString()

    /// Contains what the final text should contain.
    var mutableAttribString: NSMutableAttributedString = NSMutableAttributedString()

    /// Keep track of animation passes.
    var numPass = 0

    /// Animation passes are not allowed to exceed a limit calculated from the string length.
    var passLimit = 0

    /// Higher pass divider results in less passes allowed.
    let passDivider = 2

    /// Add support for yellow color.
    let yellowStartIndex = 0
    let yellowEndIndex = 3

    let animationDuration = 0.35

    func sparklyAnimation(attributedString: NSMutableAttributedString, label1: UILabel, label2: UILabel) {

        //set properties
        label1.alpha = 0
        label2.alpha = 0

        label1.font = UIFont(name: "Wawati SC", size: CGFloat(40))
        label2.font = UIFont(name: "Wawati SC", size: CGFloat(40))

        // All characters start out with clear color.
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.clearColor(), range: NSRange(location:0, length:attributedString.length))
        label1.attributedText = attributedString
        label2.attributedText = attributedString

        topLabel = label2
        bottomLabel = label1

        numCharacters = 0
        numPass = 0
        passLimit = (attributedString.length)/passDivider

        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            label1.alpha = 1.0
            }, completion: { finished in
                self.attributedString = self.randomlyFadedAttributedStringFromAttributedString(attributedString)
                self.bottomLabel?.attributedText = self.attributedString
                self.performAnimation()
        })
    }

    func performAnimation() {
        self.numPass += 1
        if numPass < passLimit {
            UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.bottomLabel!.alpha = 1.0
                }, completion: { finished in
                    self.resetLabels()

                    if self.numCharacters >= self.attributedString.length  {
                        self.performFinalAnimation()
                    } else {
                        self.performAnimation()
                    }
            })
        } else {
            performFinalAnimation()
        }
    }

    func performFinalAnimation() {
        self.finalizeAttributedString()
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.bottomLabel!.alpha = 1.0
            }, completion: { finished in
                self.topLabel?.attributedText = self.attributedString
                self.topLabel?.hidden = false
                self.bottomLabel?.hidden = true
        })
    }

    /// Create the final form of the attributed string.
    func finalizeAttributedString() -> NSAttributedString {
        let mutableAttributedString = attributedString as! NSMutableAttributedString

        for i in 0 ..< attributedString.length {
            attributedString.enumerateAttribute(NSForegroundColorAttributeName,
                                                inRange: NSMakeRange(i, 1),
                                                options: NSAttributedStringEnumerationOptions.LongestEffectiveRangeNotRequired,
                                                usingBlock: { value, range, stop in
                                                    var initialColor: UIColor!
                                                    assert(value != nil)
                                                    initialColor = value as? UIColor

                                                    var newColor: UIColor!
                                                    if initialColor != UIColor.clearColor() {
                                                        newColor = initialColor.colorWithAlphaComponent(1)
                                                    } else {
                                                        // Force the color if the random changing away from clear color never happened.
                                                        // This ensures the final label is fully visible every time.
                                                        print("*** had to force color")
                                                        newColor = self.getColorForIndex(i)
                                                    }
                                                    mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value: newColor, range: range)
            })
        }

        print("num pass \(self.numPass), pass limit \(self.passLimit)")

        return mutableAttributedString
    }

    func resetLabels() {
        attributedString = randomlyFadedAttributedStringFromAttributedString(attributedString)
        topLabel?.attributedText = attributedString

        let oldBottom = bottomLabel
        let oldTopLabel = topLabel

        bottomLabel = oldTopLabel
        topLabel = oldBottom
    }

    func randomlyFadedAttributedStringFromAttributedString(attributedString: NSAttributedString) -> NSAttributedString {
        let mutableAttributedString = attributedString as! NSMutableAttributedString
        for i in 0 ..< attributedString.length {
            attributedString.enumerateAttribute(NSForegroundColorAttributeName,
                                                inRange: NSMakeRange(i, 1),
                                                options: NSAttributedStringEnumerationOptions.LongestEffectiveRangeNotRequired,
                                                usingBlock: { value, range, stop in
                                                    var initialColor: UIColor!
                                                    assert(value != nil)
                                                    initialColor = value as? UIColor

                                                    let newColor = self.newColorFromInitialColor(initialColor, charIndex: i)
                                                    if newColor != nil {
                                                        mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value: newColor!, range: range)
                                                        self.updateNumCharactersForColor(newColor!)
                                                    }
            })
        }

        return mutableAttributedString
    }

    /// Given an initial color, return a new color with a new alpha value.
    /// Return nil if the alpha is not 1 and the color is not clear.
    func newColorFromInitialColor(initialColor: UIColor, charIndex: Int) -> UIColor? {
        var newColor: UIColor?
        if initialColor == UIColor.clearColor() {
            // With a given probability, change the color to something other than clear.
            newColor = colorWithClearColorProbability(4, charIndex: charIndex)
        } else {
            let alpha = CGColorGetAlpha(initialColor.CGColor)
            if !(alpha >= 1 - 0.001) {
                newColor = self.colorWithMinAlpha(alpha, charIndex: charIndex)
            }
        }
        return newColor
    }

    func updateNumCharactersForColor(color: UIColor) {
        let alpha = CGColorGetAlpha(color.CGColor)
        if (alpha >= 0.999 && alpha <= 1.00) {
            self.numCharacters += 1
        }
    }

    /// For some random chance, return the clear color.
    /// Otherwise, return a color with a random alpha value with a minimum of 0.
    func colorWithClearColorProbability(probability: Int, charIndex: Int) -> UIColor {
        let color: UIColor?
        let colorIndex = Int(arc4random()) % probability
        if colorIndex != 0 {
            color = UIColor.clearColor()
        } else {
            color = colorWithMinAlpha(0, charIndex: charIndex)
        }
        return color!
    }

    /// Generate a new alpha value for a given color.
    /// The new alpha value is randomly chosen in the range [minAlpha, 1]
    func colorWithMinAlpha(minAlpha: CGFloat, charIndex: Int) -> UIColor {
        let number = 100 - minAlpha * 100 + 1
        let randomNumber = minAlpha * 100 + CGFloat(arc4random_uniform(UInt32(number)))
        var randomAlpha = min(100, Double(randomNumber) / 100.0)

        assert(!(randomAlpha < 0))
        assert(!(randomAlpha > 1))

        if randomAlpha > 0.9 {
            randomAlpha = 1
        }

        let newColor = getColorForIndex(charIndex)
        return newColor.colorWithAlphaComponent(CGFloat(randomAlpha))
    }

    /// Determine the color to be used given the character index.
    func getColorForIndex(charIndex: Int) -> UIColor {
        if charIndex >= self.yellowStartIndex && charIndex <= self.yellowEndIndex {
            return UIColor(red: 246/255, green: 195/255, blue: 0, alpha: 1)
        } else {
            return UIColor.whiteColor()
        }
    }
}

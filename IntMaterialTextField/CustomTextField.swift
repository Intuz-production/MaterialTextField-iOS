/*
 The MIT License (MIT)
 
 Copyright (c) 2018 INTUZ
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import UIKit

@IBDesignable

class CustomTextField: UITextField {
    
    var spacing : CGFloat = 8

    @IBInspectable var enableMaterialPlaceHolder: Bool  = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var showBottomLine: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var lineColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var showBottomSubLine: Bool = false  {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var subLineWidth: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var subLineColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var iconYMargin: CGFloat = 0.0
    @IBInspectable var leftIcon: UIImage?  {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var rightIcon: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        didSet {
            if (placeholder ?? "").count  > 0 {
                let strokeTextAttributes: [NSAttributedStringKey: Any] = [.foregroundColor : placeHolderColor ?? UIColor.lightGray]
                let str = NSAttributedString(string: placeholder!, attributes: strokeTextAttributes)
                tintColor = textColor
                attributedPlaceholder = str
                textFieldDidChange(self)
            }
        }
    }
    
    override var text: String? {
        didSet {
            textFieldDidChange(self)
        }
    }
    
    override var placeholder: String? {
        didSet {
            if (placeholder ?? "").count  > 0 {
                let str = NSAttributedString(string: placeholder!, attributes: [.foregroundColor: placeHolderColor ?? UIColor.lightGray])
                tintColor = textColor
                attributedPlaceholder = str
                textFieldDidChange(self)
            }
        }
    }
    
    var imgViewLeftIcon: UIImageView?
    var imgViewRightIcon: UIImageView?
    var viewBottomLine: UIView?
    var viewBottomSubLine: UIView?
    var placeHolderLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializedOnce()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializedOnce()
    }
    
    func initializedOnce() {
        clipsToBounds = false
        addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        placeHolderColor = UIColor.white
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        borderStyle = .none
        let defaultLineColor = UIColor.gray
        let defaultSubLineColor = UIColor.red
        let subLineHeight: CGFloat = 2
        let imageSize = CGSize(width: 25, height: 25)
        
        if leftIcon != nil {
            if imgViewLeftIcon == nil {
                let xPosission: CGFloat = 0
                imgViewLeftIcon = UIImageView(frame: CGRect(x: xPosission, y: 0, width: imageSize.width, height: imageSize.height))
                imgViewLeftIcon?.center = CGPoint(x: imgViewLeftIcon!.center.x, y: ((frame.size.height / 2) + iconYMargin))
                imgViewLeftIcon?.contentMode = .scaleAspectFit
                imgViewLeftIcon?.clipsToBounds = true
                
                // Add Tap Gesture in Left Icons.
                self.addTapGestures(imgViewLeftIcon!)
            }
            imgViewLeftIcon?.image = leftIcon
            addSubview(imgViewLeftIcon!)
        }
        else {
            imgViewLeftIcon?.removeFromSuperview()
        }
        
        if rightIcon != nil {
            if imgViewRightIcon == nil {
                let xPosission: CGFloat = frame.size.width - imageSize.width
                imgViewRightIcon = UIImageView(frame: CGRect(x: xPosission, y: 0, width: imageSize.width, height: imageSize.height))
                imgViewRightIcon?.center = CGPoint(x: imgViewRightIcon!.center.x, y: ((frame.size.height / 2) + iconYMargin))
                imgViewRightIcon?.contentMode = .scaleAspectFit
                imgViewRightIcon?.clipsToBounds = true
                
                // Add Tap Gesture in Right Icons.
                self.addTapGestures(imgViewRightIcon!)
            }
            imgViewRightIcon?.image = rightIcon
            addSubview(imgViewRightIcon!)
        }
        else {
            imgViewRightIcon?.removeFromSuperview()
        }
        if showBottomLine {
            if viewBottomLine == nil {
                viewBottomLine = UIView(frame: CGRect(x: 0, y: frame.size.height - 1, width: frame.size.width, height: 1))
            }
            viewBottomLine?.backgroundColor = lineColor ?? defaultLineColor
            addSubview(viewBottomLine!)
        }
        else {
            viewBottomLine?.removeFromSuperview()
        }
        
        if showBottomSubLine {
            if viewBottomSubLine == nil {
                viewBottomSubLine = UIView(frame: CGRect(x: 0, y: frame.size.height - subLineHeight, width: subLineWidth == 0 ? 30 : subLineWidth, height: subLineHeight))
            }
            viewBottomSubLine?.backgroundColor = subLineColor ?? defaultSubLineColor
            addSubview(viewBottomSubLine!)
        }
        else {
            viewBottomSubLine?.removeFromSuperview()
        }
        
        if enableMaterialPlaceHolder {
            if placeHolderLabel == nil {
                placeHolderLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
                placeHolderLabel?.attributedText = attributedPlaceholder
                placeHolderLabel?.alpha = 0
            }
            placeHolderLabel?.sizeToFit()
            textFieldDidChange(self)
            self.addSubview(placeHolderLabel!)
        }
        else {
            placeHolderLabel?.removeFromSuperview()
        }
    }
    
    
    func rect(forBounds bounds: CGRect) -> CGRect {
        var newBounds: CGRect = bounds
        if leftIcon != nil && rightIcon != nil {
            if imgViewLeftIcon != nil && imgViewRightIcon != nil {
                newBounds.size.width = self.frame.size.width - (imgViewLeftIcon!.frame.size.width + imgViewRightIcon!.frame.size.width + (spacing * 2))
                newBounds.origin.x = imgViewLeftIcon!.frame.size.width + spacing
                placeHolderLabel?.frame.origin.x = newBounds.origin.x
            }
        }
        else if leftIcon != nil && rightIcon == nil {
            if imgViewLeftIcon != nil {
                newBounds.size.width = self.frame.size.width - (imgViewLeftIcon!.frame.size.width + spacing)
                newBounds.origin.x = imgViewLeftIcon!.frame.size.width + spacing
                placeHolderLabel?.frame.origin.x = newBounds.origin.x
            }
        }
        else if leftIcon == nil && rightIcon != nil {
            if imgViewRightIcon != nil {
                newBounds.size.width = self.frame.size.width - (imgViewRightIcon!.frame.size.width + spacing)
                newBounds.origin.x = 0
                placeHolderLabel?.frame.origin.x = newBounds.origin.x
            }
        }
        
        viewBottomLine?.frame.origin.x = 0
        viewBottomLine?.frame.size.width = self.frame.size.width
        
        return newBounds
    }
    
    @IBAction func textFieldDidChange(_ sender: Any) {
        if enableMaterialPlaceHolder {
            placeHolderLabel?.alpha = 1
            if attributedPlaceholder != nil {
                placeHolderLabel?.attributedText = attributedPlaceholder
                attributedPlaceholder = nil
            }
            
            let duration: Double = 0.5
            let delay: Double = 0.0
            let damping: CGFloat = 0.6
            let velocity: CGFloat = 1
            
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: .curveEaseInOut, animations: {() -> Void in
                if self.text == nil || (self.text ?? "").count == 0 {
                    self.placeHolderLabel?.center = CGPoint(x: self.placeHolderLabel!.center.x, y: self.frame.size.height / 2)
                }
                else {
                    let yDisplacement: CGFloat = self.placeHolderLabel!.frame.size.height
                    self.placeHolderLabel?.frame.origin.y = -yDisplacement
                }
            }, completion: {(_ finished: Bool) -> Void in
            })
        }
        else {
            placeHolderLabel?.alpha = 0
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: rect(forBounds: bounds))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return super.placeholderRect(forBounds: rect(forBounds: bounds))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: rect(forBounds: bounds))
    }
    
    //MARK: - Add Gesture Recognizer.
    func addTapGestures(_ receiver: UIImageView) {
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(didTappedOnLeftIcon(_:)))
        gesture.numberOfTapsRequired = 1
        receiver.addGestureRecognizer(gesture)
    }
    
    @objc func didTappedOnLeftIcon(_ gesture: UIGestureRecognizer) -> Void {
        print("Image Tapped")
    }
}

/*
The MIT License (MIT)

Copyright (c) 2018 INTUZ

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController {

    @IBOutlet var showLeftIcon : UISwitch!
    @IBOutlet var showRightIcon : UISwitch!
    @IBOutlet var showBottomLine : UISwitch!
    @IBOutlet var showSubBottomLine : UISwitch!
    @IBOutlet var enableMaterialTextField : UISwitch!
    
    @IBOutlet var txtField : CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func switchValueChangeAction(_ sender: UISwitch) -> Void {
        if sender == enableMaterialTextField {
            txtField.enableMaterialPlaceHolder = sender.isOn
            txtField.placeholder = "Enter your name..."
        }
        else if sender == showLeftIcon {
            txtField.leftIcon = showLeftIcon.isOn ? #imageLiteral(resourceName: "ic_alarm_on") : nil
        }
        else if sender == showRightIcon {
            txtField.rightIcon = showRightIcon.isOn ? #imageLiteral(resourceName: "ic_add_shopping_cart") : nil
        }
        else if sender == showBottomLine {
            txtField.lineColor = UIColor.red
            txtField.showBottomLine = showBottomLine.isOn
        }
        else if sender == showSubBottomLine {
            txtField.subLineColor = UIColor.green
            txtField.subLineWidth = 30
            txtField.showBottomSubLine = showSubBottomLine.isOn
        }
    }

}


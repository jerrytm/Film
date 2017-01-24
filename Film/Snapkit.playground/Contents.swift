//: Playground - noun: a place where people can play

import UIKit
import SnapKit
import PlaygroundSupport
import Pods_Film
import ReadMoreTextView

var tintColor = UIColor.init(red: 252/255, green: 143/255, blue: 84/255, alpha: 1)

let rootView = UIView(frame: CGRect(x: 0, y: 0, width: 187, height: 333))
rootView.backgroundColor = UIColor.init(white: 18/255, alpha: 1)

PlaygroundPage.current.liveView = rootView

let textView = ReadMoreTextView()

textView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."

textView.shouldTrim = true
textView.maximumNumberOfLines = 4
var attributes: NSDictionary = [NSForegroundColorAttributeName: tintColor]
textView.attributedReadMoreText = NSAttributedString(string: " ... more", attributes: attributes as! [String : Any])

rootView.addSubview(textView)
textView.snp.makeConstraints { (make) in
    make.edges.equalTo(rootView)
}
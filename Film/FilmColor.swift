//
//  FilmColor.swift
//  Film
//
//  Created by Tomas Vosicky on 24.11.16.
//  Copyright © 2016 Tomas Vosicky. All rights reserved.
//

import UIKit

extension UIColor {
    static var filmTint: UIColor {
        return .init(red: 252/255, green: 143/255, blue: 84/255, alpha: 1)
    }
    
    static var background: UIColor {
        return .init(white: 18/255, alpha: 1)
    }
    
    static var separator: UIColor {
        return .init(white: 80/255, alpha: 1)
    }
    
    static var buttonBlue: UIColor {
        return .init(red: 0, green: 118/255, blue: 1, alpha: 1)
    }

    static var buttonGreen: UIColor {
        return .init(red: 68/255, green: 219/255, blue: 94/255, alpha: 1)
    }

    static var buttonRed: UIColor {
        return .init(red: 1, green: 90/255, blue: 80/255, alpha: 1)
    }

}

extension UILabel{
    func setLetterSpacing(_ spacing: CGFloat){
        if let text = self.text {
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: text.characters.count))
            attributedText = attributedString
        }
    }

    func setLineHeight(_ height: CGFloat){
        if let text = self.text {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = height

            let attributes = [NSParagraphStyleAttributeName : style]
            attributedText = NSAttributedString(string: text, attributes: attributes)
        }
    }
}

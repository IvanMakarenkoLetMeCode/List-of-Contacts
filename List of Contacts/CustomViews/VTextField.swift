//
//  VTextField.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 06.10.2021.
//

import UIKit

protocol BottomLineRepsentable: UITextField {
    
    func addBottomLine(with color: UIColor, bottomOffset: CGFloat)
}

extension BottomLineRepsentable {
    
    func addBottomLine() {
        
        addBottomLine(with: AppDesign.Color.separator.ui, bottomOffset: 5)
    }
    
}

class VTextField: UITextField {
    
    // MARK: Private properties
    
    private var bottomLayer: CALayer?
    private var bottonOffset: CGFloat = 0
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomLayer?.frame.size.width = frame.width
        bottomLayer?.frame.origin = CGPoint(x: 0, y: frame.size.height + bottonOffset)
    }
    
}

// MARK: - BottomLineRepsentable
extension VTextField: BottomLineRepsentable {
    
    func addBottomLine(with color: UIColor = AppDesign.Color.separator.ui, bottomOffset: CGFloat = 5) {
        
        bottomLayer?.removeFromSuperlayer()
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.size.height + bottomOffset, width: frame.size.width, height: 1)
        bottomLine.backgroundColor = color.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
        bottomLayer = bottomLine
        self.bottonOffset = bottomOffset
    }
    
}

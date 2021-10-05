//
//  AppDesignFontName.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 05.10.2021.
//

import UIKit

extension AppDesign {
    
    enum FontName: String {
        
        case roboto = "Roboto"
        
        func boldWith(size: CGFloat) -> UIFont {
            
            let font = UIFont(name: "\(self.rawValue)-Bold", size: size)
            return font ?? UIFont.systemFont(ofSize: size)
        }
        
        func regularWith(size: CGFloat) -> UIFont {
            
            let font = UIFont(name: "\(self.rawValue)-Regular", size: size)
            return font ?? UIFont.systemFont(ofSize: size)
        }
        
        func mediumWith(size: CGFloat) -> UIFont {
            
            let font = UIFont(name: "\(self.rawValue)-Medium", size: size)
            return font ?? UIFont.systemFont(ofSize: size)
        }
        
    }
    
}

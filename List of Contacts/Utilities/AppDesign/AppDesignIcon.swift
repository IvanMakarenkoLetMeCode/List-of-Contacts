//
//  AppDesignIcon.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 05.10.2021.
//

import UIKit

extension AppDesign {
    
    enum Icon: String {
        
        case add = "ic_add"
        case close = "ic_close"
        
        var value: UIImage {
            
            return UIImage(named: self.rawValue) ?? UIImage()
        }
        
    }
    
}

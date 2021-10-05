//
//  ContactsListCellData.swift
//  List of Contacts
//
//  Created by Ivan Makareko on 05.10.2021.
//

import UIKit

protocol ContactsListCellData {
    
    var id: String { get }
    var firstName: String { get }
    var lastName: String { get }
    var birthDay: String { get }
    var company: String? { get }
    var email: String { get }
}

struct ContactsListCellDataProducer: ContactsListCellData {
    
    var id: String
    var firstName: String
    var lastName: String
    var birthDay: String
    var company: String?
    var email: String
}

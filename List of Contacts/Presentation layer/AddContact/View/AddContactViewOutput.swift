//
//  AddContactViewOutput.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 06.10.2021.
//

import UIKit

protocol AddContactViewOutput: BaseViewOutput {
    
    init(view: AddContactViewInput,
         router: RouterProtocol,
         delegate: AddContactPresenterDelegate)
    func doneButtonDidTap(_ date: Date)
    func firstNameTextFieldDidChange(_ text: String?)
    func lastNameTextFieldDidChange(_ text: String?)
    func companyTextFieldDidChange(_ text: String?)
    func emailTextFieldDidChange(_ text: String?)
    func addContactButtonDidTap()
}

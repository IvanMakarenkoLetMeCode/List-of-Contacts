//
//  AddContactViewInput.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 06.10.2021.
//

protocol AddContactViewInput: BaseViewInput {
    
    func setNewDateOfBirth(_ dateString: String)
    func showAlert(title: String?, message: String?)
}

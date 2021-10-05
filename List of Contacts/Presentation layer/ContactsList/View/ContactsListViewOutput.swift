//
//  ContactsListViewOutput.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 05.10.2021.
//

protocol ContactsListViewOutput: BaseViewOutput {
    
    init(view: ContactsListViewInput, router: RouterProtocol)
    func addContactButtonDidTap()
    func deleteButtonDidTap(index: Int)
    func searchTextDidChange(_ searchText: String?)
}

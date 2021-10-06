//
//  ContactsListViewOutput.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 05.10.2021.
//

protocol ContactsListViewOutput: BaseViewOutput {
    
    init(view: ContactsListViewInput, router: RouterProtocol)
    func addContactButtonDidTap(_ controller: ContactsListViewController)
    func deleteButtonDidTap(model: ContactsListCellData)
    func searchTextDidChange(_ searchText: String?)
    func addContactToList(cell: ContactsListCellData)
}

//
//  ContactsListPresenter.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 05.10.2021.
//

import UIKit

class ContactsListPresenter {
    
    // MARK: - Public properties
    
    weak var view: ContactsListViewInput?
    var router: RouterProtocol?
    
    // MARK: - Private properties
    
    private var cells = [ContactsListCellData]()
    
    // MARK: - Lifecycle
    
    required init(view: ContactsListViewInput, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
}

// MARK: - ContactsListViewOutput
extension ContactsListPresenter: ContactsListViewOutput {
    
    func viewDidLoad() {
        
        setupInitialState()
    }
    
    func addContactButtonDidTap(_ controller: ContactsListViewController) {
        
        router?.showAddContact(delegate: controller)
    }
    
    func deleteButtonDidTap(model: ContactsListCellData) {
        
        cells = cells.filter { $0.id != model.id }
        view?.set(cells: cells)
    }
    
    func searchTextDidChange(_ searchText: String?) {
        
        guard let searchText = searchText, !searchText.isEmpty else {
            
            view?.set(cells: cells)
            return
        }
        
        searchContacts(searchText: searchText)
    }
    
    func addContactToList(cell: ContactsListCellData) {
        
        cells.append(cell)
        view?.set(cells: cells)
    }
    
}

// MARK: - Private methods
private extension ContactsListPresenter {
    
    func setupInitialState() {
        
        buildCells()
    }
    
    func buildCells() {
        
        let cells = [
            
            ContactsListCellDataProducer(id: UUID().uuidString,
                                         firstName: "Bob",
                                         lastName: "Gug",
                                         birthday: "14.06.1986",
                                         company: "Red",
                                         email: "arge@jol.com"),
            ContactsListCellDataProducer(id: UUID().uuidString,
                                         firstName: "Alice",
                                         lastName: "Fleed",
                                         birthday: "18.01.1996",
                                         email: "sdgag@mail.ru"),
            ContactsListCellDataProducer(id: UUID().uuidString,
                                         firstName: "Greg",
                                         lastName: "Pop",
                                         birthday: "25.12.1978",
                                         company: "Figma",
                                         email: "thgh@gmail.com")
        ]
        self.cells = cells
        view?.set(cells: cells)
    }
    
    func searchContacts(searchText: String) {
        
        var filtered = cells
        
        filtered = filtered.filter { model in
            
            model.firstName.range(of: searchText, options: .caseInsensitive) != nil
                || model.lastName.range(of: searchText, options: .caseInsensitive) != nil
        }
        view?.set(cells: filtered)
    }
    
}

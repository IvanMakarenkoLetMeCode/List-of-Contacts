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
    
    func addContactButtonDidTap() {
        
        cells.append(ContactsListCellDataProducer(id: UUID().uuidString,
                                                  firstName: "Bob",
                                                  lastName: "Gug",
                                                  birthDay: "14.06.1986",
                                                  company: "eafa",
                                                  email: "argeggdg"))
        view?.set(cells: cells)
    }
    
    func deleteButtonDidTap(index: Int) {
        
        cells.remove(at: index)
        view?.set(cells: cells)
    }
    
    func searchTextDidChange(_ searchText: String?) {
        
        guard let searchText = searchText, !searchText.isEmpty else {
            
            view?.set(cells: cells)
            return
        }
        
        searchContacts(searchText: searchText)
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
                                         birthDay: "14.06.1986",
                                         company: "eafa",
                                         email: "argeggdg"),
            ContactsListCellDataProducer(id: UUID().uuidString,
                                         firstName: "afgafgg",
                                         lastName: "asgasg",
                                         birthDay: "asgsg",
                                         company: "asgsg",
                                         email: "sdgag"),
            ContactsListCellDataProducer(id: UUID().uuidString,
                                         firstName: "asgasdg",
                                         lastName: "sdgasdg",
                                         birthDay: "sdgsdg",
                                         company: "ASDGASDG",
                                         email: "ASDGGDGf")
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

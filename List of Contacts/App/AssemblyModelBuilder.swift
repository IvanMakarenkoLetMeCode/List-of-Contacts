//
//  AssemblyModelBuilder.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 05.10.2021.
//

import UIKit
protocol AssemblyBuilderProtocol {
    
    func createContactsListModule(router: RouterProtocol) -> UIViewController
    func createAddContactModule(router: RouterProtocol,
                                delegate: AddContactPresenterDelegate) -> UIViewController
}

class AssemblyModelBuilder: AssemblyBuilderProtocol {
    
    func createContactsListModule(router: RouterProtocol) -> UIViewController {
        
        let view = ContactsListViewController()
        view.title = "Contacts List"
        let presenter = ContactsListPresenter(view: view, router: router)
        view.output = presenter
        return view
    }
    
    func createAddContactModule(router: RouterProtocol, delegate: AddContactPresenterDelegate) -> UIViewController {
        
        let view = AddContactViewController()
        view.title = "Add Contact"
        let presenter = AddContactPresenter(view: view, router: router, delegate: delegate)
        view.output = presenter
        return view
    }
    
}

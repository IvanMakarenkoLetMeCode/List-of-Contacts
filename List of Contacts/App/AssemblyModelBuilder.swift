//
//  AssemblyModelBuilder.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 05.10.2021.
//

import UIKit
protocol AssemblyBuilderProtocol {
    
    func createContactsListModule(router: RouterProtocol) -> UIViewController
}

class AssemblyModelBuilder: AssemblyBuilderProtocol {
    
    func createContactsListModule(router: RouterProtocol) -> UIViewController {
        
        let view = ContactsListViewController()
        view.title = "Contacts List"
        let presenter = ContactsListPresenter(view: view, router: router)
        view.output = presenter
        return view
    }
    
}

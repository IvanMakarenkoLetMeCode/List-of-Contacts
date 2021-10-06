//
//  Router.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 05.10.2021.
//

import UIKit

protocol RouterMain {
    
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    
    func initialViewController()
    func showAddContact(delegate: AddContactPresenterDelegate)
    func popViewController()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        
        if let navigationController = navigationController {
            guard let contactsListViewController = assemblyBuilder?.createContactsListModule(router: self) else { return }
            navigationController.viewControllers = [contactsListViewController]
        }
    }
    
    func showAddContact(delegate: AddContactPresenterDelegate) {
        
        if let navigationController = navigationController {
            guard let addContactViewController = assemblyBuilder?
                    .createAddContactModule(router: self, delegate: delegate) else { return }
            navigationController.pushViewController(addContactViewController, animated: true)
        }
    }
    
    func popViewController() {
        
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
}

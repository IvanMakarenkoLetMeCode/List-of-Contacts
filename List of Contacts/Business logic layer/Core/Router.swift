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
    
}

//
//  AddContactPresenter.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 06.10.2021.
//

import UIKit

protocol AddContactPresenterDelegate: AnyObject {
    
    func addContactToList(cell: ContactsListCellData)
}

class AddContactPresenter {
    
    // MARK: - Public properties
    
    weak var view: AddContactViewInput?
    var router: RouterProtocol?
    
    // MARK: - Private properties
    
    private var firstName: String?
    private var lastName: String?
    private var birthday: String?
    private var company: String?
    private var email: String?
    private weak var delegate: AddContactPresenterDelegate?
    
    // MARK: - Lifecycle
    
    required init(view: AddContactViewInput,
                  router: RouterProtocol,
                  delegate: AddContactPresenterDelegate) {
        self.view = view
        self.router = router
        self.delegate = delegate
    }
    
}

// MARK: - AddContactViewOutput
extension AddContactPresenter: AddContactViewOutput {
    
    func viewDidLoad() {
        
        setupInitialState()
    }
    
    func doneButtonDidTap(_ date: Date) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "d MMMM yyyy"
        birthday = dateFormatter.string(from: date)
        view?.setNewDateOfBirth(dateFormatter.string(from: date))
    }
    
    func firstNameTextFieldDidChange(_ text: String?) {
        
        firstName = text
    }
    
    func lastNameTextFieldDidChange(_ text: String?) {
        
        lastName = text
    }
    
    func companyTextFieldDidChange(_ text: String?) {
        
        company = text
    }
    
    func emailTextFieldDidChange(_ text: String?) {
        
        email = text
    }
    
    func addContactButtonDidTap() {
        
        guard validateFields() else { return }
        delegate?.addContactToList(cell: ContactsListCellDataProducer(id: UUID().uuidString,
                                                                  firstName: firstName ?? "",
                                                                  lastName: lastName ?? "",
                                                                  birthday: birthday ?? "",
                                                                  company: company,
                                                                  email: email ?? ""))
        router?.popViewController()
    }
    
}

// MARK: - Private methods
private extension AddContactPresenter {
    
    func setupInitialState() {
        
    }
    
    func validateFields() -> Bool {
        
        guard let firstName = firstName, !firstName.isEmpty else {
            
            view?.showAlert(title: nil, message: "Enter first name")
            return false
        }
        guard let lastName = lastName, !lastName.isEmpty else {
            
            view?.showAlert(title: nil, message: "Enter last name")
            return false
        }
        guard let birthday = birthday, !birthday.isEmpty else {
            
            view?.showAlert(title: nil, message: "Enter birthday")
            return false
        }
        guard let email = email, !email.isEmpty else {
            
            view?.showAlert(title: nil, message: "Enter email")
            return false
        }
        guard isValidEmail(email: email) else {
            
            view?.showAlert(title: nil, message: "Invalid mail")
            return false
        }
        return true
    }
    
    func isValidEmail(email: String) -> Bool {
        
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: email)
    }
    
}

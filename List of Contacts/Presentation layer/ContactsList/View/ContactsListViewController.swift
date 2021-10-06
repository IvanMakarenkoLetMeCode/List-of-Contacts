//
//  ContactsListViewController.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 05.10.2021.
//

import UIKit
import TinyConstraints

class ContactsListViewController: UIViewController {
    
    // MARK: - Public properties
    
    var output: ContactsListViewOutput!
    
    // MARK: Bar data source
    
    // MARK: - Private properties
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let contactsListCellIdentifier = String(describing: ContactsListViewCell.self)
    private var cells = [ContactsListCellData]()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        output.viewDidLoad()
    }
    
}

// MARK: - CategoriesViewInput
extension ContactsListViewController: ContactsListViewInput {
    
    func set(cells: [ContactsListCellData]) {
        
        self.cells = cells
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource
extension ContactsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: contactsListCellIdentifier, for: indexPath) as? ContactsListViewCell else { fatalError() }
        let contact = cells[indexPath.row]
        cell.configureCell(model: contact, delegate: self)
        return cell
    }
    
}

// MARK: - UISearchBarDelegate
extension ContactsListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        output.searchTextDidChange(searchText)
    }
    
}

// MARK: - ContactsListViewCellDelegate
extension ContactsListViewController: ContactsListViewCellDelegate {
    
    func deleteButtonDidTap(_ model: ContactsListCellData) {
        
        output.deleteButtonDidTap(model: model)
    }
    
}

// MARK: - AddContactPresenterDelegate
extension ContactsListViewController: AddContactPresenterDelegate {
    
    func addContactToList(cell: ContactsListCellData) {
        
        output.addContactToList(cell: cell)
    }
    
}

// MARK: Private methods
private extension ContactsListViewController {
    
    func setupUI() {
        
        let contentStackView = UIStackView()
        view.backgroundColor = AppDesign.Color.white.ui
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 0
        
        searchBar.placeholder = "Search contacts"
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.register(ContactsListViewCell.self, forCellReuseIdentifier: contactsListCellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.separatorStyle = .none
        
        let addContactButton = VButton()
        addContactButton.backgroundColor = AppDesign.Color.clear.ui
        addContactButton.tintColor = AppDesign.Color.blue.ui
        addContactButton.setImage(AppDesign.Icon.add.value)
        addContactButton.clipsToBounds = true
        addContactButton.addTarget(
            self, action: #selector(addContactButtonDidTap), for: .touchUpInside)
        addContactButton.size(CGSize(width: 20, height: 20))
        
        let rightBarButton = UIBarButtonItem(customView: addContactButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationController?.navigationBar.backgroundColor = AppDesign.Color.navigationBar.ui
        
        view.addSubview(contentStackView)
        contentStackView.addArrangedSubview(searchBar)
        contentStackView.addArrangedSubview(tableView)
        
        contentStackView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        contentStackView.bottomToSuperview(relation: .equalOrGreater, usingSafeArea: true)
    }
    
    // MARK: - Actions
    
    @objc func addContactButtonDidTap(_ sender: VButton) {
        
        output.addContactButtonDidTap(self)
    }
    
}

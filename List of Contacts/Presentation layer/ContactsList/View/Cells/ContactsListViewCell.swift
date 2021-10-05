//
//  ContactsListViewCell.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 05.10.2021.
//

import UIKit
import TinyConstraints

protocol ContactsListViewCellDelegate: AnyObject {
    
    func deleteButtonDidTap(_ cell: UITableViewCell)
}

class ContactsListViewCell: UITableViewCell {
    
    // MARK: - Private properties
    
    private let titleLabel = UILabel()
    private let birthDayLabel = UILabel()
    private let companyLabel = UILabel()
    private let emailLabel = UILabel()
    private let deleteButton = VButton()
    private var model: ContactsListCellData?
    private weak var delegate: ContactsListViewCellDelegate?
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(model: ContactsListCellData, delegate: ContactsListViewCellDelegate) {
        
        self.model = model
        self.delegate = delegate
        titleLabel.text = model.firstName + " " + model.lastName
        birthDayLabel.text = model.birthDay
        companyLabel.text = model.company
        emailLabel.text = model.email
    }
    
}

// MARK: - Private methods
private extension ContactsListViewCell {
    
    func setupUI() {
        
        let mainView = UIView()
        let contentStackView = UIStackView()
        let separatorView = UIView()
        contentStackView.axis = .vertical
        contentStackView.spacing = 10
        
        titleLabel.numberOfLines = 2
        titleLabel.font = AppDesign.FontName.roboto.regularWith(size: 16)
        titleLabel.textColor = AppDesign.Color.title.ui
        
        birthDayLabel.font = AppDesign.FontName.roboto.regularWith(size: 12)
        birthDayLabel.textColor = AppDesign.Color.grey.ui
        
        for label in [companyLabel, emailLabel] as [UILabel] {
            
            label.font = AppDesign.FontName.roboto.regularWith(size: 12)
            label.textColor = AppDesign.Color.title.ui
        }
        
        deleteButton.tintColor = AppDesign.Color.red.ui
        deleteButton.setImage(AppDesign.Icon.close.value)
        deleteButton.clipsToBounds = true
        deleteButton.addTarget(self, action: #selector(deleteButtonDidTap), for: .touchUpInside)
        deleteButton.size(CGSize(width: 20, height: 20))
        
        separatorView.backgroundColor = AppDesign.Color.separator.ui
        separatorView.height(1)
        
        contentView.addSubview(mainView)
        mainView.addSubview(contentStackView)
        mainView.addSubview(deleteButton)
        mainView.addSubview(separatorView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(birthDayLabel)
        contentStackView.addArrangedSubview(companyLabel)
        contentStackView.addArrangedSubview(emailLabel)
        
        mainView.edgesToSuperview(insets: .left(20))
        contentStackView.edgesToSuperview(excluding: [.right, .bottom], insets: .top(10))
        deleteButton.edgesToSuperview(excluding: [.left, .bottom])
        deleteButton.leadingToTrailing(of: contentStackView, offset: 8, relation: .equalOrLess)
        separatorView.edgesToSuperview(excluding: .top)
        separatorView.topToBottom(of: contentStackView, offset: 10)
    }
    
    // MARK: - Actions
    
    @objc func deleteButtonDidTap(_ sender: VButton) {
        
        delegate?.deleteButtonDidTap(self)
    }
    
}

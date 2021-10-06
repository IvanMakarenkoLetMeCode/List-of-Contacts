//
//  AddContactViewController.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 06.10.2021.
//

import UIKit
import TinyConstraints

class AddContactViewController: UIViewController {
    
    // MARK: - Public properties
    
    var output: AddContactViewOutput!
    
    // MARK: Bar data source
    
    // MARK: - Private properties
    
    private let firstNameLabel = UILabel()
    private let firstNameTextField = VTextField()
    private let lastNameLabel = UILabel()
    private let lastNameTextField = VTextField()
    private let birthdayLabel = UILabel()
    private let birthdayTextField = VTextField()
    private let companyLabel = UILabel()
    private let companyTextField = VTextField()
    private let emailLabel = UILabel()
    private let emailTextField = VTextField()
    private let addContactButton = VButton()
    private var datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        output.viewDidLoad()
    }
    
}

// MARK: - AddContactViewInput
extension AddContactViewController: AddContactViewInput {
    
    func setNewDateOfBirth(_ dateString: String) {
        
        birthdayTextField.text = dateString
        view.endEditing(true)
    }
    
    func showAlert(title: String?, message: String?) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        alertController.modalPresentationStyle = .fullScreen
        present(alertController, animated: true, completion: nil)
    }
    
}

// MARK: - UITextFieldDelegate
extension AddContactViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        switch textField {
        case birthdayTextField:
            return false
        default:
            if string.rangeOfCharacter(from: CharacterSet.letters.inverted) != nil {
                
                return false
            }
            
            return true
        }
    }
    
}

// MARK: Private methods
private extension AddContactViewController {
    
    func setupUI() {
        
        view.backgroundColor = AppDesign.Color.white.ui
        let scrollView = UIScrollView()
        let contentStackView = UIStackView()
        
        scrollView.contentInsetAdjustmentBehavior = .automatic
        scrollView.alwaysBounceVertical = true
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 8
        
        firstNameLabel.text = "First Name"
        lastNameLabel.text = "Last Name"
        birthdayLabel.text = "Birthday"
        companyLabel.text = "Company"
        emailLabel.text = "Email"
        
        for label in [firstNameLabel,
                      lastNameLabel,
                      birthdayLabel,
                      companyLabel,
                      emailLabel] as [UILabel] {
            
            label.font = AppDesign.FontName.roboto.regularWith(size: 16)
            label.textColor = AppDesign.Color.title.ui
        }
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        birthdayTextField.delegate = self
        setupTextField(firstNameTextField, placeholder: "Type first name")
        setupTextField(lastNameTextField, placeholder: "Type last name")
        setupTextField(birthdayTextField, placeholder: "Type birthday")
        setupTextField(companyTextField, placeholder: "Type company")
        setupTextField(emailTextField, placeholder: "Type email")
        
        addContactButton.setTitle("Add Contact")
        addContactButton.layer.cornerRadius = 10
        addContactButton.titleLabel?.font = AppDesign.FontName.roboto.mediumWith(size: 14)
        addContactButton.setTitleColor(AppDesign.Color.white.ui, for: .normal)
        addContactButton.backgroundColor = AppDesign.Color.blue.ui
        addContactButton.contentEdgeInsets = AppDesign.constants.contentInset
        addContactButton.addTarget(self, action: #selector(addContactButtonDidTap), for: .touchUpInside)
        
        setupDatePicker()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(firstNameLabel)
        contentStackView.addArrangedSubview(firstNameTextField)
        contentStackView.addArrangedSubview(lastNameLabel)
        contentStackView.addArrangedSubview(lastNameTextField)
        contentStackView.addArrangedSubview(birthdayLabel)
        contentStackView.addArrangedSubview(birthdayTextField)
        contentStackView.addArrangedSubview(companyLabel)
        contentStackView.addArrangedSubview(companyTextField)
        contentStackView.addArrangedSubview(emailLabel)
        contentStackView.addArrangedSubview(emailTextField)
        contentStackView.addArrangedSubview(addContactButton)
        
        contentStackView.setCustomSpacing(20, after: firstNameTextField)
        contentStackView.setCustomSpacing(20, after: lastNameTextField)
        contentStackView.setCustomSpacing(20, after: birthdayTextField)
        contentStackView.setCustomSpacing(20, after: companyTextField)
        contentStackView.setCustomSpacing(20, after: emailTextField)
        
        scrollView.edgesToSuperview(usingSafeArea: true)
        contentStackView.edgesToSuperview(excluding: .bottom,
                                          insets: .top(10) + .left(20) + .right(20))
        contentStackView.bottomToSuperview(offset: 10, relation: .equalOrGreater)
        contentStackView.width(to: view, offset: -40)
    }
    
    func setupDatePicker() {
        
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonDidTap))
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)
        birthdayTextField.inputAccessoryView = toolbar
        birthdayTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
    }
    
    func setupTextField(_ textField: VTextField, placeholder: String) {
        
        textField.attributedPlaceholder =
            NSAttributedString(string: placeholder,
                               attributes: [.foregroundColor: AppDesign.Color.grey.ui])
        textField.font = AppDesign.FontName.roboto.regularWith(size: 16)
        textField.textColor = AppDesign.Color.title.ui
        textField.addBottomLine()
        if textField != birthdayTextField {
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    // MARK: - Actions
    
    @objc func textFieldDidChange(_ textField: VTextField) {
        
        switch textField {
        case firstNameTextField:
            output.firstNameTextFieldDidChange(textField.text)
        case lastNameTextField:
            output.lastNameTextFieldDidChange(textField.text)
        case companyTextField:
            output.companyTextFieldDidChange(textField.text)
        case emailTextField:
            output.emailTextFieldDidChange(textField.text)
        default:
            break
        }
    }
    
    @objc func addContactButtonDidTap(_ sender: VButton) {
        
        output.addContactButtonDidTap()
    }
    
    @objc func doneButtonDidTap() {
        
        output.doneButtonDidTap(datePicker.date)
    }
    
}

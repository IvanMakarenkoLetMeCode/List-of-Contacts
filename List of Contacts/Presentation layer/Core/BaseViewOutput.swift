//
//  BaseViewOutput.swift
//  List of Contacts
//
//  Created by Ivan Makarenko on 05.10.2021.
//

protocol BaseViewOutput: class {

    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

extension BaseViewOutput {
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewWillDisappear() {}
}

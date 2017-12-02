//
//  EmployeeListProtocol.swift
//  MVVMP
//
//  Created by Preet G S Anand on 11/6/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation


protocol EmployeeListDelegate {
    // PRESENTER -> CONTROLLER
    func showEmployeeList(viewModel : EmployeeListViewModel)
    func showLoading()
    func hideLoading()
}


protocol EmployeeWireframeDelegate {
    // PRESENTER -> WIREFRAME
    func presentEmployeeDetailView(fromView : EmployeeListDelegate, forEmployee : Employee)
}

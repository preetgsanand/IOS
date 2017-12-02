import Foundation
import UIKit

class EmployeeListPresenter {
    
    var view : EmployeeListDelegate!
    var wireframe : EmployeeWireframe!
    var viewModel : EmployeeListViewModel!
    
    func retrieveEmployeeList() {
        ApiService.instance.getEmployeeList { (success, employeeList) in
            self.viewModel = EmployeeListViewModel(employeeList : employeeList)
            self.view?.showEmployeeList(viewModel: self.viewModel)
        }
    }
    
    func rowSelected(foremployee : Employee) {
        wireframe.presentEmployeeDetailView(fromView: view, forEmployee: foremployee)
    }
}

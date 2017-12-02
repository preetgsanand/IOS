import UIKit

class EmployeeWireframe : EmployeeWireframeDelegate{
    
    static let instance : EmployeeWireframe = EmployeeWireframe()
    
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func employeeNavigationController() -> UIViewController {
        return EmployeeWireframe.mainStoryboard.instantiateViewController(withIdentifier: "EmployeeNavigationController")
    }
    func createEmployeeList() -> UIViewController {
        let navigationController = employeeNavigationController()
        
        if let employeeListController = navigationController.childViewControllers.first as? EmployeeListController {
            let presenter : EmployeeListPresenter = EmployeeListPresenter()
            let wireframe : EmployeeWireframe = EmployeeWireframe()
            
            presenter.wireframe = wireframe
            employeeListController.presenter = presenter
            
            return navigationController
        }
        return UIViewController()
    }
    
    func createEmployeeDetail(employee : Employee) -> UIViewController {
        let viewController = EmployeeWireframe.mainStoryboard.instantiateViewController(withIdentifier: "EmployeeDetailController")
        
        if let employeeDetailController = viewController as? EmployeeDetailController {
            let employeeViewModel  = EmployeeViewModel(employee : employee)
            let employeeDetailPresenter = EmployeeDetailPresenter(employeeViewModel : employeeViewModel)
            employeeDetailController.employeeDetailPresenter = employeeDetailPresenter
            return employeeDetailController
        }
        return EmployeeDetailController()
    }
    
    
    func presentEmployeeDetailView(fromView: EmployeeListDelegate, forEmployee: Employee) {
        let employeeDetailController = createEmployeeDetail(employee : forEmployee)
        
        if let source = fromView as? UIViewController {
            if let navigationController = source.navigationController {
                navigationController.pushViewController(employeeDetailController, animated: true)
                
                
            }
            else {
                print("Navigation Controller Null")
            }
        }
    }
    
}

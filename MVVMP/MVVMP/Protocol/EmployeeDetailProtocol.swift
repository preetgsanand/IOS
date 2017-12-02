import Foundation

protocol  EmployeeDetailDelegate{
    // PRESENTER -> CONTROLLER
    func renderView(_ employee : Employee)
}


protocol EmployeeDetailWireframeDelegate {
    // PRESENTER -> WIREFRAME

}

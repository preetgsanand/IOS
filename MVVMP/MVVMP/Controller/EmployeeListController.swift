import UIKit

class EmployeeListController: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    var presenter : EmployeeListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        presenter.view = self
        presenter.retrieveEmployeeList()
    }

}

extension EmployeeListController : EmployeeListDelegate {
    
    func showEmployeeList(viewModel : EmployeeListViewModel) {
        tableView.reloadData()
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}

extension EmployeeListController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = presenter.viewModel {
            return viewModel.employeeList.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let viewModel = presenter.viewModel {
            if let employeeCell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as? EmployeeCell{
                employeeCell.updateView(employee: viewModel.employeeList[indexPath.row])
                return employeeCell
            }
            else {
                return EmployeeCell()
            }
        }
        else {
            return EmployeeCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel = presenter.viewModel {
            presenter.rowSelected(foremployee: viewModel.employeeList[indexPath.row])
        }
    }
    
    
}

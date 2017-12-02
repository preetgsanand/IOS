import UIKit
import RealmSwift


class EmployeeController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    

    @IBOutlet weak var employeeCollection : UICollectionView!
    
    var employeeList : Results<Employee>!
    var realm : Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        employeeCollection.delegate = self
        employeeCollection.dataSource = self
        initializeSocket()
        setEmployeeList()
    }
    
    override
    func viewWillAppear(_ animated: Bool) {
        self.initializeHandler()
        self.setEmployeeList()
    }
    
    
    
    
    func initializeHandler() {
        SocketService.instance.setSocketCompletion { (CODE) in
            switch CODE {
            case ON_USER_CONNECTED:
                print("Sokcket connected")
            case ON_REFRESH_USER_LIST:
                print("Employee List Updated")
                self.setEmployeeList()
            case ON_USER_ONLINE:
                print("Employee List Updated")
                self.setEmployeeList()
            case ON_USER_OFFLINE:
                print("Employee List Updated")
                self.setEmployeeList()
            default:
                print("Default")
            }
        }
    }
    
    func initializeSocket() {
        self.initializeHandler()
        SocketService.instance.emitUserOnline()
    }
    
    func setEmployeeList() {
        let results = realm.objects(Employee.self)
        if let me = results.first {
            self.employeeList = results.filter("id != %@",me.id)
            employeeCollection.reloadData()

        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width : employeeCollection.frame.width - 4 , height : 80);
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let list = employeeList {
            return list.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let employeeCell = employeeCollection.dequeueReusableCell(withReuseIdentifier: "EmployeeCell", for: indexPath) as? EmployeeCell {
            employeeCell.updateViews(employee : employeeList[indexPath.row])
            return employeeCell
        }
        else {
            return EmployeeCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EmployeeToChatSegue", sender: employeeList[indexPath.row])

    }
    
    override
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmployeeToChatSegue" {
            if let chatController = segue.destination as? ChatController {
                if let entity = sender as? Employee {
                    chatController.initializeChat(entity: entity)
                }
            }
        }
    }
}

import UIKit

class InitialDetailController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {


    @IBOutlet weak var submit : UIButton?
    @IBOutlet weak var name : UITextField?
    @IBOutlet weak var gender : UITextField?
    @IBOutlet weak var designation : UITextField?

    @IBOutlet weak var error : UILabel?
    var genderPicker : UIPickerView?
    var desginationPicker : UIPickerView?
    
    
    let genderTitles  = ["Male","Female"]
    let designationTitles = ["Developer","QA","Dev-Ops"]
    var PICKER : Int = 0;

    var me : Employee = Employee()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        initializeUI()
    }
    
    func validateForm() -> Employee? {
        let employee = Employee()
        if let name = name?.text {
            employee.name = name
        }
        if let designation = designation?.text {
            employee.designation = designation
        }
        if let gender = gender?.text {
            employee.gender = gender
        }
        employee.token = me.token
        return employee
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        if let employee = validateForm() {
            ApiService.instance.callEmployeeEditApi(employee : employee, completion: { (success, message) in
                if success {
                    print("Success")
                    self.callInitialDataSync()
                }
                else {
                    print("Error")
                }
            });

        }
    }
    
    func callInitialDataSync() {
        ApiService.instance.callEmployeeListApi(completion: { (success, message) in
            if success {
                ApiService.instance.callPostListApi(completion: { (success, message) in
                    if success {
                        self.performSegue(withIdentifier: "InitialDetailToTabSegue", sender: nil)
                        
                    }
                });
            }
        }, token: me.token);
    }
    
    @IBAction func designationEditingBegin(_ sender: Any) {
        PICKER = 1
        designation?.inputView = desginationPicker
    }
    
    @IBAction func genderEditingBegin(_ sender: Any) {
        PICKER = 0
        gender?.inputView = genderPicker
    }
    
    func initializeUI() {
        genderPicker = UIPickerView()
        genderPicker?.frame = CGRect(x: 10, y : self.view.frame.height/2,
                                     width : self.view.frame.width-20,
                                     height : 100)
        genderPicker?.delegate = self
        genderPicker?.dataSource = self
        
        desginationPicker = UIPickerView()
        desginationPicker?.frame = CGRect(x: 10, y : self.view.frame.height/2,
                                     width : self.view.frame.width-20,
                                     height : 100)
        desginationPicker?.delegate = self
        desginationPicker?.dataSource = self
        
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.hidesBackButton = true
    }
    
    func initializeMe(employee : Employee) {
        self.me = employee;
    }

    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch PICKER {
        case 0 :
            return genderTitles.count
        case 1 :
            return designationTitles.count
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch PICKER {
        case 0 :
            return genderTitles[row]
        case 1 :
            return designationTitles[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch PICKER {
        case 0:
            gender?.text = genderTitles[row]
            gender?.endEditing(true)
            
        case 1:
            designation?.text = designationTitles[row]
            designation?.endEditing(true)
        default:
            print("default")
        }
        
        
    }
    

    
}

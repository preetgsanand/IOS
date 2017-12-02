
import UIKit
import RealmSwift


class LoginController: UIViewController {

    
    @IBOutlet weak var email : UITextField?
    @IBOutlet weak var password : UITextField?
    @IBOutlet weak var login : UIButton?
    @IBOutlet weak var error : UILabel?
    
    var realm : Realm?
    var SEGUE : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        setNavigationBar()
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.hidesBackButton = true

    }
    
    @IBAction func registerPressed(_ sender: Any) {
        SEGUE = 0;
        performSegue(withIdentifier: "LoginToRegisterSegue", sender: nil)
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if self.validateForm() == true {
            ApiService.instance.callLoginApi(email: (email?.text)!, password: (password?.text)!) { (success, message)  in
                if success {
                    print("Success")
                    self.SEGUE = 2
                    if self.realm?.objects(Employee.self).count != 0 {
                        if let me = self.realm?.objects(Employee.self).first {
                            self.performSegue(withIdentifier: "LoginToDetailSegue", sender: me)
                        }
                    }
                }
                else {
                    self.error?.text = message
                    print("Error")
                }
            }
        }
        
    }
    
    func validateForm() -> Bool {
        var validate : Int = 1
        error?.text = ""
        if let emailtext = email?.text {
            if isValidEmail(email : emailtext) != true {
                validate = 0;
                if let errorText = error?.text {
                    error?.text = errorText+"Please enter a valid email";
                }
            }
        }
        
        if let passwrodText = password?.text {
            if passwrodText.count < 6 {
                validate = 0;
                if let errorText = error?.text {
                    error?.text = errorText+"\nPassword must be atleast 6 characters";
                }
            }
        }
        if validate == 0 {
            return false
        }
        else {
            return true
        }
    }
    
    override
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if SEGUE == 0 {
            if let registerController = segue.destination as? RegisterController {
                registerController.viewDidLoad()
            }
        }
        else if SEGUE == 1 {
            if let employeeController = segue.destination as? EmployeeController {
                employeeController.viewDidLoad()
            }
        }
        else if SEGUE == 2 {
            if let initialDetailController = segue.destination as? InitialDetailController {
                if let me = sender as? Employee {
                    initialDetailController.initializeMe(employee : me)

                }
            }
        }
    }
   
}

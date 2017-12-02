import UIKit
import RealmSwift


class RegisterController: UIViewController {

    @IBOutlet weak var email : UITextField?
    @IBOutlet weak var password : UITextField?
    @IBOutlet weak var register : UIButton?
    @IBOutlet weak var error : UILabel?
    
    var realm : Realm?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        realm = try! Realm()
    }
    
    func setNavigationBar() {
       
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        if self.validateForm() == true {
            if let emailText = email?.text, let passwordText = password?.text {
                ApiService.instance.callRegisterApi(email: emailText, password: passwordText) { (success, message)  in
                    if success {
                        print("Success")
                        if self.realm?.objects(Employee.self).count != 0 {
                            if let me = self.realm?.objects(Employee.self).first {
                                self.performSegue(withIdentifier: "RegisterToDetailSegue", sender: me)
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
        if let initialDetailController = segue.destination as? InitialDetailController {
            if let employee = sender as? Employee {
                initialDetailController.initializeMe(employee: employee)
            }
        }
    }
    
    


}

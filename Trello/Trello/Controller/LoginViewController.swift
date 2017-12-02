import UIKit

class LoginViewController: UIViewController, LoginViewDelegate {
    
   
    

    @IBOutlet weak var usernameText : UITextField!
    @IBOutlet weak var submitButton : UIButton!
    @IBOutlet weak var errorLabel : UILabel!
    
    var loginViewPresenter : LoginViewPresenter = LoginViewPresenter()
    
    override func viewDidLoad() {
        self.hideNavigationBar()
        loginViewPresenter.loginViewDelegate = self
        super.viewDidLoad()
    }
    
    func callBoardSegue() {
        performSegue(withIdentifier: "LoginToBoardSegue", sender: nil)
    }

    func callLoginToBoardSegue() {
        performSegue(withIdentifier: "LoginToBoardSegue", sender: nil)
    }
    
    @IBAction func submitPressed(_ sender : Any) {
        if let username = usernameText.text {
            loginViewPresenter.callMemberDetailApi(username: username)
        }
    }
    
    func publishApiResult(_ success : Bool, _ message : String) {
        if success {
            
        }
        else {
            errorLabel?.text = message
        }
    }
    
    
    func hideNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.hidesBackButton = true
    }

   
}

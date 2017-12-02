import UIKit

class EmployeeCell: UICollectionViewCell {
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var email : UILabel!
    @IBOutlet weak var status : UIImageView!
    
    func updateViews(employee : Employee) {
        self.name.text = employee.name
        self.email.text = employee.email
        
        if employee.status {
            self.status.image = UIImage(named : "online")
        }
        else {
            self.status.image = UIImage(named : "offline")

        }
    }
}


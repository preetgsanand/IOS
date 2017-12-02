import UIKit
import RealmSwift

class ChatController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{


    
    @IBOutlet weak var chatCollection : UICollectionView?
    @IBOutlet weak var messageTextField : UITextField?
    @IBOutlet weak var send : UIButton?
    
    
    var messageList : Results<Message>!
    var realm : Realm!
    var me : Employee!
    var entity : Employee!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let chatCol = chatCollection {
            chatCol.delegate = self
            chatCol.dataSource = self
        }
        
    }
    
    override
    func viewWillAppear(_ animated: Bool) {
        self.initializeHandler()
    }
    
    
    @IBAction func sendPressed(_ sender: Any) {
        if let messageText = messageTextField?.text {
            let message = Message()
            message.from = self.me.id
            message.to = self.entity.id
            message.body = messageText
            try? realm.write {
                realm.add(message)
            }
            SocketService.instance.emitNewMessage(to: self.entity.id, message: message)
            messageTextField?.text = ""
            reloadChatCollection()

        }
    }
    
    

    
    func initializeChat(entity : Employee) {
        realm = try! Realm()
        let results = realm.objects(Employee.self)
        self.me = results.first
        self.entity = entity
        self.reloadChatCollection()
        self.initializeHandler()
    }
    
    func reloadChatCollection() {
        if let me = self.me, let entity = self.entity {
            self.messageList = realm.objects(Message.self).filter("from == %@ && to == %@ || from = %@ && to == %@",entity.id,me.id,me.id,entity.id)
            
            if let chatCol = chatCollection {
                chatCol.reloadData()
                
                let lastItemIndex = NSIndexPath(item: self.messageList.count-1, section: 0)
                chatCol.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionViewScrollPosition.bottom, animated: false)
                
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let chatCol = chatCollection {
            let messageHeight = CGFloat(self.messageList[indexPath.row].body.count/4+100)
            return CGSize(width : chatCol.frame.width,
                          height : messageHeight);
        }
        else {
            return CGSize(width : 0,
                          height : 0);
        }
        
    }
    
    func initializeHandler() {
        SocketService.instance.setSocketCompletion { (CODE) in
            switch CODE {
            case ON_NEW_MESSAGE :
                self.reloadChatCollection()
            default :
                print("Code Unanswered : ",CODE);
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let chatCol = chatCollection, let messageCell = chatCol.dequeueReusableCell(withReuseIdentifier: "MessageCell", for: indexPath) as? MessageCell {
            messageCell.updateViews(message: self.messageList[indexPath.row])
            return messageCell
        }
        else {
            return MessageCell()
        }
    }
    


}

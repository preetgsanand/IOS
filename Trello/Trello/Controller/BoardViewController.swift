import UIKit

class BoardViewController: UIViewController, BoardViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    

    @IBOutlet weak var boardCollection : UICollectionView!
    
    var boardViewPresenter : BoardViewPresenter = BoardViewPresenter()
    
    override func viewDidLoad() {
        self.hideBackButton()
        super.viewDidLoad()
        boardViewPresenter.boardViewDelegate = self
        boardViewPresenter.checkInitialSetup()
    }
    
    func callLoginController() {
        performSegue(withIdentifier: "LoginSegue", sender: nil)
    }
    
    func renderBoardList(boardListViewModel : BoardListViewModel) {
        boardCollection?.dataSource = self
        boardCollection?.delegate = self
        boardCollection?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width : boardCollection.frame.width-2,
                      height : 150)
    }
    
    func hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let boardListViewModel = boardViewPresenter.boardListViewModel {
            print(boardListViewModel.getBoardList().count)
            return boardListViewModel.getBoardList().count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let boardCell = boardCollection.dequeueReusableCell(withReuseIdentifier: "BoardCell", for: indexPath) as? BoardCell , let boardListViewModel = boardViewPresenter.boardListViewModel{
            boardCell.updateView(board: boardListViewModel.getBoardList()[indexPath.row])
            return boardCell
        }
        else {
            return BoardCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let boardListViewModel = boardViewPresenter.boardListViewModel {
            performSegue(withIdentifier: "BoardToBoardTabSegue", sender: boardListViewModel.getBoardList()[indexPath.row].id)
        }
    }
    
    override
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BoardToBoardTabSegue" {
            if let boardTabController = segue.destination as? BoardTabController, let boardId = sender as? String{
                let boardTabViewPresenter = BoardTabViewPresenter(boardId : boardId)
                boardTabController.intializeParamater(boardTabViewPresenter : boardTabViewPresenter)
            }
        }
    }
    

}

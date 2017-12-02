import Foundation

class BoardListViewModel {
    private(set) var boardList : [Board]
    
    init(boardList : [Board]) {
        self.boardList = boardList
    }
    
    func getBoardList() -> [Board] {
        return self.boardList
    }
}

class BoardViewModel {
    private(set) var board : Board
    
    init(board : Board) {
        self.board = board
    }
}

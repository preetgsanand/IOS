

import Foundation

protocol HomeProtocol {
    // PRESENTER -> VIEW
    func renderListViewModel(listViewModel : ListViewModel)
    func initializeParameters()
}


protocol HomeListCellProtocol {
    // Cell -> VIEW
    func genreSelected(viewModel : GenreViewModel)
    func movieSelected(viewModel : MovieViewModel)
    func tvSelected(viewModel : TvViewModel)
}

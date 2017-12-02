import Foundation


protocol MovieProtocol {
    func renderMovieList(movieViewModels : [MovieViewModel])
    func changeViewTitle(_ title : String)
    func add(movieViewModels : [MovieViewModel])
    func initializeSegmentControl()

}

protocol SearchProtocol {
    func renderMovieList(movieViewModels : [MovieViewModel])
    func renderTvList(tvViewModels : [TvViewModel])
    func initializeParameters()
    func add(movieViewModels : [MovieViewModel])
    func add(tvViewModel : [TvViewModel])
    func removeAll(position : Int)

}

protocol MovieDetailProtocol {
    func setTitle(title : String)
    func renderView(_ movieDetailViewModel: MovieDetailViewModel, castViewModels : [CastViewModel])
}



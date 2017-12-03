import Foundation
import UIKit

protocol MovieNavigationProtocol {
    func createMovieListModule() -> UIViewController
    func presentMovieDetailModule(fromView : Any?, movieId : Int)
}

protocol TvNavigationProtocol {
    func createTvListModule() -> UIViewController
    func presentTvDetailModule(fromView : Any?, tvId : Int)
    func presentSeasonDetailModule(fromView : Any?, tvId : Int, seasons : [SeasonViewModel])
}

protocol MovieSearchNavigationProtocol : MovieNavigationProtocol {
    func presentTvDetailModule(fromView: Any?, tvId: Int)
}

protocol HomeNavigationProtocol {
    func createHomeModule() -> UIViewController
    func presentGenreMovies(fromView: Any?, genreId : Int)
}

protocol PeopleNavigationProtocol {
    func presentPeopleDetail(fromView : Any?, peopleId : Int)
}

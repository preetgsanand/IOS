

import Foundation


class PeopleDetailPresenter : PresenterApiProtocol {
    
    var view : PeopleDetailProtocol
    var loader : LoaderProtocol
    var navigation : PeopleNavigation
    var person : Int
    var api : BasicApiServiceProtocol
    var movieNavigation : MovieNavigation
    
    init(person : Int, view : PeopleDetailProtocol, loader : LoaderProtocol, navigation : PeopleNavigation,
         api : BasicApiServiceProtocol, movieNavigation : MovieNavigation) {
        self.person = person
        self.loader = loader
        self.navigation = navigation
        self.view = view
        self.api = api
        self.movieNavigation = movieNavigation
    }
    
    func viewDidLoad() {
        loader.showLoading()
        callPeopleDetailApi()
    }
    
    func callPeopleDetailApi() {
        let endPoint = endPoints.peopleDetail(api_key: API_KEY, people_id: person, language: "en-US", append_to_response: "credits")
        api.initializeValues(code: endPoint, publishCode: 7, presenter: self)
        api.makeRequest()
    }
    
    
    
    func publishApiResponse(_ success: Bool, _ code: Int, _ data: Any?) {
        loader.hideLoading()
        if success, let people = data as? People {
            let peopleDetailViewModel = PeopleDetailViewModel(name : people.name,
                                                              birthday : people.birthday ?? Date(),
                                                              profile_path : people.profile_path,
                                                              biography : people.biography ?? "",
                                                              place_of_birth : people.place_of_birth ?? "")
            var peopleCreditViewModels = [PeopleCreditViewModel]()
            if let credits = people.credits {
                for i in 0..<credits.count {
                    let peopleCreditViewModel = PeopleCreditViewModel(id : credits[i].id,
                                                                      poster_path : credits[i].poster_path,
                                                                      release_date : credits[i].release_date,
                                                                      character : credits[i].character,
                                                                      title : credits[i].title)
                    peopleCreditViewModels.append(peopleCreditViewModel)
                }
            }
            
            view.renderView(peopleDetailViewModel, peopleCreditViewModels)
            
            
        }
    }
    
    func movieSelected(id : Int) {
        movieNavigation.presentMovieDetailModule(fromView: view, movieId: id)
    }
    
    
    
    
    
}

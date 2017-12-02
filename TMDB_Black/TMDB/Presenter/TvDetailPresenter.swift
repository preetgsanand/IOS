import Foundation


class TvDetailPresenter : PresenterApiProtocol{
  
    
    
    var view : TvDetailProtocol
    var loader : LoaderProtocol
    var navigation : TvNavigationProtocol
    var tv : Int
    var api : BasicApiServiceProtocol
    
    init(tv : Int, view : TvDetailProtocol, loader : LoaderProtocol, navigation : TvNavigationProtocol,
         api : BasicApiServiceProtocol) {
        self.tv = tv
        self.loader = loader
        self.navigation = navigation
        self.view = view
        self.api = api
    }
    
    func viewDidLoad() {
        loader.showLoading()
        callTvDetailApi()
    }
    
    func callTvDetailApi() {
        api.initializeValues(code : .tvDetail(api_key: API_KEY, tv_id: String(tv), language: "en-US", append_to_response: "credits"), publishCode : 0, presenter : self)
        api.makeRequest()
    }
    
    
    func publishApiResponse(_ success: Bool, _ code: Int, _ data: Any?) {
        loader.hideLoading()
        switch code {
        case 0:
            if let tv = data as? Tv {
                if let overview = tv.overview, let seasons = tv.season, let cast = tv.cast {
                    let viewModel = TvDetailViewModel(name : tv.name,
                                                      backdrop_path : tv.backdrop_path,
                                                      vote_average : tv.vote_average,
                                                      first_release_date : tv.first_release_date,
                                                      overview : overview)
                    
                    var seasonViewModels = [SeasonViewModel]()
                    var castViewModels = [CastViewModel]()
                    for i in 0..<seasons.count {
                        let seasonViewModel = SeasonViewModel(seasonId : seasons[i].id,
                                                              season_number : seasons[i].season_number,
                                                              poster_path : seasons[i].poster_path,
                                                              episode_count : seasons[i].episode_count)
                        seasonViewModels.append(seasonViewModel)
                    }
                    for i in 0..<cast.count {
                        let castViewModel = CastViewModel(name : cast[i].name,
                                                          character : cast[i].character,
                                                          profile_path : cast[i].profile_path)
                        castViewModels.append(castViewModel)
                    }
                    self.view.renderView(viewModel: viewModel, castViewModels: castViewModels, seasonViewModels : seasonViewModels)
                    self.view.setTitle(title: viewModel.name)
                }
                
            }
        default:
            print("--- Default Publish Code : Tv Detail Presenter ----", code)
        }
    }
    
    
    func seasonMoreClicked(seasons : [SeasonViewModel]) {
        navigation.presentSeasonDetailModule(fromView: view, tvId: self.tv, seasons : seasons)
    }
    
}

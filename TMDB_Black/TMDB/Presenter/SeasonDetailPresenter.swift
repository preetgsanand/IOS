import Foundation


class SeasonDetailPresenter  : PresenterApiProtocol {
   
    
    let tvId : Int
    let seasonViewModels : [SeasonViewModel]
    let loader : LoaderProtocol
    let view : SeasonDetailProtocol
    var api : BasicApiServiceProtocol
    
    init(tvId : Int,seasonViewModels : [SeasonViewModel], loader : LoaderProtocol, view : SeasonDetailProtocol, api  :BasicApiServiceProtocol) {
        self.tvId = tvId
        self.seasonViewModels = seasonViewModels
        self.loader = loader
        self.view = view
        self.api = api
    }
    
    
    func viewDidLoad() {
        view.initializeSegments(seasonViewModels: seasonViewModels)
    }
    
    func publishApiResponse(_ success: Bool, _ code: Int, _ data: Any?) {
        if success, let seasonDetail = data as? SeaosonDetail {
            let seasonDetailViewModel = SeasonDetailViewModel(seasonId: seasonDetail.id,
                                                              poster_path : seasonDetail.poster_path,
                                                              air_date : seasonDetail.air_date,
                                                              name : seasonDetail.name)
            var episodeViewModels = [EpisodeViewModel]()
            for i in 0..<seasonDetail.episodes.count {
                episodeViewModels.append(EpisodeViewModel(id : seasonDetail.episodes[i].id,
                                                          name : seasonDetail.episodes[i].name,
                                                          overview : seasonDetail.episodes[i].overview,
                                                          still_path : seasonDetail.episodes[i].still_path,
                                                          vote_average : seasonDetail.episodes[i].vote_average,
                                                          air_date : seasonDetail.episodes[i].air_date,
                                                          episode_number : seasonDetail.episodes[i].episode_number))
            }
            self.loader.hideLoading()
            self.view.renderSeasonDetail(seasonViewModel: seasonDetailViewModel, episodeViewModels: episodeViewModels)
        }
    }
    
    func callSeasonDetailApi(position : Int) {
        self.loader.showLoading()
        api.initializeValues(code : endPoints.seasonDetails(api_key: API_KEY, tv_id: tvId, season_number: seasonViewModels[position].season_number, language: "en-US"), publishCode: 0, presenter: self)
        api.makeRequest()
    }


    
    
}

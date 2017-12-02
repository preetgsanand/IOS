import Foundation

class TvPresenter : PresenterApiProtocol {
  
    
    
    var view : TvProtocol
    var navigation : TvNavigationProtocol
    var loader : LoaderProtocol
    var page : Int
    var api : BasicApiServiceProtocol
    
    init(view : TvProtocol, navigation : TvNavigationProtocol, loader : LoaderProtocol, api : BasicApiServiceProtocol){
        self.page = 1
        self.view = view
        self.navigation = navigation
        self.loader = loader
        self.api = api
    }
    
    func viewDidLoad() {
        self.view.initializeSegmentControl()
        self.view.initializeLoadingIndicator()
        loader.showLoading()
        callTvApi(position: 0)
        
    }
    
    func createServiceForSegment(position : Int, publishCode : Int)  {
        switch position {
        case 0:
            api.initializeValues(code : endPoints.tvAiringToday(api_key: API_KEY, language: "en-US", page: page), publishCode: publishCode, presenter: self)
            break;
        case 1:
            api.initializeValues(code : endPoints.tvOnAir(api_key: API_KEY, language: "en-US", page: page), publishCode: publishCode, presenter: self)
            break;
        case 2:
            api.initializeValues(code : endPoints.tvPopular(api_key: API_KEY, language: "en-US", page: page), publishCode: publishCode, presenter: self)
            break;
        case 3:
            api.initializeValues(code : endPoints.tvTop(api_key: API_KEY, language: "en-US", page: page), publishCode: publishCode, presenter: self)
            break;
        default:
            api.initializeValues(code : endPoints.tvTop(api_key: API_KEY, language: "en-US", page: page), publishCode: publishCode, presenter: self)
            break;
        }
    }
    
    
    func callTvApi(position : Int) {
        self.page = 1
        createServiceForSegment(position: position, publishCode: 0)
        api.makeRequest()
    }
    
    
    func createTvViewModels(tvs : [Tv]) -> [TvViewModel]{
        var tvViewModels = [TvViewModel]()
        for i in 0..<tvs.count {
            let singleViewModel = TvViewModel(id : tvs[i].id,
                                              name : tvs[i].name,
                                              backdrop_path : tvs[i].backdrop_path,
                                              vote_average : tvs[i].vote_average,
                                              first_release_date : tvs[i].first_release_date)
            tvViewModels.append(singleViewModel)
        }
        return tvViewModels

    }
    
    func tvSelected(tvViewModel : TvViewModel) {
        navigation.presentTvDetailModule(fromView: view, tvId: tvViewModel.id)
    }

    
    func loadMoreTvs(position : Int) {
        self.page += 1
        createServiceForSegment(position: position, publishCode: 1)
        api.makeRequest()
    }
    
    func publishApiResponse(_ success: Bool, _ code: Int, _ data: Any?) {
        switch code {
        case 0:
            if let tvs = data as? [Tv] {
                let tvViewModels = self.createTvViewModels(tvs: tvs)
                self.view.renderTvList(viewModels: tvViewModels)
                self.loader.hideLoading()
            }
            break;
        case 1:
            if let tvs = data as? [Tv] {
                let tvViewModels = self.createTvViewModels(tvs: tvs)
                self.view.add(tvViewModels: tvViewModels)
            }
            break;
        default:
            print("--- Default Publish Code : Tv Presentrer --- ", code)
        }
    }
}

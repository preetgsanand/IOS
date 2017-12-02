import XCTest
@testable import TMDB
class TvPresenterTests: XCTestCase {
    
    var tvPresenter : TvPresenter?
    let loader  = LoaderMock()
    let view = TvProtocolMock()
    let api = BasicApiStub()
    let navigation = TvNavigationMock()
    
    override func setUp() {
        super.setUp()
        tvPresenter = TvPresenter(view : view, navigation : navigation, loader : loader, api: api)
       
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testViewDidLoad() {
        tvPresenter?.viewDidLoad()
        XCTAssert(loader.getLoading() == false)
        XCTAssert(view.getViewModels().count == 1)
    }
    
    func testCallTvApi() {
        XCTAssert(loader.getLoading() == false)
        tvPresenter?.callTvApi(position: 0)
        XCTAssert(loader.getLoading() == false)
        XCTAssert(view.getViewModels().count == 1)
    }
    
    func testLoadMore() {
        tvPresenter?.loadMoreTvs(position: 0)
        XCTAssert(loader.getLoading() == false)
        XCTAssert(view.getViewModels().count == 1)
    }
    
    func testTvSelected() {
        let tvViewModel = TvViewModel(id : 1,
                                      name : "1",
                                      backdrop_path : "1",
                                      vote_average : 1,
                                      first_release_date : Date())
        tvPresenter?.tvSelected(tvViewModel: tvViewModel)
        XCTAssert(navigation.getDetailPressed() == true)
    }

}

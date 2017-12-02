import Foundation


protocol PresenterApiProtocol {
    // API -> PRESENTER
    func publishApiResponse(_ success : Bool, _ code : Int, _ data : Any?)
}

protocol BasicApiServiceProtocol {
    // BASIC API SERVICE
    func makeRequest()
    func initializeValues(code : endPoints, publishCode : Int, presenter : PresenterApiProtocol)
}

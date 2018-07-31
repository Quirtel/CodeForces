import Foundation
import Moya

class ContestProvider {
    private let contestProvider = MoyaProvider<ContestAPI>()
    
    func contestList(
        requestParams: ContestListRequest,
        _ completion: @escaping (Result<[Contest]>) -> ()) {
        Provider.request(
            provider: contestProvider,
            target: ContestAPI.list(requestParams: requestParams)) { (result: Result<[Contest]>) -> () in
                completion(result)
        }
    }
    
    func contestStatus(
        requestParams: ContestStatusRequest, _ completion: @escaping (Result<[Submission]>) -> ()) {
        Provider.request(
            provider: contestProvider,
            target: ContestAPI.status(requestParams: requestParams)) { (result: Result<[Submission]>) -> () in
                    completion(result)
        }
    }
    
    func contestStandings(
        requestParams: ContestStandingsRequest, _ completion: @escaping (Result<ContestStandings>) -> ()) {
        Provider.request(
            provider: contestProvider,
            target: ContestAPI.standings(requestParams: requestParams)) { (result: Result<ContestStandings>) -> () in
                completion(result)
        }
    }
}

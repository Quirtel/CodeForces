import Foundation

class ContentService {
    private let dayTime = TimeInterval(exactly: 60*60*24)!
    private let networkService = NetworkService()
    private let realmService = RealmService()
    
    init() {
        //force load data in case of day is gone from last download
        let now = Date()
        let preferences = Preferences()
        let diff = now.timeIntervalSince(preferences.lastUpdated)
        
        if diff > dayTime {
            //need to update
            fetchProblemSetProblems(
            withRequestParams: ProblemSetProblemsRequest(
                tags: nil, problemsetName: nil), force: true) { [weak self] result in
                if case .success(let problems) = result {
                    _ = self?.realmService.addProblemSetProblems(problems)
                }
            }
            let gymFalseParams = ContestListRequest(gym: false)
            fetchContestList(
            withRequestParams: gymFalseParams, force: true) { [weak self] result in
                if case .success(let contests) = result {
                    _ = self?.realmService.addContestList(
                        contests, withRequestParams: gymFalseParams)
                }
            }
            
            let gymTrueParams = ContestListRequest(gym: true)
            fetchContestList(
            withRequestParams: gymTrueParams, force: true) { [weak self] result in
                if case .success(let contests) = result {
                    _ = self?.realmService.addContestList(
                        contests, withRequestParams: gymTrueParams)
                }
            }
            preferences.lastUpdated = now
        }
    }
    
    func fetchContestList(
        withRequestParams: ContestListRequest, force: Bool = false,
        _ completion: @escaping (Result<[Contest]>) -> ()) {
        if force {
            networkService.fetchContestList(
            requestParams: withRequestParams) { [weak self] result in
                if case .success(let list) = result {
                    _ = self?.realmService.addContestList(
                        list, withRequestParams: withRequestParams)
                }
                completion(result)
            }
        } else {
            completion(realmService.getContestList(withRequestParams: withRequestParams))
        }
    }
    
    func fetchProblemSetProblems(
        withRequestParams: ProblemSetProblemsRequest, force: Bool = false,
        _ completion: @escaping (Result<ProblemSetProblems>) -> ()) {
        if force {
            networkService.fetchProblemSetProblems(
            requestParams: withRequestParams) { [weak self] result in
                if case .success(let problems) = result {
                    _ = self?.realmService.addProblemSetProblems(
                    problems)
                }
                completion(result)
            }
        } else {
            completion(realmService.getProblemSetProblems())
        }
    }
    
    ///Warning: `param` **force** is not used.
    ///Just gives data from the Internet (like *force* is set to **true**)
    func fetchContestStatus(
        withRequestParams: ContestStatusRequest, force: Bool = false,
        _ completion: @escaping (Result<[Submission]>) -> ()) {
        networkService.fetchContestStatus(requestParams: withRequestParams) { result in
            completion(result)
        }
    }
    
    ///Warning: `param` **force** is not used.
    ///Just gives data from the Internet (like *force* is set to **true**)
    func fetchContestStandings(
        withRequestParams: ContestStandingsRequest,  force: Bool = false,
        _ completion: @escaping (Result<ContestStandings>) -> ()) {
        networkService.fetchContestStandings(requestParams: withRequestParams) { result in
            completion(result)
        }
    }
    
    ///Warning: `param` **force** is not used.
    ///Just gives data from the Internet (like *force* is set to **true**)
    func fetchContestRatingChanges(
        withRequestParams: ContestRatingChangesRequest,  force: Bool = false,
        _ completion: @escaping (Result<[RatingChange]>) -> ()) {
        networkService.fetchContestRatingChanges(requestParams: withRequestParams) { result in
            completion(result)
        }
    }
    
    ///Warning: `param` **force** is not used.
    ///Just gives data from the Internet (like *force* is set to **true**)
    func fetchProblemSetRecentStatus(
        withRequestParams: ProblemSetRecentStatusRequest,  force: Bool = false,
        _ completion: @escaping (Result<[Submission]>) -> ()) {
        networkService.fetchProblemSetRecentStatus(requestParams: withRequestParams) { result in
            completion(result)
        }
    }
    
    ///Warning: `param` **force** is not used.
    ///Just gives data from the Internet (like *force* is set to **true**)
    func fetchUserRating(
        withRequestParams: UserRatingRequest,  force: Bool = false,
        _ completion: @escaping (Result<[RatingChange]>) -> ()) {
        networkService.fetchUserRating(requestParams: withRequestParams) { result in
            completion(result)
        }
    }
    
    ///Warning: `param` **force** is not used.
    ///Just gives data from the Internet (like *force* is set to **true**)
    func fetchUserStatus(
        withRequestParams: UserStatusRequest,  force: Bool = false,
        _ completion: @escaping (Result<[Submission]>) -> ()) {
        networkService.fetchUserStatus(requestParams: withRequestParams) { result in
            completion(result)
        }
    }
}

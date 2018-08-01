import Foundation
import RealmSwift

final class RealmService {
    private let realm = try! Realm()

    private func requestList<Element: Object & RealmObject>(
        _ requestType: Element.Type) -> [Element.S] {
        let realmObjects = realm.objects(Element.self)
        return realmObjects.map { $0.model }
    }
    
//    //withGym: Bool, not used, default is false
//    func contestList() -> Result<[Contest]> {
//        return Result.success(requestList(ContestRealm.self))
//    }
//
//    //handle: String?,
//    func contestStatus(withRequestParams: ContestStatusRequest) -> Result<[Submission]> {
//        let submissions = requestList(
//            SubmissionRealm.self).filter{
//                $0.contestId ==  withRequestParams.contestId
//
//        }
//        return Result.success(submissions)
//    }
//
//    func fetchContestStandings() -> Result<ContestStandings> {
//        if let standings = realm.objects(ContestStandingsRealm.self).first?.model {
//            return Result.success(standings)
//        } else {
//            return Result.error(CommonErrors.realmNotFoundError)
//        }
//    }
//
//    func fetchContestRatingChanges() -> [RatingChange] {
//        return requestList(RatingChangeRealm.self)
//    }
//
//    func fetchProblemsetProblems() -> Result<ProblemSetProblems> {
//        if let problems = realm.objects(ProblemSetProblemsRealm.self).first?.model {
//            return Result.success(problems)
//        } else {
//            return Result.error(CommonErrors.realmNotFoundError)
//        }
//    }
    
//    func fetchProblemsetRecentStatus(
//        withRequestParams: ProblemSetRecentStatusRequest,
//        _ completion: @escaping (Result<[Submission]>) -> ()) {
//        NetworkService.request(
//            provider: problemSetPovider,
//            target: ProblemSetAPI.recentStatus(
//                requestParams: withRequestParams)) {
//                    (result: Result<[Submission]>) -> () in
//                    completion(result)
//        }
//    }
//
//    func fetchUserRating(
//        withRequestParams: UserRatingRequest,
//        _ completion: @escaping (Result<[RatingChange]>) -> ()) {
//        NetworkService.request(
//            provider: userProvider,
//            target: UserAPI.rating(
//                requestParams: withRequestParams)) {
//                    (result: Result<[RatingChange]>) -> () in
//                    completion(result)
//        }
//    }
//
//    func fetchUserStatus(
//        withRequestParams: UserStatusRequest,
//        _ completion: @escaping (Result<[Submission]>) -> ()) {
//        NetworkService.request(
//            provider: userProvider,
//            target: UserAPI.status(
//                requestParams: withRequestParams)) {
//                    (result: Result<[Submission]>) -> () in
//                    completion(result)
//        }
//    }
    
}

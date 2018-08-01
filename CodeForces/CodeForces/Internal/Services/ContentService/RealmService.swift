import Foundation
import RealmSwift

final class RealmService {
    private let realm = try! Realm()
    
    //reading operations
    
    func contestList(withRequestParams: ContestListRequest) -> Result<[Contest]> {
        let realmObjects = realm.objects(ContestRealm.self)
            .filter{ $0.gym == withRequestParams.gym }
        return Result.success(realmObjects.map{ $0.model })
    }
    
    ///Warning: `param` **withRequestParams** is not used.
    ///Just gives the first existing ProblemSetProblems object
    func problemsetProblems(
        /*withRequestParams: ProblemSetProblemsRequest*/) -> Result<ProblemSetProblems> {
        if let problems = realm.objects(ProblemSetProblemsRealm.self).first?.model {
            return Result.success(problems)
        } else {
            return Result.error(RealmErrors.realmNotFoundError)
        }
    }
    
    //writing operations
    func saveContestList(
            _ list: [Contest], withRequestParams: ContestListRequest) -> Result<[Contest]> {
        do {
            try realm.write {
                for contest in list {
                    let contestRealm = contest.persistenceObject
                    contestRealm.gym = withRequestParams.gym
                    realm.create(ContestRealm.self, value: contestRealm, update: true)
                }
            }
            return Result.success(list)
        } catch {
            return Result.error(RealmErrors.realmCannotSaveError)
        }
    }
    
    func saveProblemSetProblems(_ problems: ProblemSetProblems) -> Result<ProblemSetProblems> {
        do {
            try realm.write {
                let problemsRealm = problems.persistenceObject
                problemsRealm.realmId = problemsRealm.getRealmId()
                realm.add(problemsRealm, update: true)
            }
            return Result.success(problems)
        } catch {
            return Result.error(RealmErrors.realmCannotSaveError)
        }
    }
    
    
//    private func requestList<Element: Object & RealmObject>(
//        _ requestType: Element.Type) -> [Element.S] {
//        let realmObjects = realm.objects(Element.self).filter{ $0 }
//        return realmObjects.map { $0.model }
//    }

//    //handle: String?,
//    func contestStatus(withRequestParams: ContestStatusRequest) -> Result<[Submission]> {
//        let submissions = requestList(
//            SubmissionRealm.self).filter{
//                $0.contestId ==  withRequestParams.contestId
//
//        }
//        return Result.success(submissions)
//    }

//    func fetchContestStandings() -> Result<ContestStandings> {
//        if let standings = realm.objects(ContestStandingsRealm.self).first?.model {
//            return Result.success(standings)
//        } else {
//            return Result.error(CommonErrors.realmNotFoundError)
//        }
//    }

//    func fetchContestRatingChanges() -> [RatingChange] {
//        return requestList(RatingChangeRealm.self)
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

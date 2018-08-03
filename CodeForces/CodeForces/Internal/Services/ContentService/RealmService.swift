import Foundation
import RealmSwift

final class RealmService {
    private let realmQueue = DispatchQueue(label: "RealmQueue")
    
    func getContestList(
        withRequestParams: ContestListRequest,
        _ completion: @escaping (Result<[Contest]>) -> ()) {
        realmQueue.async {
            let realm = try! Realm()
            let realmObjects = realm.objects(ContestRealm.self)
                .filter{ $0.gym == withRequestParams.gym }
            let objects = realmObjects.map{ $0.model }
            var contests = [Contest]()
            for obj in objects {
                contests.append(obj)
            }
            DispatchQueue.main.async {
                completion(Result.success(contests))
            }
        }
    }
    
    func getProblemSetProblems(
        _ completion: @escaping (Result<ProblemSetProblems>) -> ())  {
        realmQueue.async {
            let realm = try! Realm()
            if let problems = realm.objects(ProblemSetProblemsRealm.self).first?.model {
                DispatchQueue.main.async {
                    completion(Result.success(problems))
                }
            } else {
                DispatchQueue.main.async {
                    completion(Result.error(RealmErrors.realmNotFoundError))
                }
            }
        }
    }
    
    func addContestList(
        _ list: [Contest], withRequestParams: ContestListRequest,
        _ completion: @escaping (Result<[Contest]>) -> ()) {
        realmQueue.async {
            let realm = try! Realm()
            do {
                try realm.write {
                    for contest in list {
                        let contestRealm = contest.persistenceObject
                        contestRealm.gym = withRequestParams.gym
                        realm.add(contestRealm, update: true)
                    }
                }
                DispatchQueue.main.async {
                    completion(Result.success(list))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(Result.error(RealmErrors.realmCannotSaveError))
                }
            }
        }
    }
    
    func addProblemSetProblems(
        _ problems: ProblemSetProblems,
        _ completion: @escaping (Result<ProblemSetProblems>) -> ()) {
        realmQueue.async {
            let realm = try! Realm()
            do {
                try realm.write {
                    let problemsRealm = problems.persistenceObject
                    problemsRealm.realmId = problemsRealm.getRealmId()
                    
                    for problemRealm in problemsRealm.problems {
                        problemRealm.realmId = problemRealm.getRealmId()
                    }
                    for problemStatisticRealm in problemsRealm.problemStatistics {
                        problemStatisticRealm.realmId = problemStatisticRealm.getRealmId()
                    }
                    realm.add(problemsRealm, update: true)
                }
                DispatchQueue.main.async {
                    completion(Result.success(problems))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(Result.error(RealmErrors.realmCannotSaveError))
                }
            }
        }
    }
}

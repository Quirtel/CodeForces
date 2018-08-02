import Foundation
import RealmSwift

final class RealmService {
    private let realm = try! Realm()
    
    func getContestList(withRequestParams: ContestListRequest) -> Result<[Contest]> {
        let realmObjects = realm.objects(ContestRealm.self)
            .filter{ $0.gym == withRequestParams.gym }
        return Result.success(realmObjects.map{ $0.model })
    }
    
    func getProblemSetProblems() -> Result<ProblemSetProblems> {
        if let problems = realm.objects(ProblemSetProblemsRealm.self).first?.model {
            return Result.success(problems)
        } else {
            return Result.error(RealmErrors.realmNotFoundError)
        }
    }
    
    func addContestList(
            _ list: [Contest], withRequestParams: ContestListRequest) -> Result<[Contest]> {
        do {
            try realm.write {
                for contest in list {
                    let contestRealm = contest.persistenceObject
                    contestRealm.gym = withRequestParams.gym
                    realm.add(contestRealm, update: true)
                }
            }
            return Result.success(list)
        } catch {
            return Result.error(RealmErrors.realmCannotSaveError)
        }
    }
    
    func addProblemSetProblems(_ problems: ProblemSetProblems) -> Result<ProblemSetProblems> {
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
            return Result.success(problems)
        } catch {
            return Result.error(RealmErrors.realmCannotSaveError)
        }
    }
}

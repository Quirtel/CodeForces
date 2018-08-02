import Foundation
import RealmSwift

//All models are generated with Sourcery into Generated/Realm/

protocol RealmObject: class {
    associatedtype S: RealmRepresentable
    init(model: S)
    var model: S { get }
}

extension List {
    convenience init(array: [Element]) {
        self.init()
        array.forEach(self.append)
    }
    
    var array: [Element] {
        return self.map {$0}
    }
}

extension List where Element: RealmObject {
    var array: [Element.S] {
        return self.map { $0.model }
    }
}

extension Array where Element: RealmCollectionValue {
    var realmList: List<Element> {
        return List(array: self)
    }
}

extension Array where Element: Hashable {
    var customHash: Int {
        var result = 0
        for varr in self {
            result ^= varr.hashValue
        }
        return result
    }
}

extension List where Element: RealmObject & Hashable {
    var customHash: Int {
        var result = 0
        for varr in (self.array as [Element]) {
            result ^= varr.hashValue
        }
        return result
    }
}


extension Array where Element: RealmRepresentable, Element.PersistingObjectType: RealmCollectionValue, Element.PersistingObjectType.S == Element {
    var realmList: List<Element.PersistingObjectType> {
        let x = self.map { Element.PersistingObjectType.init(model: $0) }
        return List(array: x)
    }
}

protocol RealmRepresentable {
    associatedtype PersistingObjectType: RealmObject
    var persistenceObject: PersistingObjectType { get }
}

extension Array where Element: RealmRepresentable {
    var persistenceArray: [Element.PersistingObjectType] {
        return self.map { $0.persistenceObject }
    }
}

protocol RealmRefined {
    associatedtype PersistableType
    
    var persistableValue: PersistableType { get }
    
    init(persistedValue: PersistableType)
}

extension Int {
    init(_ bool: Bool) {
        self = bool ? 1 : 0
    }
}

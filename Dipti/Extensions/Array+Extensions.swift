import Foundation

extension Array where Element: Equatable {
    
    @discardableResult mutating func remove(object: Element) -> Int? {
        if let index = firstIndex(of: object) {
            self.remove(at: index)
            return index
        }
        return nil
    }
    
    @discardableResult mutating func replace(object: Element, with: Element) -> Bool {
        if let index = self.remove(object: object) {
            self.insert(with, at: index)
            return true
        }
        return false
    }
    
    @discardableResult mutating func remove(where predicate: (Array.Iterator.Element) -> Bool) -> Bool {
        if let index = self.firstIndex(where: { (element) -> Bool in
            return predicate(element)
        }) {
            self.remove(at: index)
            return true
        }
        return false
    }
    
}

public extension Sequence where Element: Equatable {
    var uniqueElements: [Element] {
        return self.reduce(into: []) {
            uniqueElements, element in
            
            if !uniqueElements.contains(element) {
                uniqueElements.append(element)
            }
        }
    }
}


extension Collection {
    
    subscript(optional i: Index) -> Iterator.Element? {
        return self.indices.contains(i) ? self[i] : nil
    }
    
}

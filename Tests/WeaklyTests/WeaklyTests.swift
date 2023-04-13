import XCTest
@testable import Weakly

final class WeaklyTests: XCTestCase {
    class Object {
        var count = 0
    }

    func testWeakObject() throws {
        let object = Object()
        let oldCount = object.count
        let closure = weakly(object) { object in
            object.count += 1
        }

        closure()

        XCTAssertNotEqual(oldCount, object.count)
    }

    func testWeakObjectDeallocated() throws {
        let closure = weakly(Object()) { object in
            XCTFail("The object and closure should be deallocated")
        }

        closure()
    }

    func testWeakObjectReturnOuput() throws {
        let object = Object()
        let oldCount = object.count
        let closure = weakly(object) { object in
            object.count += 1

            return object.count
        }

        let newCount = closure()

        XCTAssertNotEqual(oldCount, newCount)
        XCTAssertEqual(object.count, newCount)
    }
}

import XCTest

import CryptoKit

final class SukaTests: XCTestCase {
    func testExample() throws {
        measure {
            for i in 0... {
                var hash = Insecure.MD5.hash(data: "yzbqklnj\(i)".data(using: .utf8)!).makeIterator()
                if hash.next()! == 0 && hash.next()! == 0 && hash.next()! < 16 {
                    print(i)
                    return
                }
            }
        }
    }
}

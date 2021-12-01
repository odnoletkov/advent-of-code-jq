import CryptoKit
import Foundation

let jobs = 128
DispatchQueue.concurrentPerform(iterations: jobs) { job in
    for i in stride(from: job, to: Int.max, by: jobs) {
        var hash = Insecure.MD5.hash(data: "yzbqklnj\(i)".data(using: .utf8)!).makeIterator()
        if hash.next()! == 0 && hash.next()! == 0 && hash.next()! < 16 {
            print(i)
            exit(0)
        }
    }
}

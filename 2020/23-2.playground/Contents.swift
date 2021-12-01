import Foundation

var input = try! String(contentsOfFile: "23.input")
    .split(separator: "\n").joined()
    .map(String.init).map { Int($0)! }

input += stride(
    from: input.max()! + 1,
    through: 1_000_000,
    by: 1
)

var state = zip(
    [0] + input,
    input + [input[0]]
).reduce(
    into: [0] + input
) { $0[$1.0] = $1.1 }

let min = state.min()!
let range = state.max()! - min + 1

for _ in 0..<10_000_000 {
    var dst = state[0]
    let a = state[dst]
    let b = state[a]
    let c = state[b]

    repeat {
        dst = (dst - 1 - min + range)%range + min
    } while dst == a || dst == b || dst == c

    state[state[0]] = state[c]
    state[0] = state[c]
    state[c] = state[dst]
    state[dst] = a
}

print(state[1] * state[state[1]])

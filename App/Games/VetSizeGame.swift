import SwiftUI

/// A size comparison game.  The child sees two animals and selects the
/// larger one.  This builds an intuitive sense of comparison and early
/// measurement.  The adaptive engine tracks correctness but does not yet
/// change the difficulty.
struct VetSizeGame: View {
    @ObservedObject var engine: AdaptiveEngine
    let onComplete: () -> Void

    // Define animals with relative sizes.  Larger number means larger size.
    private let animals: [(name: String, size: Int)] = [
        ("Elephant", 3),
        ("Dog", 2),
        ("Mouse", 1)
    ]
    @State private var pair: (Int, Int) = (0, 1)
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Which animal is bigger?")
                .font(.title2)
            HStack(spacing: 40) {
                Button(action: { check(index: pair.0) }) {
                    Text(animals[pair.0].name)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.orange.opacity(0.7)))
                        .foregroundColor(.white)
                }
                Button(action: { check(index: pair.1) }) {
                    Text(animals[pair.1].name)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.pink.opacity(0.7)))
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear(perform: randomizePair)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertMessage),
                dismissButton: .default(Text("Next")) {
                    randomizePair()
                    onComplete()
                }
            )
        }
    }

    private func randomizePair() {
        // Pick two distinct animals at random.
        var first = Int.random(in: 0..<animals.count)
        var second = Int.random(in: 0..<animals.count)
        while second == first {
            second = Int.random(in: 0..<animals.count)
        }
        pair = (first, second)
    }

    private func check(index: Int) {
        // Determine which of the two animals is larger.
        let first = animals[pair.0]
        let second = animals[pair.1]
        let correctIndex = first.size >= second.size ? pair.0 : pair.1
        if index == correctIndex {
            alertMessage = "Correct!"
            engine.recordAnswer(correct: true)
        } else {
            alertMessage = "Not quite. \(animals[correctIndex].name) is bigger."
            engine.recordAnswer(correct: false)
        }
        showAlert = true
    }
}

struct VetSizeGame_Previews: PreviewProvider {
    static var previews: some View {
        VetSizeGame(engine: AdaptiveEngine(), onComplete: {})
    }
}

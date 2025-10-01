import SwiftUI

/// A classification game for budding veterinarians.  The child is shown a
/// random animal and asked to pick its habitat from three choices.  The
/// adaptive engine tracks performance but does not currently adjust the
/// difficulty of this game.  Additional animals and habitats can be added
/// easily.
struct VetMatchGame: View {
    @ObservedObject var engine: AdaptiveEngine
    let onComplete: () -> Void

    // Define a small set of animals with their correct habitats.
    private let animals: [(name: String, habitat: String, options: [String])] = [
        ("Cat", "House", ["House", "Water", "Sky"]),
        ("Fish", "Water", ["House", "Water", "Sky"]),
        ("Bird", "Sky", ["House", "Water", "Sky"])
    ]
    @State private var current = Int.random(in: 0..<3)
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Where does the \(animals[current].name) live?")
                .font(.title2)
            HStack(spacing: 30) {
                ForEach(animals[current].options, id: \ .self) { option in
                    Button(action: { check(option) }) {
                        Text(option)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.teal.opacity(0.6)))
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertMessage),
                dismissButton: .default(Text("Next")) {
                    // Randomize new animal and advance
                    current = Int.random(in: 0..<animals.count)
                    onComplete()
                }
            )
        }
    }

    private func check(_ selection: String) {
        let correct = animals[current].habitat
        if selection == correct {
            alertMessage = "Yes!"
            engine.recordAnswer(correct: true)
        } else {
            alertMessage = "No, the \(animals[current].name) lives in the \(correct.lowercased())."
            engine.recordAnswer(correct: false)
        }
        showAlert = true
    }
}

struct VetMatchGame_Previews: PreviewProvider {
    static var previews: some View {
        VetMatchGame(engine: AdaptiveEngine(), onComplete: {})
    }
}

import SwiftUI

/// A counting game that asks the child to count cartoon germs on a bandage and
/// select the correct numeral.  The number of germs scales with the
/// adaptive engine’s level, increasing difficulty over time.  Correct
/// answers increment the adaptive engine; incorrect answers reduce
/// accuracy.
struct DoctorCountingGame: View {
    @ObservedObject var engine: AdaptiveEngine
    let onComplete: () -> Void

    // Generate a target count based on the engine level.  Higher levels
    // produce larger counts up to 9.
    private var target: Int {
        // Start at 1–3 germs on level 0, add up to three more per level.
        min(3 + engine.level * 2, 9)
    }

    // Shuffle the answer options.  The correct answer is included along
    // with two neighbouring numbers.
    private var options: [Int] {
        let correct = target
        let wrong1 = max(correct - 1, 1)
        let wrong2 = min(correct + 1, 9)
        return [correct, wrong1, wrong2].shuffled()
    }

    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("How many germs do you see?")
                .font(.title2)
            // Display the germs as small circles on a bandage
            VStack {
                // bandage background
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 220, height: 80)
                    .overlay(
                        HStack(spacing: 8) {
                            ForEach(0..<target, id: \ .self) { _ in
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 20, height: 20)
                            }
                        }
                    )
            }
            .padding(.bottom, 30)
            // Answer buttons
            HStack(spacing: 40) {
                ForEach(options, id: \ .self) { option in
                    Button(action: { checkAnswer(option) }) {
                        Text("\(option)")
                            .font(.title2)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.orange.opacity(0.7)))
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertMessage),
                dismissButton: .default(Text("Next")) {
                    onComplete()
                }
            )
        }
    }

    private func checkAnswer(_ selection: Int) {
        if selection == target {
            alertMessage = "Well done!"
            engine.recordAnswer(correct: true)
        } else {
            alertMessage = "Try again!"
            engine.recordAnswer(correct: false)
        }
        showAlert = true
    }
}

struct DoctorCountingGame_Previews: PreviewProvider {
    static var previews: some View {
        DoctorCountingGame(engine: AdaptiveEngine(), onComplete: {})
    }
}

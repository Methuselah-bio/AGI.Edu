import SwiftUI

/// A simple preposition game: the child sees a cabinet with band‑aids either
/// above or below it and must choose the correct word.  The answer
/// location is randomized each time the view appears.  Positive feedback
/// encourages perseverance【412536993636793†L140-L143】.
struct DoctorBandAidGame: View {
    @ObservedObject var engine: AdaptiveEngine
    let onComplete: () -> Void

    @State private var answerPosition: String = Bool.random() ? "Above" : "Below"
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Where are the band‑aids?")
                .font(.title2)
                .multilineTextAlignment(.center)
            ZStack {
                // Cabinet
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.brown.opacity(0.7))
                    .frame(width: 200, height: 100)
                // Band‑aids represented as small rounded rectangles
                HStack(spacing: 8) {
                    ForEach(0..<3) { _ in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.red)
                            .frame(width: 35, height: 12)
                    }
                }
                .offset(y: answerPosition == "Above" ? -70 : 70)
            }
            .padding(.bottom, 40)
            HStack(spacing: 40) {
                Button(action: { checkAnswer("Above") }) {
                    Text("Above")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.green.opacity(0.7)))
                        .foregroundColor(.white)
                }
                Button(action: { checkAnswer("Below") }) {
                    Text("Below")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue.opacity(0.7)))
                        .foregroundColor(.white)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertMessage),
                dismissButton: .default(Text("Next")) {
                    // On dismissal, move to next game
                    onComplete()
                }
            )
        }
    }

    private func checkAnswer(_ selection: String) {
        if selection == answerPosition {
            alertMessage = "Great job!"
            engine.recordAnswer(correct: true)
        } else {
            alertMessage = "Oops, try again!"
            engine.recordAnswer(correct: false)
        }
        // Randomize the answer for next time
        answerPosition = Bool.random() ? "Above" : "Below"
        showAlert = true
    }
}

struct DoctorBandAidGame_Previews: PreviewProvider {
    static var previews: some View {
        DoctorBandAidGame(engine: AdaptiveEngine(), onComplete: {})
    }
}

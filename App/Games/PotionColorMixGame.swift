import SwiftUI

/// A color mixing game.  The child learns that combining primary colors
/// produces secondary colors.  A pair of primary colors is presented and
/// the child chooses the resulting color from three swatches.  Colours
/// are represented both textually and visually to support comprehension.
struct PotionColorMixGame: View {
    @ObservedObject var engine: AdaptiveEngine
    let onComplete: () -> Void

    private let primaryPairs: [((String, Color), (String, Color), String, Color, [Color])] = [
        // (first color, second color, name of result, result color, distractor colors)
        (("Red", .red), ("Blue", .blue), "Purple", .purple, [.green, .orange]),
        (("Red", .red), ("Yellow", .yellow), "Orange", .orange, [.purple, .green]),
        (("Blue", .blue), ("Yellow", .yellow), "Green", .green, [.purple, .orange])
    ]
    @State private var index: Int = Int.random(in: 0..<3)
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        let pair = primaryPairs[index]
        VStack(spacing: 20) {
            Text("Mix \(pair.0.0) and \(pair.1.0). What color do you get?")
                .font(.title3)
                .multilineTextAlignment(.center)
            HStack(spacing: 20) {
                // Show primary vials
                ColorCircle(color: pair.0.1, label: pair.0.0)
                Text("+").font(.title)
                ColorCircle(color: pair.1.1, label: pair.1.0)
            }
            .padding(.bottom, 30)
            // Options including the correct result and two distractors
            HStack(spacing: 40) {
                ForEach([pair.3] + pair.4, id: \ .self) { optionColor in
                    Button(action: { check(color: optionColor) }) {
                        VStack {
                            Circle().fill(optionColor).frame(width: 50, height: 50)
                            Text(name(for: optionColor))
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.6)))
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertMessage),
                dismissButton: .default(Text("Next")) {
                    // Pick a new pair and continue
                    index = Int.random(in: 0..<primaryPairs.count)
                    onComplete()
                }
            )
        }
    }

    private func check(color: Color) {
        let correctColor = primaryPairs[index].3
        if color == correctColor {
            alertMessage = "Nice work!"
            engine.recordAnswer(correct: true)
        } else {
            let correctName = name(for: correctColor)
            alertMessage = "The correct color is \(correctName)."
            engine.recordAnswer(correct: false)
        }
        showAlert = true
    }

    private func name(for color: Color) -> String {
        switch color {
        case .red: return "Red"
        case .blue: return "Blue"
        case .yellow: return "Yellow"
        case .purple: return "Purple"
        case .green: return "Green"
        case .orange: return "Orange"
        default: return "?"
        }
    }
}

/// A helper view that displays a color swatch with a label underneath.
private struct ColorCircle: View {
    let color: Color
    let label: String
    var body: some View {
        VStack {
            Circle().fill(color).frame(width: 50, height: 50)
            Text(label)
                .font(.caption)
                .foregroundColor(.primary)
        }
    }
}

struct PotionColorMixGame_Previews: PreviewProvider {
    static var previews: some View {
        PotionColorMixGame(engine: AdaptiveEngine(), onComplete: {})
    }
}

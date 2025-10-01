import SwiftUI

/// Container for astronaut‑themed games.  This path currently includes a
/// counting game (fueling the rocket) and a pattern recognition game.
struct AstronautPathView: View {
    @StateObject private var engine = AdaptiveEngine()
    @State private var currentIndex = 0

    @ViewBuilder
    private func currentGame() -> some View {
        switch currentIndex {
        case 0:
            AstronautCountGame(engine: engine, onComplete: advance)
        case 1:
            AstronautPatternGame(engine: engine, onComplete: advance)
        default:
            AstronautCountGame(engine: engine, onComplete: advance)
        }
    }

    var body: some View {
        VStack {
            Text("Astronaut Path").font(.largeTitle).padding(.top)
            Spacer()
            currentGame()
            Spacer()
        }
        .padding()
    }

    private func advance() {
        currentIndex = (currentIndex + 1) % 2
    }
}

struct AstronautPathView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautPathView()
    }
}

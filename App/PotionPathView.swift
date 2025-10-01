import SwiftUI

/// Container for potions master‑themed games.  Includes color mixing and
/// shape sorting activities.  Uses the adaptive engine to track progress.
struct PotionPathView: View {
    @StateObject private var engine = AdaptiveEngine()
    @State private var currentIndex = 0

    @ViewBuilder
    private func currentGame() -> some View {
        switch currentIndex {
        case 0:
            PotionColorMixGame(engine: engine, onComplete: advance)
        case 1:
            PotionShapeSortGame(engine: engine, onComplete: advance)
        default:
            PotionColorMixGame(engine: engine, onComplete: advance)
        }
    }

    var body: some View {
        VStack {
            Text("Potions Path").font(.largeTitle).padding(.top)
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

struct PotionPathView_Previews: PreviewProvider {
    static var previews: some View {
        PotionPathView()
    }
}

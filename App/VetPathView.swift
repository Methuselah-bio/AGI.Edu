import SwiftUI

/// Container for veterinarian themed games.  Uses an adaptive engine to
/// persist progress across multiple games.  This prototype includes
/// matching and size comparison games.
struct VetPathView: View {
    @StateObject private var engine = AdaptiveEngine()
    @State private var currentIndex = 0

    @ViewBuilder
    private func currentGame() -> some View {
        switch currentIndex {
        case 0:
            VetMatchGame(engine: engine, onComplete: advance)
        case 1:
            VetSizeGame(engine: engine, onComplete: advance)
        default:
            VetMatchGame(engine: engine, onComplete: advance)
        }
    }

    var body: some View {
        VStack {
            Text("Vet Path").font(.largeTitle).padding(.top)
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

struct VetPathView_Previews: PreviewProvider {
    static var previews: some View {
        VetPathView()
    }
}

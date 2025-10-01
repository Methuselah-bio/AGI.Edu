import SwiftUI

/// A container view for all doctor themed games.  It maintains an
/// `AdaptiveEngine` to track performance across games and decides which
/// game to show next.  When the child completes a game, the closure
/// `advance()` selects the next appropriate game.
struct DoctorPathView: View {
    @StateObject private var engine = AdaptiveEngine()
    @State private var currentIndex = 0
    /// The total number of games available in this path.  When adding
    /// additional games, update this constant so that the `advance()`
    /// function wraps correctly.
    private let totalGames = 2

    /// Returns the appropriate game view for the current index.  A `switch`
    /// statement is used here instead of an array of closures so that the
    /// closure `advance` can be captured safely.
    @ViewBuilder
    private func currentGame() -> some View {
        switch currentIndex {
        case 0:
            DoctorBandAidGame(engine: engine, onComplete: advance)
        case 1:
            DoctorCountingGame(engine: engine, onComplete: advance)
        default:
            DoctorBandAidGame(engine: engine, onComplete: advance)
        }
    }

    var body: some View {
        VStack {
            Text("Doctor Path").font(.largeTitle).padding(.top)
            Spacer()
            currentGame()
            Spacer()
        }
        .padding()
    }

    /// Advances to the next game in the doctor path, looping back to the start
    /// when the end is reached.  This demonstrates how the adaptive engine
    /// persists across games.
    private func advance() {
        currentIndex = (currentIndex + 1) % totalGames
    }
}

struct DoctorPathView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorPathView()
    }
}

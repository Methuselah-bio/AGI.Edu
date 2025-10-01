import Foundation

/// A simple adaptive engine that raises or lowers the difficulty level based
/// on the child’s performance.  When accuracy over the last five answers
/// exceeds 80 %, the level increases; if accuracy falls below 50 % and the
/// level is greater than zero, the level decreases.  Game views observe
/// the engine and choose content appropriate for the current level.
final class AdaptiveEngine: ObservableObject {
    /// Nested type to track performance statistics.
    struct Statistic {
        var correct: Int = 0
        var incorrect: Int = 0
        var total: Int { correct + incorrect }
        var accuracy: Double { total > 0 ? Double(correct) / Double(total) : 0 }
    }

    /// Published level that views can observe to adjust difficulty.
    @Published var level: Int = 0
    /// Private stats used to compute accuracy over a rolling window.
    @Published private(set) var stats = Statistic()

    /// Call this method whenever a child answers a question.  The engine
    /// updates its statistics and, if appropriate, increases or decreases
    /// the level.  After a level change, statistics reset so that each
    /// level is measured independently.
    func recordAnswer(correct: Bool) {
        if correct {
            stats.correct += 1
        } else {
            stats.incorrect += 1
        }
        adjustLevelIfNeeded()
    }

    /// Resets the tracking statistics.  This is useful when switching
    /// between games or after a level change.
    func reset() {
        stats = Statistic()
    }

    private func adjustLevelIfNeeded() {
        // Only adjust levels after at least five answers.
        guard stats.total >= 5 else { return }
        let acc = stats.accuracy
        if acc > 0.8 {
            level += 1
            reset()
        } else if acc < 0.5 && level > 0 {
            level -= 1
            reset()
        }
    }
}

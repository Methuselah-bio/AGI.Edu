import SwiftUI

/// Root view that decides which screen to display.  In a full app this would
/// present a login or parental gateway before showing the home screen.  For
/// the prototype we assume the child is already authenticated and show the
/// home screen directly.
struct ContentView: View {
    var body: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

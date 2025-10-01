import SwiftUI

/// Displays the four career path icons on a soft background.  Tapping any
/// button navigates to the corresponding themed path view.  The background
/// image is optional; if `home_background` isn’t found, a solid color is
/// used instead.
struct HomeView: View {
    var body: some View {
        ZStack {
            // Use the watercolor background if it exists in Assets.
            if let _ = UIImage(named: "home_background") {
                Image("home_background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            } else {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            }

            VStack(spacing: 60) {
                HStack(spacing: 60) {
                    NavigationLink(destination: DoctorPathView()) {
                        CareerButton(imageName: "cross", title: "Doctor")
                    }
                    NavigationLink(destination: VetPathView()) {
                        CareerButton(imageName: "paw", title: "Vet")
                    }
                }
                HStack(spacing: 60) {
                    NavigationLink(destination: PotionPathView()) {
                        CareerButton(imageName: "potion", title: "Potions")
                    }
                    NavigationLink(destination: AstronautPathView()) {
                        CareerButton(imageName: "rocket", title: "Astronaut")
                    }
                }
            }
        }
    }
}

/// A stylized button that displays an icon inside a circular background and
/// a label underneath.  The button appearance is inspired by watercolor
/// illustrations and is kept simple for young children.
struct CareerButton: View {
    let imageName: String
    let title: String
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .padding()
                .background(Circle().fill(Color.white.opacity(0.5)))
                .clipShape(Circle())
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

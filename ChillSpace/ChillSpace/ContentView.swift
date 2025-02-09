import SwiftUI

struct ContentView: View {
    @StateObject private var authManager = SpotifyAuthManager()
    
    var body: some View {
        VStack {
            if authManager.accessToken == nil {
                Button("Login to Spotify") {
                    authManager.authenticate()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
            } else {
                Text("Logged in! Choose your mode:")
                    .font(.title)

                HStack {
                    ModeButton(title: "Chill", action: { print("Chill Mode") })
                    ModeButton(title: "Focus", action: { print("Focus Mode") })
                    ModeButton(title: "Sleep", action: { print("Sleep Mode") })
                }
            }
        }
        .padding()
        .onAppear {
            authManager.loadAccessToken()
        }
    }
}


struct ModeButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .frame(height: 50)
    }
}

import Foundation
import WebKit

class SpotifyAuthManager: ObservableObject {
    let clientID = "487c14a6dc194c0a9f8c1a6b909d5585"
    let redirectURI = "chillspace://callback"
    let authURL = "https://accounts.spotify.com/authorize"
    @Published var accessToken: String?

    func authenticate() {
        let url = "\(authURL)?client_id=\(clientID)&response_type=token&redirect_uri=\(redirectURI)&scope=streaming,user-read-playback-state,user-modify-playback-state"

        if let authURL = URL(string: url) {
            DispatchQueue.main.async {
                NSWorkspace.shared.open(authURL)
            }
        }
    }

    func handleCallback(url: URL) {
        if let fragment = url.fragment {
            let params = fragment.components(separatedBy: "&")
            for param in params {
                let keyValue = param.components(separatedBy: "=")
                if keyValue.count == 2, keyValue[0] == "access_token" {
                    DispatchQueue.main.async {
                        self.accessToken = keyValue[1]
                        UserDefaults.standard.set(self.accessToken, forKey: "spotifyAccessToken")
                    }
                }
            }
        }
    }

    func loadAccessToken() {
        if let token = UserDefaults.standard.string(forKey: "spotifyAccessToken") {
            self.accessToken = token
        }
    }
}

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    func application(_ app: NSApplication, open urls: [URL]) {
        if let url = urls.first, url.absoluteString.starts(with: "chillspace://callback") {
            SpotifyAuthManager().handleCallback(url: url)
        }
    }
}




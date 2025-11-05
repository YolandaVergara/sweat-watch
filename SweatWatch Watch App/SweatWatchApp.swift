import SwiftUI

@main
struct SweatWatch_Watch_AppApp: App {
    @StateObject private var watchManager = WatchConnectivityManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(watchManager)
        }
    }
}

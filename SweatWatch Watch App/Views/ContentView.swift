import SwiftUI

struct ContentView: View {
    @EnvironmentObject var watchManager: WatchConnectivityManager
    @State private var showMockData = true // Set to false when Watch Connectivity works
    
    var body: some View {
        NavigationView {
            VStack {
                if showMockData {
                    // TEMPORARY: Mock workout for UI testing
                    WorkoutView(workout: mockWorkout)
                } else if let workout = watchManager.currentWorkout {
                    // Real workout from iPhone
                    WorkoutView(workout: workout)
                } else {
                    // No workout available
                    VStack(spacing: 16) {
                        if !watchManager.isReachable {
                            Image(systemName: "iphone.slash")
                                .font(.title)
                                .foregroundColor(.yellow)
                            Text("iPhone not connected")
                                .font(.caption)
                        }
                        
                        Image(systemName: "dumbbell")
                            .font(.system(size: 50))
                            .foregroundColor(Color(hex: "#b5ffe9"))
                        
                        Text("No Active Workout")
                            .font(.headline)
                        
                        Text("Start a workout from your phone")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                }
            }
            .navigationTitle("Sweat & Shine")
        }
    }
    
    // MARK: - Mock Data for Testing
    private var mockWorkout: WorkoutSession {
        WorkoutSession(
            date: Date(),
            exercises: [
                ExerciseWithData(
                    id: "1",
                    name: "Press de Banca",
                    target: "pectorales",
                    gifUrl: "https://example.com/gif1.gif",
                    exerciseId: "ex1",
                    seriesData: [
                        SeriesData(id: "s1", reps: 10, weight: 60.0, completed: false),
                        SeriesData(id: "s2", reps: 10, weight: 60.0, completed: false),
                        SeriesData(id: "s3", reps: 8, weight: 65.0, completed: false),
                        SeriesData(id: "s4", reps: 8, weight: 65.0, completed: false)
                    ]
                ),
                ExerciseWithData(
                    id: "2",
                    name: "Sentadilla",
                    target: "cuádriceps",
                    gifUrl: "https://example.com/gif2.gif",
                    exerciseId: "ex2",
                    seriesData: [
                        SeriesData(id: "s5", reps: 12, weight: 80.0, completed: false),
                        SeriesData(id: "s6", reps: 12, weight: 80.0, completed: false),
                        SeriesData(id: "s7", reps: 10, weight: 85.0, completed: false)
                    ]
                ),
                ExerciseWithData(
                    id: "3",
                    name: "Peso Muerto",
                    target: "espalda baja",
                    gifUrl: "https://example.com/gif3.gif",
                    exerciseId: "ex3",
                    seriesData: [
                        SeriesData(id: "s8", reps: 8, weight: 100.0, completed: false),
                        SeriesData(id: "s9", reps: 8, weight: 100.0, completed: false),
                        SeriesData(id: "s10", reps: 6, weight: 110.0, completed: false)
                    ]
                )
            ],
            totalSeries: 10,
            totalVolume: 0,
            duration: 0,
            completed: false
        )
    }
}

// MARK: - Color Extension for Hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

import SwiftUI

struct ExerciseDetailView: View {
    let exercise: ExerciseWithData
    let exerciseIndex: Int
    @EnvironmentObject var watchManager: WatchConnectivityManager
    @State private var showingRestTimer = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                // Exercise name
                Text(exercise.name)
                    .font(.headline)
                    .foregroundColor(Color(hex: "#444545"))
                
                // Target muscle
                HStack {
                    Image(systemName: "figure.arms.open")
                        .foregroundColor(Color(hex: "#ceabb1"))
                    Text(exercise.target.capitalized)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Divider()
                
                // Series list
                VStack(spacing: 8) {
                    ForEach(Array(exercise.seriesData.enumerated()), id: \.element.id) { index, series in
                        SeriesRow(
                            series: series,
                            seriesNumber: index + 1,
                            onToggle: {
                                toggleSeries(seriesIndex: index)
                            }
                        )
                    }
                }
                
                // Rest timer button
                Button(action: { showingRestTimer = true }) {
                    HStack {
                        Image(systemName: "timer")
                        Text("Rest Timer")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(hex: "#b5ffe9"))
            }
            .padding(.vertical, 8)
        }
        .sheet(isPresented: $showingRestTimer) {
            RestTimerView()
        }
    }
    
    private func toggleSeries(seriesIndex: Int) {
        let currentStatus = exercise.seriesData[seriesIndex].completed
        watchManager.updateSeries(
            exerciseIndex: exerciseIndex,
            seriesIndex: seriesIndex,
            completed: !currentStatus
        )
    }
}

// MARK: - Series Row Component
struct SeriesRow: View {
    let series: SeriesData
    let seriesNumber: Int
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            // Checkbox
            Button(action: onToggle) {
                Image(systemName: series.completed ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(series.completed ? Color(hex: "#b5ffe9") : .gray)
                    .font(.title3)
            }
            .buttonStyle(.plain)
            
            // Series info
            VStack(alignment: .leading, spacing: 2) {
                Text("Series \(seriesNumber)")
                    .font(.caption)
                    .bold()
                
                HStack(spacing: 12) {
                    if let weight = series.weight {
                        HStack(spacing: 4) {
                            Image(systemName: "scalemass")
                                .font(.caption2)
                            Text("\(String(format: "%.1f", weight))kg")
                                .font(.caption)
                        }
                    }
                    
                    if let reps = series.reps {
                        HStack(spacing: 4) {
                            Image(systemName: "repeat")
                                .font(.caption2)
                            Text("\(reps) reps")
                                .font(.caption)
                        }
                    }
                }
                .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(series.completed ? Color(hex: "#b5ffe9").opacity(0.1) : Color.gray.opacity(0.05))
        )
    }
}

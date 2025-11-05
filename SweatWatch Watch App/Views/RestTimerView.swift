import SwiftUI
import WatchKit

struct RestTimerView: View {
    @Environment(\.dismiss) var dismiss
    @State private var timeRemaining = 90 // Default 90 seconds
    @State private var isRunning = false
    @State private var timer: Timer?
    
    var progress: Double {
        Double(timeRemaining) / 90.0
    }
    
    var body: some View {
        VStack {
            // Timer display
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color(hex: "#b5ffe9"), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1), value: progress)
                
                VStack {
                    Text(timeString)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(Color(hex: "#444545"))
                    
                    Text("seconds")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            // Controls
            HStack(spacing: 20) {
                // Play/Pause button
                Button(action: toggleTimer) {
                    Image(systemName: isRunning ? "pause.fill" : "play.fill")
                        .font(.title2)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(hex: "#b5ffe9"))
                
                // Reset button
                Button(action: resetTimer) {
                    Image(systemName: "arrow.clockwise")
                        .font(.title3)
                }
                .buttonStyle(.bordered)
            }
            
            // Close button
            Button("Done") {
                stopTimer()
                dismiss()
            }
            .buttonStyle(.bordered)
            .tint(.gray)
        }
        .padding()
        .onDisappear {
            stopTimer()
        }
    }
    
    var timeString: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func toggleTimer() {
        if isRunning {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    private func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                // Timer finished - play haptic feedback
                WKInterfaceDevice.current().play(.success)
                stopTimer()
            }
        }
    }
    
    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    private func resetTimer() {
        stopTimer()
        timeRemaining = 90
    }
}

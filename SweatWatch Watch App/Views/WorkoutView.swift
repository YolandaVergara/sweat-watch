import SwiftUI

struct WorkoutView: View {
    let workout: WorkoutSession
    @State private var currentExerciseIndex = 0
    
    var currentExercise: ExerciseWithData {
        workout.exercises[currentExerciseIndex]
    }
    
    var totalExercises: Int {
        workout.exercises.count
    }
    
    var body: some View {
        VStack(spacing: 12) {
            // Progress indicator
            HStack {
                Text("\(currentExerciseIndex + 1) / \(totalExercises)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 4)
                        
                        Rectangle()
                            .fill(Color(hex: "#b5ffe9"))
                            .frame(width: geometry.size.width * CGFloat(currentExerciseIndex + 1) / CGFloat(totalExercises), height: 4)
                    }
                }
                .frame(height: 4)
            }
            
            // Exercise details
            ExerciseDetailView(
                exercise: currentExercise,
                exerciseIndex: currentExerciseIndex
            )
            
            // Navigation buttons
            HStack(spacing: 16) {
                Button(action: previousExercise) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                }
                .disabled(currentExerciseIndex == 0)
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button(action: nextExercise) {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                }
                .disabled(currentExerciseIndex == totalExercises - 1)
                .buttonStyle(.bordered)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
    }
    
    private func previousExercise() {
        if currentExerciseIndex > 0 {
            currentExerciseIndex -= 1
        }
    }
    
    private func nextExercise() {
        if currentExerciseIndex < totalExercises - 1 {
            currentExerciseIndex += 1
        }
    }
}

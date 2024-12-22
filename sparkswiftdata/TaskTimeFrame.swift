import SwiftUI
import AVFoundation

struct TaskTimeFrame: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var progress: CGFloat = 1
    @State private var remainingTime: TimeInterval = 0
    @State private var taskTimer: Timer? = nil
    @State private var showAlert = false

    var duration: TimeInterval // Accept duration from TaskView
    var name: String           // Accept task name dynamically
    var task: Task
    
    var body: some View {
        VStack {
            Text(name) // Display the task name dynamically
                .font(.title)
                .font(.system(size: 50, weight: .medium, design: .default))
                .foregroundColor(.primary)
                .padding(.bottom, 5)

            Text(formatTime(remainingTime))
                .font(.system(size: 50, weight: .ultraLight))
                .foregroundColor(.primary.opacity(0.94))
                .padding(.bottom, 60)

            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(.our) // Replace with your color
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.our) // Replace with your color
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: progress)

                Image("spark_time_frame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 227.06, height: 110.76)
            }
            .frame(width: 330, height: 330)
            .padding(.bottom, 100)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            startTimer(duration: duration) // Start the timer when the view appears
        }
        .onChange(of: remainingTime) { newValue in
            if newValue <= 0 {
                playAlertSound() // Play sound when time is up
                showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Time is up!"),
                message: Text("Tip: turn on back tap, so that you check the task off with ease!"),
                primaryButton: .default(Text("Done")
                    .accessibilityLabel("Done Button")) {
                    deleteTask()
                },
                secondaryButton: .default(Text("Add 15 min")
                    .accessibilityLabel("Reset Timer to 15 Minutes")) {
                    resetTimerToFifteenMinutes() // Reset timer to 15 minutes
                }
            )
        }
        .accessibilityAction(named: Text("Add Fifteen Minutes")) {
            resetTimerToFifteenMinutes() // Reset timer to 15 minutes
        }
    }

    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func startTimer(duration: TimeInterval) {
        remainingTime = duration
        progress = 1.0
        taskTimer?.invalidate()
        taskTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
                progress = CGFloat(remainingTime / duration)
            } else {
                taskTimer?.invalidate()
            }
        }
    }

    func resetTimerToFifteenMinutes() {
        remainingTime = 15 * 60 // Reset to 15 minutes
        progress = 1.0
        startTimer(duration: remainingTime) // Restart the timer with the new duration
    }

    func deleteTask() {
        context.delete(task) // Delete task using SwiftData context
        try? context.save()   // Save the changes
        dismiss()             // Close the view
    }

    func playAlertSound() {
        let soundID: SystemSoundID = 1005 // Example built-in sound ID (Ping)
        AudioServicesPlaySystemSound(soundID)
    }
}

#Preview {
    NavigationStack {
        TaskTimeFrame(
            duration: 10,
            name: "Example Task",
            task: Task(name: "Example Task", duration: "15 min", priority: "⚡️ High", isChecked: false)
        )
    }
}

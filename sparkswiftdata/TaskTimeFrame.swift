import SwiftUI

struct TaskTimeFrame: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var progress: CGFloat = 1
    @State private var remainingTime: TimeInterval = 0
    @State private var taskTimer: Timer? = nil
    @State private var showAlert = false
    
    var duration: TimeInterval // Accept duration from TaskView
    var name: String       // Accept task name dynamically
    var task: Task
    
    var body: some View {
        VStack {
            Text(name) // Display the task name dynamically
                .font(.title) // Automatically scales
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
                    .foregroundColor(.our)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.our)
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
                        .foregroundColor(.our)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            startTimer(duration: duration) // Start the timer when the view appears
        }
        .onChange(of: remainingTime) { newValue in
            if newValue <= 0 {
                showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Time is up!"),
                message: Text("Tip: turn on back tap, so that you check the task off with ease!"),
                primaryButton: .default(Text("Done")
                    .accessibilityLabel("Done Button") // Voice Control-friendly
                ) {
                    deleteTask()
                    print("Task Completed") // Done button logic
                },
                secondaryButton: .default(
                    Text("+ 15 min")
                        .accessibilityLabel("Add 15 Minutes")
                ) {
                    remainingTime += 900 // Adds 15 minutes
                }
            )
        }

        .accessibilityAction(named: Text("Add Fifteen Minutes")) {
            remainingTime += 900 // Adds 15 minutes
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
    func deleteTask() {
            context.delete(task) // Delete task using SwiftData context
            try? context.save()  // Save the changes
            dismiss()            // Close the view
        }
}

#Preview {
//    NavigationStack {
//        TaskTimeFrame(duration: 900, name: "Example Task") // Pass task name here
//    }
    NavigationStack {
            TaskTimeFrame(
                duration: 900,
                name: "Example Task",
                task: Task(name: "Example Task", duration: "15 min", priority: "⚡️ High", isChecked: false)
            ) // Pass task object here
        }
}

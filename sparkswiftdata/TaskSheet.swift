//import SwiftUI
//import SwiftData
//
//struct TaskSheet: View {
//    @Environment(\.modelContext) var modelContext
////    @Binding var tasks: [Task]
//    @State private var duration: String = "15 min"
//    @State private var date: String = "today"
//    @State private var priority: String = "⚡️High"
//    @State private var taskName: String = ""
//    @Environment(\.presentationMode) var presentationMode // For dismissing the view
//
//    @Query var tasks: [Task]
//    
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("")) {
//                    HStack {
//                        Text("Task Name")
//                            .accessibilityLabel("Task Name Label")
//                            .accessibilityHint("Speak the task name to add")
//                        Divider().frame(width: 2, height: 30)
//                        
//                        TextField("shower", text: $taskName)
//                            .autocapitalization(.words)
//                        
//                            .submitLabel(.done) // Sets the keyboard return button to "Done"
//                                .onSubmit {
//                                    // Dismiss the keyboard when "Done" is tapped
//                                    hideKeyboard()
//                                }
//                        
//                        
//                            .accessibilityLabel("Task Name Input")
//                            .accessibilityHint("Double-tap and speak to input task name")
//                            
//                    }
//                }
//
//                    HStack {
//                        Image(systemName: "clock")
//                        Picker("Duration", selection: $duration) {
//                            Text("1 min").tag("1 min")
//                            Text("15 min").tag("15 min")
//                            Text("25 min").tag("25 min")
//                            Text("30 min").tag("30 min")
//                            Text("45 min").tag("45 min")
//                            Text("60 min").tag("60 min")
//                        }
//                        .accessibilityLabel("Task Duration Picker")
//                        .accessibilityHint("Speak the duration value to select it")
//                    }
//
//                    HStack {
//                        Image(systemName: "calendar")
//                        Picker("Date", selection: $date) {
//                            Text("today").tag("today")
//                            Text("tomorrow").tag("tomorrow")
//                        }
//                        .accessibilityLabel("Task Date Picker")
//                        .accessibilityHint("Speak today or tomorrow to set the date")
//                                        
//                    }
//
//                    HStack {
//                        Image(systemName: "flag")
//                        Picker("Priority", selection: $priority) {
//                            Text("⚡️ High").tag("High")
//                            Text("💫 Mid").tag("💫 Mid")
//                            Text("🌙 Low").tag("🌙 Low")
//                        }
//                        .accessibilityLabel("Task Priority Picker")
//                        .accessibilityHint("Speak high, mid, or low to set the priority")
//                    }
//                
//            }
//            .navigationBarTitle("Add Task", displayMode: .inline)
//            .navigationBarItems(leading: cancelButton, trailing: saveButton)
//            .accessibilityLabel("Task Sheet Form")
//        }
//    }
//
//    private var cancelButton: some View {
//        Button("Cancel") {
//            presentationMode.wrappedValue.dismiss() // Dismiss the view
//        }
//        .accessibilityLabel("Cancel Button")
//        .accessibilityHint("Tap to cancel task creation")
//    }
//
//    private var saveButton: some View {
//        Button("Save") {
//            guard !taskName.isEmpty else { return } // Ensure task name is not empty
//            let newTask = Task(name: taskName, duration: duration, priority: priority, isChecked: false)
//            modelContext.insert(newTask)
////            tasks.append(newTask) // Add new task to the list
//            print("Saved: \(taskName), Duration: \(duration), Priority: \(priority)")
//            presentationMode.wrappedValue.dismiss() // Dismiss the view after saving
//        }
//        .disabled(taskName.isEmpty) // Disable if task name is empty
//        .accessibilityLabel("Save Button")
//        .accessibilityHint("Tap to save the task if task name is provided")
//    }
//}
//
//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
import SwiftUI
import SwiftData

struct TaskSheet: View {
    @Query var tasks: [Task]
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode // For dismissing the view

    @State private var duration: String = "15 min"
    @State private var date: String = "today"
    @State private var priority: String = "⚡️ High"
    @State private var taskName: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Task Name")
                        Divider().frame(width: 2, height: 30)
                        TextField("Task Name", text: $taskName)
                            .autocapitalization(.words)
                            .submitLabel(.done)
                            .onSubmit { hideKeyboard() }
                    }
                }

                HStack {
                    Image(systemName: "clock")
                    Picker("Duration", selection: $duration) {
                        Text("1 min").tag("1 min")
                        Text("15 min").tag("15 min")
                        Text("30 min").tag("30 min")
                        Text("60 min").tag("60 min")
                    }
                }

                HStack {
                    Image(systemName: "calendar")
                    Picker("Date", selection: $date) {
                        Text("Today").tag("today")
                        Text("Tomorrow").tag("tomorrow")
                    }
                }

                HStack {
                    Image(systemName: "flag")
                    Picker("Priority", selection: $priority) {
                        Text("⚡️ High").tag("⚡️ High")
                        Text("💫 Mid").tag("💫 Mid")
                        Text("🌙 Low").tag("🌙 Low")
                    }
                }
            }
            .navigationBarTitle("Add Task", displayMode: .inline)
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
    }

    private var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }

    private var saveButton: some View {
        Button("Save") {
            guard !taskName.isEmpty else { return }
//            let newTask = Task(name: taskName, duration: duration, priority: priority, isChecked: false)
//            modelContext.insert(newTask) // Save task to SwiftData
            let newTask = Task(name: taskName, duration: duration, priority: priority, isChecked: false)
            print("Tasks fetched: \(tasks.count)")
                    modelContext.insert(newTask) // Correct insertion into SwiftData
            presentationMode.wrappedValue.dismiss()
        }
        .disabled(taskName.isEmpty)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

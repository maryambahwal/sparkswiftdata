//import SwiftUI
//import SwiftData
//
//
//// TaskList
//struct TaskList: View {
//    @Environment(\.modelContext) var modelContext
//    @Query var tasks: [Task]
//    @State private var showAddTask = false // State to show the add task sheet
//
//    var body: some View {
//        NavigationView {
//            GeometryReader { geometry in
//                VStack {
//                    // Display list of tasks
//                    List {
//                        ForEach(tasks) { task in
//                            TaskView(toggleAction: {
//                                if let index = tasks.firstIndex(where: { $0.id == task.id }) {
//                                    tasks[index].isChecked.toggle()
//                                }
//                            })
//                        }
//                        .onDelete(perform: deleteItems)
//                    }
//                    .listStyle(PlainListStyle())
//                    
//                    HStack{
//                        Text("Complete your tasks, and watch me unleash my superpowers—just like you!")
//                            .bold()
//                            .frame(width: 255)
//                            .padding(.leading, 5)
//                        Image("sittingSpark")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: geometry.size.height / 7)
//                    }
//                }
//            }
//            .navigationBarTitle("My Tasks")
//            .navigationBarItems(trailing: addButton) // Add button in the navigation bar
//            .sheet(isPresented: $showAddTask) {
//                TaskSheet() // Pass the binding to add new tasks
//            }
//        }
//    }
//
//    private var addButton: some View {
//        Button(action: {
//            showAddTask.toggle()
//        }) {
//            Image(systemName: "plus")
//                .foregroundColor(.our)
//        }
//    }
//
//    private func deleteItems(at offsets: IndexSet) {
////        tasks.remove(atOffsets: offsets)
////        tasks.remove(atOffsets: offsets)
//    }
//}
import SwiftUI
import SwiftData

// TaskList
struct TaskList: View {
    @Environment(\.modelContext) var modelContext
    @Query var tasks: [Task]  // Automatically fetches updated tasks
    @State private var showAddTask = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tasks) { task in
                        TaskView(task: task, toggleAction: {
                            task.isChecked.toggle()
                            try? modelContext.save()
                        })
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(PlainListStyle())
                
                // Footer UI
                footerView
            }
            .navigationBarTitle("My Tasks")
            .navigationBarItems(trailing: addButton)
            .sheet(isPresented: $showAddTask) {
                TaskSheet() // Shows add task sheet
            }
        }
    }

    private var addButton: some View {
        Button(action: {
            showAddTask.toggle()
        }) {
            Image(systemName: "plus")
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(tasks[index])
        }
        try? modelContext.save()  // Save after deletion
    }

    private var footerView: some View {
        HStack {
            Text("Complete your tasks, and watch me unleash my superpowers—just like you!")
                .bold()
                .frame(width: 255)
                .padding(.leading, 5)
            Image("sittingSpark")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
        }
    }
}

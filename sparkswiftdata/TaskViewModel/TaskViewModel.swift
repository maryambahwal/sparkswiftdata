////
////  TaskViewModel.swift
////  sparkswiftdata
////
////  Created by Maryam Bahwal on 16/06/1446 AH.
////
//import SwiftUI
//import SwiftData
//
//class TaskViewModel: ObservableObject {
//    @Published var tasks: [Task] = []
//    private var context: ModelContext
//
//   
//    init(context: ModelContext) {
//        self.context = context
//        fetchTasks()
//    }
//
//    func fetchTasks() {
//        do {
//            tasks = try context.fetch(FetchDescriptor<Task>())
//        } catch {
//            print("Error fetching tasks: \(error)")
//        }
//    }
//
//    func addTask(name: String, duration: Int, priority: String) {
//        let newTask = Task(name: name, duration: duration, priority: priority, isCompleted: false)
//        context.insert(newTask) // Add to SwiftData context
//        tasks.append(newTask)   // Update local tasks array
//    }
//
////    func toggleTaskCompletion(task: Task) {
////        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
////            tasks[index].isCompleted.toggle()
////        }
////        saveContext()
////    }
//    func toggleTaskCompletion(task: Task) {
//        task.isCompleted.toggle()
//        saveContext()
//    }
//
//    func deleteTask(at offsets: IndexSet) {
//        for index in offsets {
//            let taskToDelete = tasks[index]
//            context.delete(taskToDelete)
//        }
//        tasks.remove(atOffsets: offsets)
//    }
//
//    private func saveContext() {
//        do {
//            try context.save()
//        } catch {
//            print("Error saving context: \(error)")
//        }
//    }
//}

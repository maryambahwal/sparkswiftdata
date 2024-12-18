//
//  homeView.swift
//  Spark
//
//  Created by ohoud on 15/06/1446 AH.
//

import Foundation
import SwiftUI
import SwiftData
// HomeView
struct HomeView: View {
        @Environment(\.modelContext) private var modelContext
        @Query private var tasks: [Task] // Fetch tasks from SwiftData
    
    var userName: String
    @State private var isTaskSheetPresented: Bool = false

    var body: some View {
        ZStack {
            if tasks.isEmpty {
                // Show original home content when no tasks
                VStack(spacing: 20) {
                    Spacer()
                    
                    Text("Hi \(userName)!")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    Text("Add your today’s tasks to watch me grow!")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    Image("sittingSpark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    Spacer()
                }
            } else {
                TaskList()
                
            }
            
            // Floating Action Button to add tasks - Only show in HomeView
            if tasks.isEmpty {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            isTaskSheetPresented.toggle()
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.our)
                                    .frame(width: 60, height: 60)
                                
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .font(.title)
                            }
                        }
                        .padding(20)
                        .sheet(isPresented: $isTaskSheetPresented) {
                            TaskSheet() // Pass binding to tasks
                        }
                    }
                }
            }
        }
    }
}



struct IntroduceView: View {
    @State private var name: String = ""
    @State private var isNextActive: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Image
            GIFImage(name: "dogGif")
          .frame(width: 200, height: 200)
          .edgesIgnoringSafeArea(.all)
          .offset(x: 0,y: 850)
          .scaleEffect(CGSize(width: 0.06, height: 0.06))
            
            // Text
            Text("Introduce yourself to me")
                .font(.title2)
                .foregroundColor(.primary)
            
            
            // TextField
            TextField("Enter Your Name", text: $name)
                .padding(10)
                .background(.primary.opacity(0.2))
                .foregroundColor(.primary)
                .cornerRadius(8)
                .padding(.horizontal, 20)
            
            // Button
            Button(action: {
                if !name.isEmpty {
                    // Save the name in UserDefaults
                    UserDefaults.standard.set(name, forKey: "UserName")
                    isNextActive = true
                    
                }
            }) {
                Text("Next")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(Color.our)
                    .cornerRadius(10)
                    .padding(.horizontal, 140)
            }
            .disabled(name.isEmpty) // Disable button if name is empty
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
       
        .fullScreenCover(isPresented: $isNextActive) {
            HomeView(userName: name)
        }
    }
}

struct Homepage: View {
    @State private var userName: String? = UserDefaults.standard.string(forKey: "UserName")
    
    var body: some View {
        if let savedName = userName {
            // Go directly to HomeView if name is saved
            HomeView(userName: savedName)
        } else {
            // Show IntroduceView if no name is saved
            IntroduceView()
        }
    }
}

#Preview {
    Homepage()
}


//
//  ContentView.swift
//  SparkOnB
//
//  Created by Ghada Alsubaie on 10/06/1446 AH.
//

import SwiftUI

struct GhadaView: View {
    @State private var progress: CGFloat = 0
    @State private var selectedIndex: Int = 0
    @State private var isSkipPressed = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) { // Spacing removed between views
                    HStack {
                        Spacer()
                        // Skip button
                        Button(action: {
                            isSkipPressed = true
                        }) {
                            Text("Skip")
                                .foregroundColor(.our)
                                .padding(.trailing, 20)
                        }
                        .background(
                            NavigationLink(
                                destination: IntroduceView(),
                                isActive: $isSkipPressed,
                                label: { EmptyView() }
                            )
                        
                        )

                    }
                    .padding(.horizontal)

                    // Main Page Content
                    TabView(selection: $selectedIndex) {
                        ForEach(0..<content.count, id: \.self) { index in
                            PageContentView(item: content[index])
                                .tag(index)
                        }
                    }
                    
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .onChange(of: selectedIndex, perform: { _ in
                        updateProgress()
                    })
                    .frame(maxHeight: .infinity)

                    // Page Indicator Dots
                    DotsProgress(selectedIndex: $selectedIndex)
                        .padding(.bottom, 10)
                }

                // SemiCircle at the absolute bottom
                VStack {
                    Spacer()
                    SemiCircle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 400)
                        .padding(.bottom, -190)
                        .edgesIgnoringSafeArea(.bottom)
                }
               
            }
            .onAppear {
                updateProgress()
            }
        }
       
    }

    func updateProgress() {
        withAnimation {
            progress = CGFloat(selectedIndex + 1) / CGFloat(content.count)
        }
    }
}

struct DotsProgress: View {
    @Binding var selectedIndex: Int

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<content.count, id: \.self) { index in
                Circle()
                    .fill(selectedIndex == index ? Color.gray : Color.primary)
                    .frame(width: 9, height: 9)
            }
        }
    }
}

struct PageContentView: View {
    var item: PageContent

    var body: some View {
        VStack {
            Image(item.image)
                .resizable()
                .frame(width: 300, height: 300)
                .padding(.top, 100)
                .padding(.bottom, 100)

            Text(item.title)
                .font(.system(size: 28))
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(.top, 50)

            getBoldFirstWord(from: item.description)
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .frame(maxWidth: 350)
                .padding(.bottom, 50)
        }
       
        .padding(.horizontal, 25)
    }

    // Function to make the first word bold and colored "orangi"
    func getBoldFirstWord(from text: String) -> Text {
        let words = text.split(separator: " ")
        guard words.count > 1 else {
            return Text(text).foregroundColor(.our).bold()
        }
        let firstWord = String(words[0])
        let remainingText = words.dropFirst().joined(separator: " ")
        
        return Text(firstWord)
            .foregroundColor(.our)
            .bold() +
        Text(" " + remainingText)
    }
}

// MARK: - SemiCircle Shape
struct SemiCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = rect.width / 2

        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addArc(center: CGPoint(x: center, y: rect.height),
                    radius: rect.height,
                    startAngle: .degrees(180),
                    endAngle: .degrees(0),
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        return path
        
    }
}

#Preview {
    GhadaView()
}

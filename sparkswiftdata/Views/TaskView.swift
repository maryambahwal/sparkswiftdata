
import SwiftUI
import SwiftData

struct TaskView: View {
    var task: Task // Pass a single task
    var toggleAction: () -> Void
    @State private var isNavigating = false

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.name)
                    .font(.title)
                    .foregroundColor(.primary)

                HStack(spacing: 4) {
                    displayComponent("\(task.duration)", icon: "clock", textColor: .our)
                        .padding(.trailing, 5)
                    displayComponent("\(task.priority)", icon: "", textColor: .primary)
                }
            }
            Spacer()

            // Custom Navigation Button
            Button(action: {
                isNavigating = true
            }) {
                Image(systemName: "play.fill")
                    .foregroundColor(.primary)
                    .padding(20)
                    .background(.our)
                    .cornerRadius(50)
            }
            .background(
                NavigationLink(
                    destination: TaskTimeFrame(duration: task.toSeconds() ?? 0, name: task.name, task: task),
                    isActive: $isNavigating
                ) {
                    EmptyView()
                }
                .hidden()
            )
        }
        .padding(.horizontal)
    }

    private func displayComponent(_ text: String, icon: String, textColor: Color) -> some View {
        HStack(spacing: 4) {
            if !icon.isEmpty {
                Image(systemName: icon)
                    .foregroundColor(textColor)
            }
            Text(text)
                .foregroundColor(textColor)
        }
        .padding(5)
        .background(RoundedRectangle(cornerRadius: 11).fill(Color.gray.opacity(0.2)))
    }
}

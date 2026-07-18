import SwiftUI

enum ExpandState: Equatable {
    case collapsed
    case partial
    case full
}

struct ContentView: View {
    @State private var router = Router()
    
    @State private var expansionState: ExpandState = .collapsed
    
    var body: some View {
        VStack {
            diagram
            
            expandableTaskPanel
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .gesture(stateGesture)
        .sensoryFeedback(.impact, trigger: expansionState)
        .animation(.smooth, value: expansionState)
    }
    
    var diagram: some View {
        GeometryReader { geo in
            let size = geo.size
            
            VennDiagram(viewWidth: size.width, viewHeight: size.height)
        }
        .background(.blue.opacity(0.5))
        .clipShape(ContainerRelativeShape())
    }
    
    var expandableTaskPanel: some View {
        Group {
            if !(expansionState == .collapsed) {
                VStack {
                    if expansionState == .full {
                        AllTasksView()
                    }
                    
                    if expansionState == .partial || expansionState == .full {
                        AddTaskButton()
                    }
                }
            }
        }
        .padding([.horizontal, .bottom])
        .transition(.move(edge: .bottom))
    }
    
    var stateGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                print(value.translation.height)
            }
            .onEnded { value in
                switch expansionState {
                case .collapsed:
                    if value.translation.height < 0 {
                        expansionState = .partial
                    }
                case .partial:
                    if value.translation.height < 0 {
                        expansionState = .full
                    } else {
                        expansionState = .collapsed
                    }
                case .full:
                    if value.translation.height > 0 {
                        expansionState = .partial
                    }
                }
            }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}

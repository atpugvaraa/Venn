import SwiftUI

struct ContentView: View {
    @State private var router = Router()
    
//    @State private var bottomPadding: CGFloat = 0
    @State private var swipedUp = false
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                let size = geo.size
                
                VennDiagram(viewWidth: size.width, viewHeight: size.height)
            }
            .background(.blue.opacity(0.5))
            .clipShape(ContainerRelativeShape())
            
            if swipedUp {
                HStack {
                    Circle()
                        .frame(width: 20, height: 20)
                    
                    Text("Task 1")
                }
                .frame(height: 48)
                .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .gesture (
            DragGesture()
                .onChanged { value in
                    print(value.translation.height)
                    
                    swipedUp = value.translation.height < 0
                }
                .onEnded { value in
                    
                }
        )
        .sensoryFeedback(.impact, trigger: swipedUp)
        .animation(.smooth, value: swipedUp)
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}

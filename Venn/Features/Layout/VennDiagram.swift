//
//  VennDiagram.swift
//  Venn
//
//  Created by Aarav Gupta on 18/07/26.
//

import SwiftUI

struct SetRegion: Hashable {
    let center: CGPoint
    let radius: CGFloat
}

struct VennDiagram: View {
    var viewWidth: CGFloat
    var viewHeight: CGFloat
    
    var radius: CGFloat
    var layout: [SetRegion]
    
    init(viewWidth: CGFloat, viewHeight: CGFloat, radius: CGFloat = 210) {
        self.viewWidth = viewWidth
        self.viewHeight = viewHeight
        
        self.radius = radius
        self.layout = [
            .init(center: .init(x: 75, y: 0), radius: radius),
            .init(center: .init(x: -75, y: 0), radius: radius),
            .init(center: .init(x: 0, y: 75), radius: radius),
            .init(center: .init(x: 0, y: -75), radius: radius)
        ]
    }
    
    var body: some View {
        ForEach(layout, id: \.self) {
            draw(set: $0)
        }
    }
    
    func draw(set: SetRegion) -> some View {
        Circle()
            .stroke(lineWidth: 3)
            .frame(width: set.radius, height: set.radius)
            .position(x: set.center.x + viewWidth / 2, y: set.center.y + viewHeight / 2)
    }
}

#Preview {
    GeometryReader { geo in
        let size = geo.size
        
        VennDiagram(viewWidth: size.width, viewHeight: size.height)
    }
    .ignoresSafeArea()
}

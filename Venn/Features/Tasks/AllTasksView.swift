//
//  AllTasksView.swift
//  Venn
//
//  Created by Aarav Gupta on 18/07/26.
//

import SwiftUI

struct AllTasksView: View {
    var tasks: [TaskItem] = [
        .init(id: 1, task: "Make the add task sheet"),
        .init(id: 2, task: "Make the task item card"),
        .init(id: 3, task: "Make the all tasks view"),
    ]
    
    var body: some View {
        VStack {
            ForEach(tasks, id: \.id) { task in
                TaskCard(task: task)
            }
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

#Preview {
    AllTasksView()
}

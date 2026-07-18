//
//  TaskCard.swift
//  Venn
//
//  Created by Aarav Gupta on 18/07/26.
//

import SwiftUI

struct TaskCard: View {
    var task: TaskItem
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 20, height: 20)
            
            Text("Task \(task.id): \(task.task)")
        }
        .frame(height: 48)
    }
}

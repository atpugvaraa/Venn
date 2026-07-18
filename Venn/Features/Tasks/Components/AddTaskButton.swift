//
//  AddTaskButton.swift
//  Venn
//
//  Created by Aarav Gupta on 18/07/26.
//

import SwiftUI

struct AddTaskButton: View {
    var body: some View {
        if #available(iOS 26.0, *) {
            Button {
                // open add task sheet
                // have the task sheet have a small example
            } label: {
                Text("Add Task")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(height: 48)
            }
            .buttonSizing(.flexible)
            .buttonStyle(.glass)
        } else {
            // Fallback on earlier versions
        }
    }
}

#Preview {
    AddTaskButton()
}

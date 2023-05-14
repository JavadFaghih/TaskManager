//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Javad on 2/24/1402 AP.
//

import SwiftUI

struct AddTaskView: View {
     // I used the same view model for both view because those are related to a single madule (Task Manger)
    @ObservedObject var viewModel: TaskListView.ViewModel
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("add title", text: $viewModel.title)
                    TextField("add descrption", text: $viewModel.description)
                }
            }.toolbar { toolbarItem }
        }
    }
    private var toolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                viewModel.addNewTaskToList()
            } label: {
                Text("Done")
            }
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(viewModel: TaskListView.ViewModel())
    }
}

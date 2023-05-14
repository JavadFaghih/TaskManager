//
//  ContentView.swift
//  TaskManager
//
//  Created by Javad on 2/24/1402 AP.
//

import SwiftUI

struct TaskListView: View {
    
    @StateObject private var viewModel: ViewModel = .init()
    @State private var filter: FilterType = .none
    
    var body: some View {
        NavigationView {
            List(filterdTask, id: \.id) { task in
                taskRow(task)
            }
            .toolbar { toolbarItem }
            .sheet(isPresented: $viewModel.showingAddTaskView) {
                AddTaskView(viewModel: viewModel)
            }
        }
    }
    
    private var toolbarItem: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.showingAddTaskView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Menu("Filter") {
                    Button("default") {
                        filterTasks(by: .none)
                    }
                    Button("by complted task") {
                        filterTasks(by: .compelted)
                    }
                    Button("by uncomplted task") {
                        filterTasks(by: .uncomplted)
                    }
                }
            }
        }
    }
    
  @ViewBuilder  private func taskRow(_ task: TaskModel) -> some View {
        Button {
            viewModel.remarkTaskStatus(with: task)
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(task.title)
                        .font(.headline)
                        .foregroundColor(.black)
                    Text(task.description)
                        .font(.subheadline)
                        .foregroundColor(Color.secondary)
                }
                Spacer()
                if task.isCompleted {
                    Image(systemName: "checkmark")
                        .font(.title3)
                        .foregroundColor(.green)
               }
            }
        }
    }
    
    func filterTasks(by newFilter: FilterType) {
        filter = newFilter
    }
    
    var filterdTask: [TaskModel] {
        switch filter {
        case .none:
            return viewModel.tasks
        case .compelted:
            return viewModel.tasks.filter(\.isCompleted)
        case .uncomplted:
            return viewModel.tasks.filter({ !$0.isCompleted })
        }
    }
    
    enum FilterType {
        case none
        case compelted
        case uncomplted
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

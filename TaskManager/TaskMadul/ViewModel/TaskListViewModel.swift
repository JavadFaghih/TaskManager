//
//  TaskListViewModel.swift
//  TaskManager
//
//  Created by Javad on 2/24/1402 AP.
//

import Foundation

extension TaskListView {
    @MainActor class ViewModel: ObservableObject {
        @Published var tasks: [TaskModel]
        @Published var showingAddTaskView: Bool = false
        @Published var title: String = ""
        @Published var description: String = ""
        let taskSavedPath = FileManager.userDocumentDirectory.appendingPathComponent("taskSavedPath")
        init() {
            if let data = try? Data(contentsOf: taskSavedPath) {
                if let decoded = try? JSONDecoder().decode([TaskModel].self, from: data) {
                    tasks = decoded
                    return
                }
            }
            tasks = []
        }
        func addNewTaskToList() {
            guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                print("please add a title") // it can be an alert to show user
                return
            }
            guard !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                print("please add a description") // it can be an alert to show user
                return
            }
            
            let newTask = TaskModel(id: UUID().uuidString, title: title, description: description, isCompleted: false)
            tasks.insert(newTask, at: 0)
            showingAddTaskView = false
            title = .init()
            description = .init()
            save()
        }
        func remarkTaskStatus(with selectedTask: TaskModel) {
             if let taskIndex = tasks.firstIndex(where: { $0.id == selectedTask.id }) {
                var task = selectedTask
                    task.isCompleted.toggle()
                    tasks[taskIndex] = task
                    save()
            }
        }
        private func save() {
          if let encoded = try? JSONEncoder().encode(tasks) {
             try? encoded.write(to: taskSavedPath)
            }
        }
    }
}

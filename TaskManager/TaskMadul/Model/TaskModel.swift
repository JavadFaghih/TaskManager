//
//  TaskModel.swift
//  TaskManager
//
//  Created by Javad on 2/24/1402 AP.
//

import Foundation

struct TaskModel: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    var isCompleted: Bool
}

//
//  FileManagerextenstion.swift
//  TaskManager
//
//  Created by Javad on 2/25/1402 AP.
//

import Foundation

extension FileManager {
   static var userDocumentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

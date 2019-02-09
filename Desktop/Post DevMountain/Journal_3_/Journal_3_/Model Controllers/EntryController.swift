//
//  EntryController.swift
//  Journal_3_
//
//  Created by Taylor Bills on 2/9/19.
//  Copyright © 2019 Taylor Bills. All rights reserved.
//

import Foundation

class EntryController {
    
    // MARK: -  Properties
    /// Singleton for EntryController
    static let shared = EntryController()
    var entries: [Entry] = []
    
    // MARK: -  Initializer
    init() {
        loadFromPersistentStorage()
    }
    
    // MARK: -  CRUD Functions
    /// Adds a new Entry object to your Journal
    func addNewEntryWith(title: String, andBody body: String) {
        let newEntry = Entry(title: title, body: body)
        self.entries.insert(newEntry, at: 0)
        saveToPersistence()
    }
    
    /// Removes a swiped/selected Entry object from your Journal
    func remove(entry: Entry) {
        guard let index = self.entries.index(of: entry) else { return }
        entries.remove(at: index)
        saveToPersistence()
    }
    
    /// Update a modified existing Entry object in your Journal
    func update(entry: Entry, newTitle: String, newBody: String) {
        entry.title = newTitle
        entry.body = newBody
        saveToPersistence()
    }
    
    // MARK: -  JSON Persistence using codable
    /// Save Location in device
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "journal3.json"
        let url = documentDirectory.appendingPathComponent(fileName)
        return url
    }
    
    /// Save Files to device
    func saveToPersistence() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(entries)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving to disk: \(error.localizedDescription)")
        }
    }
    
    /// Load Files from device
    func loadFromPersistentStorage() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let loadedEntries = try jsonDecoder.decode([Entry].self, from: data)
            self.entries = loadedEntries
        } catch let error {
            print("Error loading from disk \(error.localizedDescription)")
        }
    }
}

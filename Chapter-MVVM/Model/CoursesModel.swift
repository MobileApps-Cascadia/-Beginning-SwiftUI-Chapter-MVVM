//
//  CoursesModel.swift
//  Chapter-MVVM
//
//  Created by Mike Panitz on 5/16/23.
//

import Foundation

var theCollege = College()


class College {
    @Published var allClasses: [Discipline] = []
    
    init() {
        load()
    }
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("NameOfFileToSaveDataIn")
    func save() {
        
        // documentsDirectory is a non-standard property that we added, below
        do {
            let data = try JSONEncoder().encode(allClasses)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func load() {
        do {
            let data = try Data(contentsOf: savePath)
            allClasses = try JSONDecoder().decode([Discipline].self, from: data)
        } catch {
            //allClasses = []
            loadDefaultData()
        }
    }
    
    func loadDefaultData() {
        allClasses =  [
            Discipline(name: "MoBAS",
                       courses:
                        [Course(name: "BIT 101", sections: [Sect(time:"M/W 11am-1pm"), Sect(time:"Tu/Th 8pm-10:05pm")]),
                         Course(name: "BIT 102", sections: [Sect(time:"M/W 3pm-5pm"), Sect(time:"Tu/Th 11am-1pm")])]),
            Discipline(name: "English",
                       courses:
                        [Course(name: "ENG 101", sections: [Sect(time:"M/W 9am-11pm"), Sect(time:"Tu/Th 8pm-10:05pm")]),
                         Course(name: "ENG 102", sections: [Sect(time:"M/W 11am-1pm"), Sect(time:"Tu/Th 5pm-7pm")])])
        ]
    }
    
}

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct Discipline : Identifiable, Codable {
    let id = UUID()
    let name:String
    var courses: [Course]
}

struct Course : Identifiable, Codable {
    let id = UUID()
    let name:String
    var sections: [Sect]
}

struct Sect: Identifiable, Codable {
    let id = UUID()
    let time:String
    var isEnrolled = false
}

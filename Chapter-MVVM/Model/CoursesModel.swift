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
    public init() {
        allClasses = [
            Discipline(name: "MoBAS",
                       courses:
                        [Course(name: "BIT 101"),
                         Course(name: "BIT 102")]),
            Discipline(name: "English",
                       courses:
                        [Course(name: "ENG 101"),
                         Course(name: "ENG 102")])
        ]
    }
}

struct Discipline : Identifiable {
    let id = UUID()
    let name:String
    var courses: [Course]
}

struct Course : Identifiable {
    let id = UUID()
    let name:String
    var isEnrolled = false
}

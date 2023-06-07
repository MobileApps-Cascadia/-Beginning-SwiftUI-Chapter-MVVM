//
//  CoursesViewModel.swift
//  Chapter-MVVM
//
//  Created by Mike Panitz on 5/16/23.
//

import Foundation

extension CoursesView {
    @MainActor class ViewModel: ObservableObject {
        @Published var allClasses = theCollege.allClasses
        @Published var enrollmentOpen = false // are student allowed to enroll right now?
        @Published var courseChangesAllowed = false // can college employees make changes to the courses right now?
        
        func addNewCourse( discName: String, courseName: String) {
            print("Create new course: \(discName) \(courseName)")
            
            for idx in theCollege.allClasses.indices {
                print("\tChecking \(theCollege.allClasses[idx].name)")
                
                if theCollege.allClasses[idx].name == discName {
                    print("\tFound discipline named \(discName)")
                    for course in theCollege.allClasses[idx].courses {
                        if course.name == courseName {
                            print("\tFound duplicate - ignoring")
                            return
                        }
                    }
                    print("Adding \(courseName) to \(discName)")
                    // add new course to existing discipline:
                    let course = Course(name: courseName, sections: [])
                    theCollege.allClasses[idx].courses.append(course)
                    return
                }
            }
            print("Couldn't find discipline named \(discName), so create an entirely new one")
            let course = Discipline(name: discName, courses: [Course(name: courseName, sections: [])])
            allClasses.append(course)
            return
        }
        func addNewSection( time: String, courseName: String, discName: String) {
            print("Create new section: \(courseName) \(time)")
            
            for idx in theCollege.allClasses.indices {
                for index in theCollege.allClasses[idx].courses.indices{
                    print("\tChecking \(theCollege.allClasses[idx].courses[index])")
                    
                    if theCollege.allClasses[idx].courses[index].name == courseName {
                        print("\tFound course named \(courseName)")
                        for section in theCollege.allClasses[idx].courses[index].sections {
                            if section.time == time {
                                print("\tFound duplicate - ignoring")
                                return
                            }
                        }
                        print("Adding \(time) to \(courseName)")
                        // add new course to existing discipline:
                        let section = Sect(time: time)
                        theCollege.allClasses[idx].courses[index].sections.append(section)
                        return
                    }
                }
                
                print("Couldn't find course named \(courseName), so create an entirely new one")
                addNewCourse(discName: discName, courseName: courseName)
                return
            }
        }
        
        func enrollSection(course: Course, disc: Discipline) {
            for var sect in theCollege.allClasses[disc.id.hashValue].courses[course.id.hashValue].sections {
                if sect.isEnrolled == true{
                    sect.isEnrolled.toggle()
                }
            }
            return
        }
    }
}

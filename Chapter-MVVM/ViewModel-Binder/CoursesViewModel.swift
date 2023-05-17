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
    }
}

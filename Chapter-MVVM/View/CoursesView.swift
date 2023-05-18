//
//  CoursesView.swift
//  Chapter-MVVM
//
//  Created by Mike Panitz on 5/16/23.
//

import SwiftUI

struct CoursesView: View {
    @StateObject private var viewModel = ViewModel()
    
    @State private var showAddClassActionSheet = false
    @State private var newDiscName = ""
    @State private var newCourseName = ""
    
    var body: some View {
        VStack {
            Text("Courses")
                .font(.title)
            List {
                // If we want to change the structs:
                // Use Bindings here
                // And mark changeable fields as var, below
                ForEach($viewModel.allClasses) { $disc in
                    Section(header: Text("\(disc.name) Courses:")) {
                        ForEach($disc.courses) { $course in
                            HStack {
                                Text(course.name)
                                    .swipeActions(edge: .trailing) {
                                        Button {
                                            course.isEnrolled.toggle()
                                        } label: {
                                            Image(systemName: "book")
                                        }.tint(.green)
                                    }
                                Spacer()
                                if course.isEnrolled {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.green)
                                        .font(.largeTitle)
                                } else {
                                    Image(systemName: "plus")
                                    
                                }
                            }
                        }
                    }
                }
            }
            Button("Add a course") {
                showAddClassActionSheet = true
            }
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
        }
        .padding()
        .fullScreenCover(isPresented: $showAddClassActionSheet) {
            VStack {
                Text("Add a new course").font(.title)
                Text("Discipline name:")
                TextField("Ex: ENG, BIT", text: $newDiscName)
                Text("Course name:")
                TextField("Ex: Shakespeare, Intro To Web Design", text: $newCourseName)
                HStack {
                    Button("Cancel") {
                        showAddClassActionSheet = false
                    }
                    Spacer()
                    Button("Save" ) {
                        viewModel.addNewCourse(discName: newDiscName, courseName: newCourseName)
                        newDiscName = ""
                        newCourseName = ""
                        showAddClassActionSheet = false
                    }
                }.padding()
            }.padding()
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}

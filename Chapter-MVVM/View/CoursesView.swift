//
//  CoursesView.swift
//  Chapter-MVVM
//
//  Created by Mike Panitz on 5/16/23.
//

import SwiftUI

struct CoursesView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
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
        }
        .padding()
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}

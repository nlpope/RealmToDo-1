//
//  ContentView.swift
//  RealmToDo-1
//
//  Created by Noah Pope on 7/25/23.
//

/**
 initial commit
 studying realm w stewart lynch
 
 think the problem w the search filtering is in the private searchFilter's
 declaration up top. Maybe it should be summat other than what it is
 */

import SwiftUI
import RealmSwift

struct ToDoListView: View {
    //I want this view to observe the type ToDo
    //Then sort it using the "completed" variable in each ToDo
    @ObservedResults(ToDo.self) var toDos
    @State private var name = ""
    @State private var searchFilter = ""
    @FocusState private var focus: Bool?
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("", text: $name)
                        .focused($focus, equals: true)
                        .textFieldStyle(.roundedBorder)
                    Spacer()
                    Button {
                        let newToDo = ToDo(name: name)
                        $toDos.append(newToDo)
                        name = ""
                        focus = nil
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(name.isEmpty)
                }
                .padding()
                List() {
                    //moved sorting to down here so we can animate the changes
                    ForEach(toDos.sorted(by: [
                        SortDescriptor(keyPath: "completed"),
                        SortDescriptor(keyPath: "urgency", ascending: false)
                    ])) { toDo in
                        ToDoListRow(toDo: toDo)
                    }
//                    .onDelete(perform: $toDos.remove)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .searchable(text: $searchFilter,
                            collection: $toDos,
                            keyPath: \.name){
                    //a bit confused here ???
                    ForEach(toDos) { toDo in
                        Text(toDo.name)
                            .searchCompletion(toDo.name)
                    }
                }
            }
            .animation(.default, value: toDos)
            .navigationTitle("Realm ToDos")
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}

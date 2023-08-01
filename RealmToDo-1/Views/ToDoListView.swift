//
//  ContentView.swift
//  RealmToDo-1
//
//  Created by Noah Pope on 7/25/23.
//

/**
 initial commit
 studying realm w stewart lynch
 */

import SwiftUI
import RealmSwift

struct ToDoListView: View {
    @ObservedResults(ToDo.self) var toDos
    @State private var name = ""
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
                    ForEach(toDos) { toDo in
                        ToDoListRow(toDo: toDo)
//                        Text(toDo.name)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Realm ToDos")
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}

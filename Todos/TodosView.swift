//
//  ContentView.swift
//  Todos
//
//  Created by marius nel on 2023/04/26.
//

import SwiftUI
import CoreData

struct TodosView: View {
    
    @StateObject var viewModel = TodosViewModel()
    @State var addTodoTextFieldText: String = ""
    @State var editTodoTextFieldText: String = ""
    @State var editedItem: TodoItem?
    @State private var presentAlert = false
    let textFieldBackgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    let buttonBackgroundColor = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
    let dateTextColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add a Todo item...", text: $addTodoTextFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color(textFieldBackgroundColor))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 20)
                
                Button("Submit") {
                    guard !addTodoTextFieldText.isEmpty else { return }
                    viewModel.addItem(title: addTodoTextFieldText)
                    addTodoTextFieldText = ""
                }
                .font(.headline)
                .padding()
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color(buttonBackgroundColor))
                .cornerRadius(10)
                .padding(.horizontal)
                
                List {
                    ForEach(viewModel.todoItems) { item in
                        HStack {
                            Text("\(item.title)")
                            Spacer()
                            Text("\(item.date.formatted(date: .abbreviated, time: .shortened))")
                                .foregroundColor(Color(dateTextColor))
                        }
                        .onTapGesture {
                            presentAlert = true
                            editTodoTextFieldText = item.title
                            editedItem = item
                        }
                    }
                    .onDelete(perform: viewModel.removeItem)
                }
                .listStyle(.plain)
            }
            .navigationTitle("TODOs")
            .alert("Edit todo item", isPresented: $presentAlert, actions: {
                TextField("TextField", text: $editTodoTextFieldText)
                Button("Cancel") {
                    presentAlert = false
                }
                Button("Submit") {
                    guard let item = editedItem else { return }
                    viewModel.edit(item: item, title: editTodoTextFieldText)
                }
            }, message: {
                TextField("TextField", text: $editTodoTextFieldText)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodosView()
    }
}

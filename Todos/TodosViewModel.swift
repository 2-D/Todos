//
//  TodosViewModel.swift
//  Todos
//
//  Created by marius nel on 2023/04/28.
//

import Foundation

struct TodoItem: Identifiable, Equatable {
    var id = UUID()
    var description: String
    var date: Date
}

final class TodosViewModel: ObservableObject {
    private(set) var todoItems: [TodoItem] = []
    
    func fetchItems() {
        
    }
    
    func addItem(_ item: TodoItem) {
        todoItems.append(item)
    }
    
    func removeItem(_ indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        todoItems.remove(at: index)
    }
    
    func edit(item: TodoItem, description: String) {
        guard let itemIndex = todoItems.firstIndex(of: item) else { return }
        var item = todoItems[itemIndex]
        item.description = description
        item.date = Date()
        todoItems[itemIndex] = item
    }
}


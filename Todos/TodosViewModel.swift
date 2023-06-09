//
//  TodosViewModel.swift
//  Todos
//
//  Created by marius nel on 2023/04/28.
//

import Foundation

struct TodoItem: Identifiable, Equatable {
    var id: UUID
    var title: String
    var date: Date
}

final class TodosViewModel: ObservableObject {
    private(set) var todoItems: [TodoItem] = []
    
    func fetchItems() {
        
    }
    
    func addItem(title: String) {
        let item = TodoItem(
            id: UUID(),
            title: title,
            date: Date()
        )
        todoItems.append(item)
    }
    
    func removeItem(_ indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        todoItems.remove(at: index)
    }
    
    func edit(item: TodoItem, title: String) {
        guard let itemIndex = todoItems.firstIndex(of: item) else { return }
        var item = todoItems[itemIndex]
        item.title = title
        item.date = Date()
        todoItems[itemIndex] = item
    }
}


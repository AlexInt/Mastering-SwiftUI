//
//  FilteredList.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/23.
//

import SwiftUI

struct FilteredList: View {
    @Environment(\.managedObjectContext) var context
    
    @Binding var searchText: String
    
    //to hold the fetch request
    var fetchRequest: FetchRequest<ToDoItem>
    //to store the fetched results.
    var todoItems: FetchedResults<ToDoItem> {
        fetchRequest.wrappedValue
    }
    init(_ searchText: Binding<String>) {
        
        //The first line of the init method is to store the binding of the search text.
        //To assign a binding, you use the underscore like this:
        self._searchText = searchText
        
        //The [c] following CONTAINS means that the search is case insensitive.
        let predicate = searchText.wrappedValue.isEmpty ? NSPredicate(value: true) :
        NSPredicate(format: "name CONTAINS[c] %@", searchText.wrappedValue)
        self.fetchRequest =
        FetchRequest(entity: ToDoItem.entity(),
                     sortDescriptors: [NSSortDescriptor(keyPath: \ToDoItem.priorityNum, ascending: false)],
                     predicate: predicate,
                     animation: .default)
    }
    
    var body: some View {
        ZStack {
            
            List {
                
                ForEach(todoItems) {
                    ToDoListRow(todoItem: $0)
                }
                .onDelete(perform: deleteTask)
            }
            
            if todoItems.count == 0 {
                ToDoNoDataView()
            }
            
        }
        
    }
    
    //Deleting an item from database
    func deleteTask(indexSet: IndexSet) {
        indexSet.forEach{ context.delete(todoItems[$0]) }
        
        DispatchQueue.main.async {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}

//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
//}

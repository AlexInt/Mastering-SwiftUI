//
//  ToDoContentView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/17.
//

import SwiftUI
import CoreData

struct ToDoContentView: View {
//    @State var todoItems: [ToDoItem] = []
    
    //Using @FetchRequest to fetch records
    @FetchRequest(entity: ToDoItem.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \ToDoItem.priorityNum, ascending: false)])
    var todoItems: FetchedResults<ToDoItem>
    
    @State private var newItemName: String = ""
    @State private var newItemPriority: Priority = .normal
    
    @State private var showNewTask = false
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                HStack {
                    Text("ToDo List")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                    
                    Spacer()
                    
                    Button(action: {
                        self.showNewTask = true
                        
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.purple)
                    }
                }
                .padding()
                
                List {
                    
                    ForEach(todoItems) { todoItem in
                        ToDoListRow(todoItem: todoItem)
                    }
//                    .onDelete { indexSet in
//                        self.deleteTask(indexSet: indexSet)
//                    }
                    //same with above
                    .onDelete(perform: deleteTask)
                    
                }
            }
            .rotation3DEffect(Angle(degrees: showNewTask ? 5 : 0), axis: (x: 1, y: 0, z: 0))
            .offset(y: showNewTask ? -50 : 0)
            .animation(.easeOut)
            
            // If there is no data, show an empty view
            if todoItems.count == 0 {
                NoDataView()
            }
            
            // Display the "Add new todo" view
            if showNewTask {
                ToDoBlankView(bgColor: .black)
                    .opacity(0.5)
                    .onTapGesture {
                        self.showNewTask = false
                    }
                
                NewToDoView(isShow: $showNewTask, name: "", priority: .normal)
                    .transition(.move(edge: .bottom))
                    .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0))
            }
        }
    }
    
    
    //Deleting an item from database
    private func deleteTask(indexSet: IndexSet) {
        for index in indexSet {
            let itemToDelete = todoItems[index]
            context.delete(itemToDelete)
        }
        
        DispatchQueue.main.async {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}

//FOR darkening the list view when add to do item
struct ToDoBlankView : View {
    
    var bgColor: Color
    
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct NoDataView: View {
    var body: some View {
        Image("welcome")
            .resizable()
            .scaledToFit()
    }
}

struct ToDoListRow: View {
    
    @ObservedObject var todoItem: ToDoItem
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        Toggle(isOn: self.$todoItem.isComplete) {
            HStack {
                Text(self.todoItem.name)
                    .strikethrough(self.todoItem.isComplete, color: .black)
                    .bold()
                    .animation(.default)
                
                Spacer()
                
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(self.color(for: self.todoItem.priority))
            }
        }
        .toggleStyle(CheckboxStyle())
        //Updating an existing item
        .onReceive(todoItem.objectWillChange) { _ in
            if self.context.hasChanges {
                try? self.context.save()
            }
        }
    }
    
    private func color(for priority: Priority) -> Color {
        switch priority {
        case .high: return .red
        case .normal: return .orange
        case .low: return .green
        }
    }
}


struct ToDoContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

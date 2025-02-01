//
//  ContentView.swift
//  iExpense
//
//  Created by Amr El-Fiqi on 31/01/2025.
//

import SwiftUI
import Observation

// MARK: - Classes

@Observable
class Expenses {
    var item = [ExpenseItem]()
}

// MARK: - Structs

struct ExpenseItem {
    var name: String
    var type: String
    var amount: Double
}

// MARK: - Content View

struct ContentView: View {
    
    // MARK: - Variables
    @State private var expenses = Expenses()
    
    var body: some View {
        
        NavigationStack {
            List{
                ForEach(expenses.item, id: \.name) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpenses")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                        let expense = ExpenseItem(name: "New Expense", type: "Food", amount: 100.0)
                        expenses.item.append(expense)
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.item.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}




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

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}

// MARK: - Content View

struct ContentView: View {
    
    // MARK: - Variables
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        
        NavigationStack {
            List{
                ForEach(expenses.item) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpenses")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense.toggle()
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView()
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




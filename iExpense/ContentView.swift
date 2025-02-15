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
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
    
    var items = [ExpenseItem]() {
        didSet {
            if let encoded  = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
}

// MARK: - Structs

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
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
            VStack {
                List{
                    Section ("Personal") {
                        ForEach(expenses.items.filter {$0.type == "Personal"}) { item in
                            addRow(name: item.name, type: item.type, amount: item.amount)
                        }
                        .onDelete{ indexSet in removeItems(at: indexSet, ofType: "Personal")}
                    }
                    
                    Section ("Business") {
                        ForEach(expenses.items.filter {$0.type == "Business"}) { item in
                            addRow(name: item.name, type: item.type, amount: item.amount)
                        }
                        .onDelete{ indexSet in removeItems(at: indexSet, ofType: "Business")}
                    }
                }
                .navigationTitle("iExpenses")
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: expenses)
                }
                Button("Add expense", systemImage: "plus") {
                    showingAddExpense.toggle()
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, ofType type: String) {
        if type == "Personal" {
            expenses.items.remove(atOffsets: offsets)
        }
        else if type == "Business" {
            expenses.items.remove(atOffsets: offsets)
        }
        
    }
    func addRow(name: String, type: String, amount: Double) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(type)
            }
            Spacer()
            
            Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundStyle(styleForAmount(amount))
                .fontWeight(styleFontWeight(amount))
        }
    }
    
    func styleForAmount(_ amount: Double) -> Color {
        if amount <= 100 {
            return .green
        } else if amount <= 1000 {
            return .blue
        } else {
            return .red
        }
    }
    
    func styleFontWeight(_ amount: Double) -> Font.Weight {
        if amount < 10 {
            return .light
        } else if amount < 100 {
            return .regular //
        } else {
            return .bold
        }
    }
}

#Preview {
    ContentView()
}




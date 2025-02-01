//
//  AddView.swift
//  iExpense
//
//  Created by Amr El-Fiqi on 01/02/2025.
//

import SwiftUI

struct AddView: View {
    
    // MARK: - Variables
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @Environment(\.dismiss) var dismiss
    
    var expenses: Expenses
    
    let types = ["Personal", "Business"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text:$name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}

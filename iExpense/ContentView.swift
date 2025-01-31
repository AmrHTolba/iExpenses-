//
//  ContentView.swift
//  iExpense
//
//  Created by Amr El-Fiqi on 31/01/2025.
//

import SwiftUI
import Observation

// MARK: - Class

@Observable
class User {
    var firstName = ""
    var lastName = ""
}


// MARK: - Structs

struct ContentView: View {
    
    // MARK: - Variables
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @State private var user = User()
    @State private var showingSheet = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }
//        Button("Show New View") {
//            showingSheet.toggle()
//        }
//        .sheet(isPresented: $showingSheet) {
//            SecondView(name: "Hah noob")
//        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}


//struct SecondView: View {
//    
//    let name: String
//    @Environment(\.dismiss) var dismiss
//    
//    var body: some View {
//        Text("You wrote: \(name)")
//        Button("Dismiss") {
//            dismiss()
//        }
//    }
//}

#Preview {
    ContentView()
}




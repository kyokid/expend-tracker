//
//  AddExpenseView.swift
//  ExpenseTracker
//
//  Created by Ha Vo on 15/9/23.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var context
  
  @State private var title = ""
  @State private var subtitle = ""
  @State private var amount: CGFloat = 0
  @State private var date: Date = .init()
  @State private var category: Category?
  
  @Query(animation: .snappy)
  private var allCategories: [Category]
  var body: some View {
    NavigationStack {
      List {
        Section("Title") {
          TextField("Magic keyboard", text: $title)
        }
        
        Section("Amount spent") {
          TextField("0.0", value: $amount, format: .currency(code: "US"))
        }
        
        Section("Description") {
          HStack(spacing: 4) {
            Text("$")
              .fontWeight(.semibold)
            TextField("Bought a keyboard at Apple Store", text: $subtitle)
          }
        }
        
        Section("Date") {
          DatePicker("", selection: $date, displayedComponents: [.date])
            .datePickerStyle(.graphical)
            .labelsHidden()
        }
        
        if !allCategories.isEmpty {
          HStack {
            Text("Category")
            
            Spacer()
            
            Picker("", selection: $category) {
              ForEach(allCategories) { category in
                Text(category.categoryName)
                  .tag(category)
              }
            }
            .pickerStyle(.menu)
            .labelsHidden()
          }
        }
      }
      .navigationTitle("Add Expense View")
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button("Cancel") {
            dismiss()
          }
          .tint(.red)
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          Button("Add", action: addExpense)
        }
      }
    }
  }
  
  func addExpense() {
    
  }
  
}

#Preview {
  AddExpenseView()
}

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
            .autocorrectionDisabled()
        }
        
        Section("Description") {
          TextField("Bought a keyboard at Apple Store", text: $subtitle)
            .autocorrectionDisabled()
        }
        
        Section("Amount spent") {
          TextField("0.0", value: $amount, formatter: formatter)
            .keyboardType(.decimalPad)
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
            
            Menu {
              ForEach(allCategories) { category in
                Button(category.categoryName) {
                  self.category = category
                }
              }
              
              Button("None") {
                self.category = nil
              }
            } label: {
              if let categoryName = category?.categoryName {
                Text(categoryName)
              } else {
                Text("None")
              }
            }
          }
        }
      }
      .navigationTitle("Add Expense View")
      .toolbarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button("Cancel") {
            dismiss()
          }
          .tint(.red)
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          Button("Add", action: addExpense)
            .disabled(isAddButtonDisabled)
        }
      }
    }
  }
  
  var isAddButtonDisabled: Bool {
    title.isEmpty || subtitle.isEmpty || amount == .zero
  }
  
  func addExpense() {
    let expense = Expense(title: title, subtitle: subtitle, amount: amount, date: date, category: category)
    context.insert(expense)
    
    dismiss()
  }
  
  var formatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    return formatter
  }
  
}

#Preview {
  AddExpenseView()
}

//
//  ExpensesView.swift
//  ExpenseTracker
//
//  Created by Ha Vo on 15/9/23.
//

import SwiftUI
import SwiftData

struct ExpensesView: View {
  @Query(sort: [SortDescriptor(\Expense.date, order: .reverse)], animation: .snappy)
  private var allExpenses: [Expense]
  
  @State private var groupedExpenses: [GroupedExpense] = []
  @State private var addExpense = false
  var body: some View {
    NavigationStack {
      List {
        
      }
      .navigationTitle("Expenses")
      .overlay {
        if allExpenses.isEmpty || groupedExpenses.isEmpty {
          ContentUnavailableView {
            Label("No Expense", systemImage: "tray.fill")
          }
        }
      }
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button(action: {
            addExpense.toggle()
          }, label: {
            Image(systemName: "plus.circle.fill")
              .font(.title3)
          })
        }
      }
      .sheet(isPresented: $addExpense, content: {
        AddExpenseView()
      })
    }
    .onChange(of: allExpenses, initial: true) { oldValue, newValue in
      if groupedExpenses.isEmpty {
        createGroupExpenses(newValue)
      }
    }
  }
  
  func createGroupExpenses(_ expenses: [Expense]) {
    Task.detached(priority: .high) {
      let groupDict = Dictionary(grouping: expenses) { expense in
        let dateComponent = Calendar.current.dateComponents([.day, .month, .year], from: expense.date)
        return dateComponent
      }
      
      let sortedDict = groupDict.sorted {
        let calendar = Calendar.current
        let date1 = calendar.date(from: $0.key) ?? .init()
        let date2 = calendar.date(from: $1.key) ?? .init()
        
        return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
      }
      
      await MainActor.run {
        groupedExpenses = sortedDict.compactMap { dict in
          let date = Calendar.current.date(from: dict.key) ?? .init()
          return .init(date: date, expense: dict.value)
        }
      }
    }
  }
}

#Preview {
  ExpensesView()
}
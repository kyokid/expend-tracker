//
//  GroupedExpense.swift
//  ExpenseTracker
//
//  Created by Ha Vo on 15/9/23.
//

import Foundation

struct GroupedExpense: Identifiable {
  var id: UUID = .init()
  var date: Date
  var expenses: [Expense]
  
  var groupTitle: String {
    let calendar = Calendar.current
    
    if calendar.isDateInToday(date) {
      return "Today"
    } else if calendar.isDateInYesterday(date) {
      return "Yesterday"
    } else {
      return date.formatted(date: .abbreviated, time: .omitted)
    }
  }
}

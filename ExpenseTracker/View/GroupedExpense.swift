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
  var expense: [Expense]
}

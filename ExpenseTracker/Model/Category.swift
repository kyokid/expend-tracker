//
//  Category.swift
//  ExpenseTracker
//
//  Created by Ha Vo on 15/9/23.
//

import Foundation
import SwiftData

@Model
class Category {
  var categoryName: String
  
  @Relationship(.cascade, inverse: \Expense.category)
  var expenses: [Expense]?
  
  init(categoryName: String) {
    self.categoryName = categoryName
  }
}


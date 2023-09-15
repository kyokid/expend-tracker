//
//  ExpenseCardView.swift
//  ExpenseTracker
//
//  Created by Ha Vo on 15/9/23.
//

import SwiftUI

struct ExpenseCardView: View {
  @Bindable var expense: Expense
  var body: some View {
    HStack {
      VStack(alignment: .leading, content: {
        Text(expense.title)
        
        Text(expense.subtitle)
          .font(.caption)
          .foregroundStyle(.gray)
      })
      .lineLimit(1)
      
      Spacer(minLength: 5)
      
      Text(expense.currencyString)
        .font(.title3.bold())
    }
  }
}

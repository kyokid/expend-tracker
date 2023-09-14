//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Ha Vo on 14/9/23.
//

import SwiftUI

struct ContentView: View {
  @State private var currentTab = "Expenses"
  var body: some View {
    TabView(selection: $currentTab,
            content:  {
      ExpensesView()
        .tabItem {
          Image(systemName: "creditcard.fill")
          Text("Expenses")
        }
        .tag("Expenses")
      
      CategoriesView()
        .tabItem {
          Image(systemName: "list.clipboard.fill")
          Text("Categories")
        }
        .tag("Categories")
    })
  }
}

#Preview {
  ContentView()
}

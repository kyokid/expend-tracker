//
//  CategoriesView.swift
//  ExpenseTracker
//
//  Created by Ha Vo on 15/9/23.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {
  @State private var addCategory = false
  @State private var categoryName = ""
  @State private var deleteRequest = false
  @State private var requestedCategory: Category?
  
  @Query(animation: .snappy) private var allCategories: [Category]
  @Environment(\.modelContext) private var context
  var body: some View {
    NavigationStack {
      List {
        ForEach(allCategories.sorted(by: {($0.expenses?.count ?? 0) > ($1.expenses?.count ?? 0) })) { category in
          DisclosureGroup(
            content: {
              if let expenses = category.expenses, !expenses.isEmpty {
                ForEach(expenses) { expense in
                    ExpenseCardView(expense: expense, displayTag: false)
                }
              } else {
                ContentUnavailableView("No Expenses", systemImage: "tray.fill")
              }
            },
            label: { Text(category.categoryName) }
          )
          .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button {
              requestedCategory = category
              deleteRequest.toggle()
            } label: {
              Image(systemName: "trash")
            }
            .tint(.red)

          }
        }
      }
      .navigationTitle("Categories")
      .overlay {
        if allCategories.isEmpty {
          ContentUnavailableView("No Categories", systemImage: "tray.fill")
        }
      }
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button(action: {
            addCategory.toggle()
          }, label: {
            Image(systemName: "plus.circle.fill")
              .font(.title3)
          })
        }
      }
      .sheet(isPresented: $addCategory) {
        categoryName = ""
      } content: {
        NavigationStack {
          List {
            Section("Title") {
              TextField("General", text: $categoryName)
                .autocorrectionDisabled()
            }
          }
          .navigationTitle("Category Name")
          .navigationBarTitleDisplayMode(.inline)
          .toolbar {
            ToolbarItem(placement: .topBarLeading) {
              Button("Cancel") {
                addCategory = false
              }
              .tint(.red)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
              Button("Add") {
               let category = Category(categoryName: categoryName)
                context.insert(category)
                categoryName = ""
                addCategory = false
              }
              .disabled(categoryName.isEmpty)
            }
          }
        }
        .presentationDetents([.height(180)])
        .presentationCornerRadius(20)
//        .interactiveDismissDisabled()
      }
    }
    .alert("If you delete a category, all the associated expenses will be deleted too.", isPresented: $deleteRequest) {
      Button {
        if let requestedCategory {
          context.delete(requestedCategory)
          self.requestedCategory = nil
        }
      } label: {
        Text("Delete")
      }
      
      Button(role: .cancel) {
        requestedCategory = nil
      } label: {
        Text("Cancel")
      }


    }
  }
}

#Preview {
  CategoriesView()
}

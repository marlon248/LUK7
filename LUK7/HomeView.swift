//
//  UITabView.swift
//  LUK7
//
//  Created by Marlon Milanes Rivero on 2023-10-12.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)], animation: .default) private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            HomeDetailsView(item: item)
                                .environment(\.managedObjectContext, viewContext)
                            
                        } label: {
                            Text(item.timestamp!, formatter: itemFormatter)
                        }
                    }
                    .onDelete(perform: deleteItems)
                    
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                .navigationTitle("home_title")
                .navigationBarTitleDisplayMode(.inline)
                .overlay(alignment: .bottom) {
                    HStack {
                        BannerAd(unitID: "ca-app-pub-4020019088912260/6506320758")
                            .frame(minHeight: 50, maxHeight: 50)
                    }
                }
                            
            }
           
            
        }
        
        
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

//
//  AddListView.swift
//  JournalX
//
//  Created by Samira Resouliikhechi on 16/11/23.
//

import SwiftUI

struct AddListView: View {
    @ObservedObject var data = AddListData()
    
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if data.selectedSegment == 0 {
                        List {
                            Image(systemName: data.selectedIcon)
                                .resizable()
                                .padding()
                                .frame(width: 70, height: 70)
                                .padding()
                                .padding(.horizontal, 130)
                                .background(Circle().fill(data.selectedColor))
                                .shadow(color: data.selectedColor, radius: 6)
                            
                            TextField("List Name", text: $data.listName)
                                .textFieldStyle(CustomTextFieldStyle())
                                .font(.system(size: 20))
                                .bold()
                                .multilineTextAlignment(.center)
                                .shadow(radius: 5)

                                .onTapGesture {
                                    if data.listName == "List Name" {
                                        data.listName = ""
                                    }
                                }
                            
                            
                            ForEach(data.colors.chunked(into: 6), id: \.self) { row in
                                HStack {
                                    ForEach(row, id: \.self) { color in
                                        Circle()
                                            .fill(color)
                                            .frame(width: 50, height: 40)
                                            .onTapGesture {
                                                data.selectedColor = color
                                            }
                                    }
                                }
                            }
                            
                            ForEach(data.icons.chunked(into: 6), id: \.self) { row in
                                HStack {
                                    ForEach(row, id: \.self) { icon in
                                        Image(systemName: icon)
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .padding()
                                            .background(Circle().fill(Color(.systemGray5)))
                                            .onTapGesture {
                                                data.selectedIcon = icon
                                            }
                                    }
                                }
                            }
                        }
                    } else {
                        
                        Text("No Templates")
                            .bold()
                            .font(.title)
                        
                        
                        Text("You can create templates from lists by tapping three dots inside a list and choosing Save as Template")
                            .foregroundStyle(Color.gray)
                        
                    }
                }
            }
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button(action: {
                    addNewList()
                }) {
                    Text("Done")
                }
                    .disabled(data.listName.isEmpty)
            )
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("", selection: $data.selectedSegment) {
                        Text("New List").tag(0)
                        Text("Templates").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func addNewList() {
        presentationMode.wrappedValue.dismiss()
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: 6).map {
            Array(self[$0..<Swift.min($0 + 6, count)])
        }
    }
}
struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(15)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
            .padding(5)
    }
}
#Preview {
    AddListView()
}

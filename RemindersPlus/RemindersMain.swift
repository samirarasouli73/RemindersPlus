
import SwiftUI

struct RemindersMain: View {
    @State private var searchText = ""
    @State private var isAddingReminder = false
    @State private var isAddingList = false
    @State private var isEditing = false
    @State private var reminders = ReminderData().icons
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            VStack {
                if isEditing {
                    customList
                } else {
                    customScrollView
                }
                customHStack
            }
            .background(Color(.systemGray6))
            .navigationTitle("")
            .navigationBarHidden(false)
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            self.isEditing.toggle()
                        }) {
                            Label("Edit Lists", systemImage: "pencil")
                        }
                        
                        Button(action: {
                            // Handle Templates action
                        }) {
                            Label("Templates", systemImage: "doc")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
    
    var customScrollView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(reminders.indices.filter { searchText.isEmpty ? true : ReminderData().titles[$0].contains(searchText) }, id: \.self) { index in
                    Button(action: {
                        print("Button tapped for index \(index)")
                    }) {
                        VStack {
                            CardView(
                                icon: ReminderData().icons[index],
                                title: ReminderData().titles[index],
                                listCount: (index == 4) ? nil : (index + 1) * 0,
                                backgroundColor: .white,
                                iconColor: ReminderData().iconColor[index],
                                width: 170
                            )
                        }
                        .accessibilityElement()
                        .accessibilityIdentifier("card\(index)")
                        .accessibilityLabel("Card \(ReminderData().titles[index])")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .background(Color(.systemGray6))
    }
    
    var customList: some View {
        List {
            ForEach(reminders.indices, id: \.self) { index in
                HStack {
                    
                    // Icon
                    Image(systemName: ReminderData().icons[index])
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(ReminderData().iconColor[index])
                        .padding(.horizontal, 5)
                    
                    // Title
                    Text(ReminderData().titles[index])
                    
                    Spacer()
                    
                    // Line.3.horizontal
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .frame(width: 20, height: 10)
                        .foregroundColor(Color(.systemGray4))
                }
                .padding(.vertical, 5)
            }
            .onMove(perform: move)
            .onDelete(perform: delete)
            
            if isEditing {
                Section(header: Text("My Lists").font(.title2).bold().foregroundColor(.black)) {
                    // Your list items go here
                }
            }
        }
    }
    
    
    var customHStack: some View {
        HStack {
            Button(action: {
                isAddingReminder = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(.blue)
                Text("New reminder")
                    .foregroundStyle(.blue)
                    .font(.system(size: 16))
                    .bold()
            }
            
            Spacer()
            
            Button(action: {
                isAddingList = true
            }) {
                Text("Add list")
                    .foregroundStyle(.blue)
                    .font(.system(size: 16))
            }
        }
        .background(Color(.systemGray6))
        .padding()
        .sheet(isPresented: $isAddingReminder) {
            NewReminderView()
        }
        .sheet(isPresented: $isAddingList) {
            AddListView()
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        reminders.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete(at offsets: IndexSet) {
        reminders.remove(atOffsets: offsets)
    }
    
}

struct CardView: View {
    @State private var isPresented = false
    var icon: String
    var title: String
    var listCount: Int?
    var backgroundColor: Color
    var iconColor: Color
    var width: CGFloat
    
    var body: some View {
        Button(action: {
            isPresented = true
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Image(systemName: icon)
                        .font(.system(size: 35))
                        .foregroundColor(iconColor)
                        .padding(.horizontal, -5)
                    
                    Text(title)
                        .font(.headline)
                        .foregroundColor(Color(.systemGray))
                        .padding(.vertical, 5)
                        .bold()
                }
                
                Spacer()
                
                if let listCount = listCount {
                    Text("\(listCount)")
                        .font(.title)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .padding(.bottom, 30)
                        .foregroundColor(.black)
                        .bold()
                } else {
                    Spacer()
                }
            }
            .padding()
            .frame(width: width, height: 90)
            .background(backgroundColor)
            .cornerRadius(12)
            .shadow(radius: 0)
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $isPresented) {
            RemindersView()
        }
    }
}


#Preview {
    RemindersMain()
}

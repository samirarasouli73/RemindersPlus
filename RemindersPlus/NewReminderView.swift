//
//  SwiftUIView.swift
//  JournalX
//
//  Created by Samira Resouliikhechi on 15/11/23.
//
import SwiftUI
import PhotosUI

struct NewReminderView: View {
    @State private var reminderTitle = "Title"
    @State private var reminderNotes = "Notes"
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var tags = ""
    @State private var location = ""
    @State private var isFlagged = false
    @State private var priorityStatus = "None"
    @State private var imageURL = ""
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var modalViewData: ModalViewData

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("", text: $reminderTitle)
                        .foregroundColor(reminderTitle == "Title" ? .gray : .black)
                        .onTapGesture {
                            if reminderTitle == "Title" {
                                reminderTitle = ""
                            }
                        }
                    TextEditor(text: $reminderNotes)
                        .frame(height: 100)
                        .foregroundColor(reminderNotes == "Notes" ? .gray : .black)
                        .onTapGesture {
                            if reminderNotes == "Notes" {
                                reminderNotes = ""
                            }
                        }
                }
                
                Section(header: Text("Details")) {
                    HStack {
                        Image(systemName: "calendar")
                            .frame(width: 25, height: 25)
                            .background(Color.red)
                            .cornerRadius(4)
                            .foregroundColor(.white)
                        DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                            .accentColor(.blue)
                    }
                    
                    HStack {
                        Image(systemName: "clock.fill")
                            .frame(width: 25, height: 25)
                            .background(Color.blue)
                            .cornerRadius(4)
                            .foregroundColor(.white)

                        DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                            .accentColor(.blue)
                    }
                    
                    HStack {
                        Image(systemName: "number")
                            .frame(width: 25, height: 25)
                            .background(Color.gray)
                            .cornerRadius(4)
                            .foregroundColor(.white)

                        TextField("Tags", text: $tags)
                            .autocapitalization(.none)
                    }
                    
                    HStack {
                        Image(systemName: "location.fill")
                            .frame(width: 25, height: 25)
                            .background(Color.blue)
                            .cornerRadius(4)
                            .foregroundColor(.white)
                        TextField("Location", text: $location)
                    }
                    
                    HStack {
                        Image(systemName: isFlagged ? "flag.fill" : "flag")
                            .frame(width: 25, height: 25)
                            .background(Color.orange)
                            .cornerRadius(4)
                            .foregroundColor(.white)
                        Toggle("Flag", isOn: $isFlagged)
                    }
                    
                    HStack {
                        Image(systemName: "exclamationmark")
                            .frame(width: 25, height: 25)
                            .background(Color.red)
                            .cornerRadius(4)
                            .foregroundColor(.white)
                        Picker("Priority", selection: $priorityStatus) {
                            Text("None").tag("None")
                            Text("Low").tag("Low")
                            Text("Medium").tag("Medium")
                            Text("High").tag("High")
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onAppear {
                                // Set the color of the Picker's text to gray
                                UITableView.appearance().tintColor = .gray
                            }
                        
                    }
                    
                    
                    HStack {
                        Button(action: {
                            showImagePicker.toggle()
                            
                        }) {
                            Text("Add Image")
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(selectedImage: $selectedImage)
                            
                        }
                    }

                    
                    HStack {
                        TextField("URL", text: $imageURL)
                    }
                }
                
            }
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Add") {
                    addNewReminder()
                }
            )
            .navigationBarTitle("New Reminder", displayMode: .inline)

        }
    }
    
    func addNewReminder() {
            let reminder = Reminder(
                title: reminderTitle,
                notes: reminderNotes,
                date: selectedDate,
                time: selectedTime,
                tags: tags.components(separatedBy: ","),
                location: location,
                isFlagged: isFlagged,
                priorityStatus: priorityStatus,
                isComplete: false
            )
            
            modalViewData.addReminder(reminder)
            presentationMode.wrappedValue.dismiss()
        }
    }


struct Reminder: Identifiable {
    let id = UUID()
    var title: String
    var notes: String
    var date: Date?
    var time: Date?
    var tags: [String]
    var location: String
    var isFlagged: Bool
    var priorityStatus: String
    var isComplete: Bool
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

#Preview{
    NewReminderView()
}

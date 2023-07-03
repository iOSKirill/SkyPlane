//
//  File.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 3.07.23.
//
import Foundation
import SwiftUI
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestoreSwift

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImageUrl: String
    @Environment(\.dismiss) var dismiss
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        //leave alone for right now
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
        private var firebaseManager: FirebaseManagerProtocol = FirebaseManager()
        private var uid = UserDefaults.standard.string(forKey: "uid")
        private var parent: ImagePicker
     
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
            var selectedImage = UIImage()
                                
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                selectedImage = image
            }
            
            if picker.sourceType == UIImagePickerController.SourceType.camera {
                
                let imgName = "\(UUID().uuidString).jpeg"
                let documentDirectory = NSTemporaryDirectory()
                let localPath = documentDirectory.appending(imgName)
                
                if let data = selectedImage.jpegData(compressionQuality: 0.3) {
                    do {
                        try data.write(to: URL(fileURLWithPath: localPath))
                    } catch {
                        print(error)
                    }
                }
                parent.selectedImageUrl = URL(fileURLWithPath: localPath).absoluteString
            } else if let selectedImageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                parent.selectedImageUrl = selectedImageUrl.absoluteString
            }
                        
            parent.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}

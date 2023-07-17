//
//  BoordingPassViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 3.07.23.
//

import Foundation
import UIKit
import MessageUI
import SwiftUI
import Photos

final class BoordingPassViewModel: ObservableObject {
    
    //MARK: - Property -
    @Published var buyTicketInfo: TicketsFoundModel
    @Published var classFlight: ClassFlight = .economy
    @Published var isPresented: Bool = false
    @Published var userInfo = UserData.shared
    @Published var isImageSaved: Bool = false
    @Published var isShowingMailView: Bool = false
    @Published var showPhotoPermissionAlert: Bool = false

    init() {
        buyTicketInfo = TicketsFoundModel(data: DateTicket())
    }
    
    var imageURL: String {
        return "https://pics.avs.io/100/50/\(buyTicketInfo.icon).png"
    }
    
    //MARK: - Save view ticket in document and photoAlbum -
    func saveViewTicket() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        let renderer = UIGraphicsImageRenderer(bounds: window.bounds)
        let image = renderer.image { _ in
            window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
        }
        
        if let data = image.jpegData(compressionQuality: 1.0) {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsDirectory.appendingPathComponent("MyTicket.jpg")
            
            do {
                try data.write(to: fileURL)
                isImageSaved = true
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                print(documentsDirectory)
            } catch {
                print("Error saving image: (error)")
            }
        }
    }
    
    //MARK: - Request photo permissions -
    func requestPhotoPermissions() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                self.showPhotoPermissionAlert = status != .authorized
            }
        }
    }
    
    //MARK: - Open app settings -
    func openAppSettings() {
       guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
       UIApplication.shared.open(settingsURL)
   }
}

//MARK: - Mail view -
struct MailView: UIViewControllerRepresentable {
    
    //MARK: - Property -
    @Binding var result: Bool
    var buyTicketInfo: TicketsFoundModel = TicketsFoundModel(data: DateTicket())
    var classFlight: ClassFlight = .economy
    
    func makeCoordinator() -> Coordinator {
        Coordinator(result: $result)
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposeViewController = MFMailComposeViewController()
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return mailComposeViewController }
        let renderer = UIGraphicsImageRenderer(bounds: window.bounds)
        let image = renderer.image { _ in
            window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
        }
        guard let data = image.jpegData(compressionQuality: 1.0) else { return mailComposeViewController }
        mailComposeViewController.setToRecipients(["\(UserData.shared.email)"])
        mailComposeViewController.setSubject("SkyPlane")
        mailComposeViewController.setMessageBody("Info your ticket: \n\n Origin: \(buyTicketInfo.origin)\n Destination: \(buyTicketInfo.destination)\n Duration: \(buyTicketInfo.duration.formatDuration())\n Depature date: \(buyTicketInfo.departureDate)\n Flight number: \(buyTicketInfo.flightNumber)\n Class: \(classFlight.rawValue)\n Seat number: B2", isHTML: false)
        mailComposeViewController.addAttachmentData(data, mimeType: "image/jpeg", fileName: "ticket.jpg")
        mailComposeViewController.mailComposeDelegate = context.coordinator
        return mailComposeViewController
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var result: Bool
        
        init(result: Binding<Bool>) {
            _result = result
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            $result.wrappedValue = false
        }
    }
}


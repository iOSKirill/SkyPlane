//
//  MapViewModel.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 18.07.23.
//

import Foundation
import GoogleMaps
import SwiftUI

final class MapViewModel: ObservableObject {
    
    //MARK: - Property -
    private var alamofireProvider: AlamofireProviderProtocol = AlamofireProvider()
    @Published var origin: String = ""
    @Published var destination: String = ""
    @Published var isSearch: Bool = false
    @Published var routeCoordinates: [[Double]] = [[]]
    @Published var keyboardHeight: CGFloat = 0.0
    @Published var isAlert: Bool = false
    @Published var errorText = "" {
        didSet {
            isAlert = true
        }
    }
    
    //MARK: - Create route on map -
    func createRoute() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                guard !origin.isEmpty, !destination.isEmpty else { return await MainActor.run { self.errorText = "Fill in the origin and destination" } }
                let originLatLonByCityName = try await alamofireProvider.getCodeByCityName(cityName: origin)
                guard let originLat = originLatLonByCityName.first?.coordinates?.lat, let originLon = originLatLonByCityName.first?.coordinates?.lon else { return }
                let destinationLatLonByCityName = try await alamofireProvider.getCodeByCityName(cityName: destination)
                guard let destinationLat = destinationLatLonByCityName.first?.coordinates?.lat, let destinationLon = destinationLatLonByCityName.first?.coordinates?.lon else { return }
                let coordinates = [
                    [originLat, originLon],
                    [destinationLat, destinationLon]
                ]
                await MainActor.run {
                    self.isSearch.toggle()
                    self.routeCoordinates = coordinates
                    self.origin = ""
                    self.destination = ""
                }
            } catch {
                await MainActor.run {
                    self.errorText = error.localizedDescription
                }
            }
        }
    }
    
    //MARK: - Keyboard height -
    func keyboardHeightView() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
            guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardSize = value.cgRectValue.size
            self.keyboardHeight = keyboardSize.height - 100
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (_) in
            self.keyboardHeight = 0
        }
    }
}

//MARK: - Map view google -
struct MapViewGoogle: UIViewRepresentable {
    
    //MARK: - Property -
    private let apiGoogleMap = Bundle.main.object(forInfoDictionaryKey: "ApiGoogleMapKey") as? String ?? "Api Error"
    @ObservedObject var viewModel: MapViewModel

    func makeUIView(context: Context) -> GMSMapView {
        GMSServices.provideAPIKey(apiGoogleMap)
        let camera = GMSCameraPosition.camera(withLatitude: viewModel.routeCoordinates.first?.first ?? 53.9000000, longitude: viewModel.routeCoordinates.last?.last ?? 27.5666700, zoom: 5.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        uiView.clear()
        let path = GMSMutablePath()
        for coordinate in viewModel.routeCoordinates {
            guard let latitude = coordinate.first,let longitude = coordinate.last else { return }
            uiView.animate(toLocation: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            path.add(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            
            let polyline = GMSPolyline(path: path)
            polyline.strokeColor = .blue
            polyline.strokeWidth = 3.0
            polyline.geodesic = true
            polyline.map = uiView

            let startMarker = GMSMarker()
            startMarker.position = path.coordinate(at: 0)
            startMarker.icon = GMSMarker.markerImage(with: .green)
            startMarker.map = uiView

            let endMarker = GMSMarker()
            endMarker.position = path.coordinate(at: 1)
            endMarker.icon = GMSMarker.markerImage(with: .green)
            endMarker.map = uiView
        }
    }
}

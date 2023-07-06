//
//  MapView.swift
//  SkyPlane
//
//  Created by Kirill Manuilenko on 5.07.23.
//

import SwiftUI
import GoogleMaps

struct MapViewGoogle: UIViewRepresentable {
    
    let apiGoogleMap = Bundle.main.object(forInfoDictionaryKey: "ApiGoogleMapKey") as? String ?? "Api Error"
    
    func makeUIView(context: Context) -> GMSMapView {
        GMSServices.provideAPIKey(apiGoogleMap)
        let camera = GMSCameraPosition.camera(withLatitude: 37.7749, longitude: -122.4194, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        uiView.clear()
        // Массив координат маршрутов
        let routes = [
            [(37.7749, -122.4194), (37.7749, -122.4313)],
            [(37.7838, -122.4313), (37.7867, -122.4105)]
        ]
        
        // Создание и добавление каждого маршрута на карту
        for route in routes {
            let path = GMSMutablePath()
            for coordinate in route {
                path.addLatitude(coordinate.0, longitude: coordinate.1)
            }
            
            let polyline = GMSPolyline(path: path)
            polyline.strokeColor = .blue
            polyline.strokeWidth = 1.0
            polyline.map = uiView
        }

    }
}

struct MapView: View {
    var body: some View {
        VStack {
            MapViewGoogle()
        }

    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

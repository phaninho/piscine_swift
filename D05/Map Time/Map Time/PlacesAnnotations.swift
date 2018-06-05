//
//  PlacesAnnotations.swift
//  Map Time
//
//  Created by Stephane MARTINS on 6/5/18.
//  Copyright © 2018 stephane martins. All rights reserved.
//

import Foundation
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation
{
    var coordinate: CLLocationCoordinate2D
    var latitude: Double?
    var longitude: Double?
    var title: String?
    var subtitle: String?
    
    init(title: String?, subtitle: String?, latitude: Double?, longitude: Double?)
    {
        self.latitude = latitude
        self.longitude = longitude
        
        self.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
        
        self.title = title
        self.subtitle = subtitle
        
        super.init()
    }
    
    var region: MKCoordinateRegion
    {
        let latDelta:Double = 0.025
        let lngDelta:Double = 0.025
        let zoomSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lngDelta)
        return MKCoordinateRegion(center: coordinate, span: zoomSpan)
    }
    
}


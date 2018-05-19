//
//  ViewController.swift
//  SWVL Challenge
//
//  Created by Mohamed Saeed on 5/19/18.
//  Copyright © 2018 kalamoni. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var stationView: StationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadMapView()
        stationView.bookmarkButton.layer.cornerRadius = 10
        stationView.bookmarkButton.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMapView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        //        let GMapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.camera = camera
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    @IBAction func didTapLocateMe(_ sender: Any) {
        let alert = UIAlertController(title: "SWVL Challenge", message: "You tapped Locate Me!"
            , preferredStyle: UIAlertControllerStyle.alert)
        alert.view.tintColor = UIColor.red
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
     // MARK: - GMSMapViewDelegate
     
     */
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("did tap the Marker")
        
        stationView.title?.text = marker.title ?? "-"
        stationView.snippet?.text = marker.snippet ?? "-"
        stationView.frame = self.view.frame
        stationView.center = self.view.center
        stationView.alpha = 0
        self.view.addSubview(stationView)
        self.stationView.transform = CGAffineTransform.identity
        stationView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.stationView.transform = CGAffineTransform.identity
            self.stationView.alpha = 1
        })
        
        
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = Bundle.main.loadNibNamed("MarkerView", owner: nil, options: nil)!.first as! MarkerView
        view.layer.cornerRadius = 10
        view.imageView.layer.cornerRadius = 10
        view.title?.text = marker.title ?? ""
        view.snippet?.text = marker.snippet ?? ""
        return view
    }
    
}


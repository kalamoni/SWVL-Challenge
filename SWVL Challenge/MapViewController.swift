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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadMapView()
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
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
        let view = MarkerView(frame: CGRect(x: 0, y: 0, width: 200, height: 94))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        
        view.title?.text = "Hi there!"
//        view.addSubview(lbl1)
        
        view.snippet?.text = "I am a custom info window."
//        let lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: view.frame.size.width - 16, height: 15))
//        lbl2.text = "I am a custom info window."
//        lbl2.font = UIFont.systemFont(ofSize: 14, weight: .light)
//        view.addSubview(lbl2)
        
        return view
    }
    
}


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

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var stationView: StationView!
    @IBOutlet var linesCollectionView: UICollectionView!
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadMapView()
        stationView.bookmarkButton.layer.cornerRadius = 10
        stationView.bookmarkButton.clipsToBounds = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadLines), name: .FetchedLines, object: nil)
        
        linesCollectionView.dataSource = self
        linesCollectionView.delegate = self
        linesCollectionView.backgroundColor = UIColor.clear
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     This method is used to setup the map view and set the default location.
     */
    func loadMapView() {
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView.camera = camera
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 30.004, longitude: 31.186)
        marker.title = "Dary"
        marker.snippet = "Haram street"
        marker.appearAnimation = .pop
        marker.icon = #imageLiteral(resourceName: "Point")
        //        marker.infoWindowAnchor = CGPoint(x: 2, y: 0)
        marker.map = mapView
        
    }
    /**
     This method is used to plot the stations of a certain line on the map.
     
     - parameter stations: an array of stations to plot.
     */
    func plotMarkers(stations: [Station]) {
        mapView.clear()
        guard stations.count > 0 else { return }
        
        var bounds = GMSCoordinateBounds()
        for station in stations
        {
            let coordinate = CLLocationCoordinate2D(latitude: station.location.latitude, longitude: station.location.longitude)
            bounds = bounds.includingCoordinate(coordinate)
        }
        let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
        mapView.animate(with: update)
        
        for index in 0..<stations.count {
            let lat = stations[index].location.latitude
            let long = stations[index].location.longitude
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            marker.title = stations[index].name
            marker.snippet = stations[index].address
            marker.appearAnimation = .pop
            marker.icon = #imageLiteral(resourceName: "Point")
            
            switch index {
            case 0:
                marker.icon = #imageLiteral(resourceName: "StartPoint")
                
            case stations.count-1:
                marker.icon = #imageLiteral(resourceName: "EndPoint")
            default:
                marker.icon = #imageLiteral(resourceName: "Point")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4 + (Double(index) * 0.2)) {
                marker.map = self.mapView
            }
            
        }
    }
    
    /**
     This method is used to asynchronously reload the lines once fetching the lines over the network is done.
     */
    @objc func reloadLines() {
        DispatchQueue.main.async {
            let range = Range(uncheckedBounds: (0, self.linesCollectionView.numberOfSections))
            let indexSet = IndexSet(integersIn: range)
            self.linesCollectionView.reloadSections(indexSet)
        }
    }
    
    /**
     This method is used to get the user's location and centers the map view around his/her location.
     
     - parameter sender: a reference to the button that has been tapped.
     */
    @IBAction func didTapLocateMe(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    
    /*
     // MARK: - UICollectionViewDataSource
     
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Lines.shared.linesList.lines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        let toLabel: UILabel = cell.viewWithTag(1) as! UILabel
        if let firstStation = Lines.shared.linesList.lines[indexPath.row].stations.first?.name {
            toLabel.text = firstStation
        } else {
            toLabel.text = "-"
        }
        
        let fromLabel: UILabel = cell.viewWithTag(2) as! UILabel
        if let lastStation = Lines.shared.linesList.lines[indexPath.row].stations.last?.name {
            fromLabel.text = lastStation
        } else {
            fromLabel.text = "-"
        }
        toLabel.textColor = UIColor.SWVLGray
        fromLabel.textColor = UIColor.SWVLGray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        plotMarkers(stations: Lines.shared.linesList.lines[indexPath.row].stations)
    }
    
    /*
     // MARK: - CLLocationManagerDelegate
     
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        let cameraPos = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        mapView.animate(to: cameraPos)
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        let alert = UIAlertController(title: "SWVL Challenge", message: "Sorry, Can't locate your position now. Please enable location services in the Settings app."
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
        view.title.textColor = UIColor.SWVLGray
        view.title?.text = marker.title ?? ""
        view.snippet.textColor = UIColor.SWVLLightGray
        view.snippet?.text = marker.snippet ?? ""
        return view
    }
    
}


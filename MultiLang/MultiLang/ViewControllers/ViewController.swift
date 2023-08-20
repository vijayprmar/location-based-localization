//
//  ViewController.swift
//  MultiLang
//
//  Created by Vijay Parmar on 20/08/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblHelloMsg: UILabel!
    @IBOutlet weak var lblCityName: UILabel!

    //MARK: - Local Variables
    var locationManager : CLLocationManager!
    
    //MARK: - App Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    //MARK: - Initial Setup
    private func initialSetup(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - Functions
    
    //set language
    private func setLanguage(){
        Bundle.setLanguage(lang: "hi")
        
    }
    
    //Function to get state and city from latitude and longitude and set string accourding to location
    private func getStateCityFrom(latitude:CLLocationDegrees,longitude:CLLocationDegrees){
        let location = CLLocation(latitude: latitude, longitude: longitude)
        location.placemark { placemark, error in
            guard let placemark = placemark else {
                print("Error:", error ?? "nil")
                return
            }
            self.lblState.text =  placemark.state ?? ""
            self.lblCityName.text = placemark.city ?? ""
            self.lblHelloMsg.text = "Hello my name is vijay".setStringfor(location: placemark.state ?? "")
        }
        
    }
    

}

//MARK: - Delegate for current location
extension ViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        self.getStateCityFrom(latitude: locations.first?.coordinate.latitude ?? 0, longitude: locations.first?.coordinate.longitude ?? 0)
       
    }
    
    
}

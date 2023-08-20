//
//  Extensions.swift
//  MultiLang
//
//  Created by Vijay Parmar on 20/08/23.
//

import Foundation
import CoreLocation
import MapKit
import Contacts

extension String {
    //return localized string
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }
    
    //Set L:ocation based on state
    func setStringfor(location:String)->String{
        
        switch location {
        case "TN","Tamil Nadu":
            Bundle.setLanguage(lang: "ta")
        case "WB","West Bengal":
            Bundle.setLanguage(lang: "bn")
        case "GJ","Gujarat":
            Bundle.setLanguage(lang: "gu")
        case "DL","Delhi":
            Bundle.setLanguage(lang: "mr")
        case "MH","Maharashtra":
            Bundle.setLanguage(lang: "mr")
        default:
            Bundle.setLanguage(lang: "en")
        }
        return self.localized()
    }
}

extension Bundle {
    private static var bundle: Bundle!
    
    //get current localized bundle
    public static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let appLang = UserDefaults.standard.string(forKey: "app_lang") ?? "en"
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }
        
        return bundle;
    }
    //set localize bundle
    public static func setLanguage(lang: String) {
        UserDefaults.standard.set(lang, forKey: "app_lang")
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path!)
    }
}



extension CLPlacemark {
    /// street name, eg. Infinite Loop
    var streetName: String? { thoroughfare }
    /// // eg. 1
    var streetNumber: String? { subThoroughfare }
    /// city, eg. Cupertino
    var city: String? { locality }
    /// neighborhood, common name, eg. Mission District
    var neighborhood: String? { subLocality }
    /// state, eg. CA
    var state: String? { administrativeArea }
    /// county, eg. Santa Clara
    var county: String? { subAdministrativeArea }
    /// zip code, eg. 95014
    var zipCode: String? { postalCode }
    /// postal address formatted
    @available(iOS 11.0, *)
    var postalAddressFormatted: String? {
        guard let postalAddress = postalAddress else { return nil }
        return CNPostalAddressFormatter().string(from: postalAddress)
    }
}


extension CLLocation {
    // Get placemark
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}

//
//  LaunchViewController.swift
//  SpaceXAPI
//
//  Created by Owen Henley on 7/24/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var launchSearchBar       : UISearchBar!
    @IBOutlet weak var flightNumberLabel     : UILabel!
    @IBOutlet weak var missionName           : UILabel!
    @IBOutlet weak var rocketNameLabel       : UILabel!
    @IBOutlet weak var rocketTypeLabel       : UILabel!
    @IBOutlet weak var missionBadgeImageView : UIImageView!
    @IBOutlet weak var launchYearLabel       : UILabel!
    @IBOutlet weak var launchSiteLabel       : UILabel!
    @IBOutlet weak var launchSuccessLabel    : UILabel!
    @IBOutlet weak var launchDetailsTextView : UITextView!
    @IBOutlet weak var activityIndicator     : UIActivityIndicatorView!
    @IBOutlet weak var activityView          : UIView!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
      launchSearchBar.delegate = self
         self.activityView.isHidden = true
       
       
    }
}


extension LaunchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        activityView.backgroundColor = UIColor.clear
        
        // NOTE: - THE 'green' number is pretty much a decim but fancied up bc its in a fraction form.
     activityIndicator.color = UIColor.gray
        //(red: 0.3, green: 165/255, blue: 0.09, alpha: 1)
        
        activityIndicator.startAnimating()
        activityView.isHidden = false
        
        guard let searchText = searchBar.text, !searchText.isEmpty else {return}
        
        LaunchController.findLaunch(searchText) { (launch) in
            guard let unwrappedLaunch = launch else {return}
            

            LaunchController.getMissionPatchImage(for: unwrappedLaunch, completion: { (image) in
                print("User is rajasiko and tapped the button")
                DispatchQueue.main.async {
                    self.launchSearchBar.text = ""
                    // NOTE: - find what flight number it was
                    self.flightNumberLabel.text = "\(unwrappedLaunch.flightNumber)"
                    self.missionName.text = unwrappedLaunch.missionName
                    // NOTE: -  we only put = image bc we alredy told it we want to complete with image. on a line above
                    self.missionBadgeImageView.image = image
                    self.rocketNameLabel.text = unwrappedLaunch.rocket.rocketName
                    self.rocketTypeLabel.text = unwrappedLaunch.rocket.rocketType
                    self.launchYearLabel.text = unwrappedLaunch.launchYear
                    self.launchSiteLabel.text = "\(unwrappedLaunch.launchSite)"
                    self.launchSuccessLabel.text = unwrappedLaunch.launchSuccess ? "Successul" : "Unsuccessful"
                    self.launchDetailsTextView.text = unwrappedLaunch.details ?? "no details Available"
                    
                    self.activityView.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
            })
        }
    }
}

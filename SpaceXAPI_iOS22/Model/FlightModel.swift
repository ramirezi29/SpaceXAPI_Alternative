//
//  FlightModel.swift
//  SpaceXAPI_iOS22
//
//  Created by Ivan Ramirez on 10/20/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation


struct Flight: Decodable {
    
    let flightNumber: Int
    let missionName: String
    let launchYear: String
    let launchSuccess: Bool
    // NOTE: - Some do not have details
    let details: String?
    let links: Links
    let launchSite: LaunchSites
    let rocket: Rocket
    
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case launchYear = "launch_year"
        case launchSuccess = "launch_success"
        case details
        case links
        case launchSite = "launch_site"
        case rocket
        
    }
}

struct Links: Decodable {
    let missionPachAsString: String
    
    enum CodingKeys: String, CodingKey {
        case missionPachAsString = "mission_patch"
    }
}

struct LaunchSites: Decodable {
    let launchSiteName: String
    
    enum CodingKeys: String, CodingKey {
        case launchSiteName = "site_name"
    }
}

struct Rocket: Decodable {
    let rocketName: String
    let rocketType: String
    
    enum CodingKeys: String, CodingKey {
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
    }
}






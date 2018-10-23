//
//  LaunchController.swift
//  SpaceXAPI_iOS22
//
//  Created by Ivan Ramirez on 10/20/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class LaunchController {
    
    /*
     // NOTE: - static let in order to test dummy data in the APP Delegate
     static let shared = LaunchController()
     */
    
    // NOTE: - Base URL
    static let baseURL = URL(string: "https://api.spacexdata.com/v3/launches")
    
    static func findLaunch(_ searchTerm: String, completion: @escaping (Flight?) -> Void) {
        
        // MARK: - Construct URL
        guard let unwrappedBaseURL = baseURL else { print("\nIssue with Base URL"); completion(nil)
            return
        }
        
        //https://api.spacexdata.com/v3/launches?flight_number=40
        var componants = URLComponents(url: unwrappedBaseURL, resolvingAgainstBaseURL: true)
        
        guard let searchTerm = Int(searchTerm) else {
            completion(nil)
            return
        }
        
        // NOTE: - This was found in the JSON
        let queryItem = URLQueryItem(name: "flight_number", value: "\(searchTerm)")
        
        // NOTE: - store them while they are being queried
        componants?.queryItems = [queryItem]
        
        guard let fullURL = componants?.url else {
            completion(nil)
            return
        }
        print(fullURL.absoluteURL)
        var request = URLRequest(url: fullURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("\n\n🚀 There was an error with Error with URLSession in: \(#file) \n\n(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                // NOTE: - Now that we created JSONDEcoder we need to dig into our array and tell it what to look for
                // 'Decodable.Protocol' - waht do you want to decode
                let flightArray = try jsonDecoder.decode([Flight].self, from: data)
                // Grab only the first item
                guard let flight = flightArray.first else {
                    completion(nil)
                    return
                }
                //func findLaunch(_ searchTerm: String, completion: @escaping (Flight?) -> Void)
                completion(flight)
            }catch {
                print("\n\n🚀 There was an error with Error Decoding Launch Data in: \(#file) \n\n(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                completion(nil)
                return
            }
            }.resume()
    }// fetch function
    
    static func getMissionPatchImage(for flight: Flight, completion: @escaping (UIImage?) ->Void) {
        
        // unwrapped the url from the actual JSON
        // getMissionPatchImage(for flight: Flight, completion:
        //the 'flight' is what we are after and we dig into the enums
        guard let urlForImage = URL(string: flight.links.missionPachAsString) else {
            print("No Image Available for mission")
            completion(nil)
            return
        }
        print(urlForImage.absoluteString)
        
        URLSession.shared.dataTask(with: urlForImage) { (data, _, error) in
            if let error = error {
                print("\n\n🚀 There was an error with the dataTask in: \(#file) \n\n(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                completion(nil)
                return
            }
            guard let unwrappedImageData = data else {completion(nil);
                print("Error unwrapping Data")
                return
            }
            let image = UIImage(data: unwrappedImageData)
            completion(image)
            
        }.resume()
    }// image fetch fun
    
    //https://images2.imgbox.com/76/0b/bJD0zV02_o.png
}//🔥

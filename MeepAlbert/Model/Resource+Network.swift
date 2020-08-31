//
//  Resource+Network.swift
//  MeepAlbert
//
//  Created by Albert on 30/08/2020.
//  Copyright © 2020 Albert. All rights reserved.
//

import Alamofire
import RealmSwift
import SwiftyJSON

private let GenericError = NSError(domain: "#error#", code: 9000, userInfo: nil)

extension Resource {
    
    public static func lisboa(lowerLeftCoordinates: Coordinates?, upperRightCoordinates: Coordinates?, _ completion: @escaping(_ success: Bool, _ error: Error?) -> ()) -> DataRequest {
        
        return NetworkProvider<ResourcesSpecs>.requestJSON(.lisboa(lowerLeftCoordinates: lowerLeftCoordinates, upperRightCoordinates: upperRightCoordinates), { (response, specs) in

            switch response.result {
            case .success(_):
                
                do {
                    // Get response data
                    guard let data = response.data else {
                        completion(false, GenericError)
                        return
                    }
                    
                    let resourcesJSON = try JSON(data: data).arrayValue

                    var resources: [Resource] = []
                    for json in resourcesJSON {
                        resources.append(Resource(json))
                    }
                
                    // Save data to realm
                    let realm = try Realm()
                    try realm.write {
                        realm.add(resources, update: .all)
                    }
                    
                    completion(true, nil)
                } catch {
                    completion(false, error)
                }
                
            case .failure(let error):
                completion(false, error)
            }
            
        })
        
    }
}


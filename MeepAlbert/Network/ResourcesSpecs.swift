//
//  ResourcesSpecs.swift
//  MeepAlbert
//
//  Created by Albert on 30/08/2020.
//  Copyright © 2020 Albert. All rights reserved.
//

import Alamofire

// MARK: - Provider specs
enum ResourcesSpecs {
    case lisboa(lowerLeftCoordinates: Coordinates?, upperRightCoordinates: Coordinates?)
}

extension ResourcesSpecs: NetworkProviderSpecs {
    var baseURLString: String {
        return "https://apidev.meep.me"
    }
    
    var path: String {
        switch self {
        case .lisboa(let lowerLeftCoordinates, let upperRightCoordinates):
            guard let lowerLeftCoordinates = lowerLeftCoordinates, let upperRightCoordinates = upperRightCoordinates else {
                return baseURLString + "/tripplan/api/v1/routers/lisboa/resources"
            }
            return baseURLString + "/tripplan/api/v1/routers/lisboa/resources?lowerLeftLatLon=\(lowerLeftCoordinates.lat),\(lowerLeftCoordinates.lon)&upperRightLatLon=\(upperRightCoordinates.lat),\(upperRightCoordinates.lon)"
        }
        
    }
    
    var method: HTTPMethod {
        switch self {
        case .lisboa:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .lisboa:
            return ["Accept": "application/json"]
        }
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .lisboa:
            return JSONEncoding.default
        }
    }    
}


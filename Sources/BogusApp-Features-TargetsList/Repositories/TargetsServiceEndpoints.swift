//
//  TargetsServiceEndpoints.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import Foundation
import BogusApp_Common_Networking

/// Used to dynamically manipulate endpoints used in repository
public protocol TargetsServiceEndpointsQueryable {
    func targetsListEndpoint(ids: [UUID]) -> Endpoint
}

public final class DefaultTargetsEndpointProvider: TargetsServiceEndpointsQueryable {
    public init() { }
    public func targetsListEndpoint(ids: [UUID]) -> Endpoint {
        DefaultTargetsServiceEndpoints.targets(ids: ids).endpoint()
    }
}

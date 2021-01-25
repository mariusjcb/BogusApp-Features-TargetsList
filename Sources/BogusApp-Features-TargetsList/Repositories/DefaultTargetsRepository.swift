//
//  TargetsRepository.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 22/01/2021.
//

import Foundation
import BogusApp_Common_Models
import BogusApp_Common_Utils
import BogusApp_Common_Networking

/// Fetches data from Targets service or database / cache
public protocol TargetsRepository {
    @discardableResult
    func fetchTargets(ids: [UUID], completion: @escaping (Result<[TargetSpecific], Error>) -> Void) -> DataRequest?
}

/// Default implementation of **TargetsRepository**
public final class DefaultTargetsRepository: TargetsRepository {

    private let targetsService: NetworkService
    private let endpointsProvider: TargetsServiceEndpointsQueryable

    public init(targetsService: NetworkService, endpointsProvider: TargetsServiceEndpointsQueryable) {
        self.targetsService = targetsService
        self.endpointsProvider = endpointsProvider
    }

    // MARK: - Targets Repository

    public func fetchTargets(ids: [UUID], completion: @escaping (Result<[TargetSpecific], Error>) -> Void) -> DataRequest? {
        return targetsService.request(with: endpointsProvider.targetsListEndpoint(ids: ids), completion: completion)
    }

}

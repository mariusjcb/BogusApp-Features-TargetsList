//
//  FetchTargetsUseCase.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 22/01/2021.
//

import Foundation
import BogusApp_Common_Networking
import BogusApp_Common_Models
import BogusApp_Common_Utils

public protocol FetchTargetsListUseCase: UseCase {
    @discardableResult
    func fetchTargets(ids: [UUID], completion: @escaping (Result<[TargetSpecific], Error>) -> Void) -> DataRequest?
}

public final class DefaultFetchTargetsListUseCase: FetchTargetsListUseCase {
    private let targetsRepository: TargetsRepository

    public init(targetsRepository: TargetsRepository) {
        self.targetsRepository = targetsRepository
    }

    public func fetchTargets(ids: [UUID], completion: @escaping (Result<[TargetSpecific], Error>) -> Void) -> DataRequest? {
        return targetsRepository.fetchTargets(ids: ids, completion: completion)
    }
}

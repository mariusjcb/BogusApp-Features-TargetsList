//
//  EndpointsProvider.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 22/01/2021.
//

import Foundation
import BogusApp_Common_Networking

public enum DefaultTargetsServiceEndpoints {
    case targets(ids: [UUID])
}

// MARK: - Configuration

extension DefaultTargetsServiceEndpoints: EndpointProvider {
    public var path: String {
        switch self {
        case .targets(ids: _): return "targets"
        }
    }

    public var isFullPath: Bool {
        switch self {
        case .targets(ids: _): return false
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .targets(ids: _): return .get
        }
    }

    public var headerParamaters: [String: String] {
        switch self {
        case .targets(ids: _): return [:]
        }
    }

    public var queryParametersEncodable: Encodable? {
        switch self {
        case .targets(ids: _): return nil
        }
    }

    public var queryParameters: [String: Any] {
        switch self {
        case .targets(ids: let ids): return ["id": ids]
        }
    }

    public var bodyParamatersEncodable: Encodable? {
        switch self {
        case .targets(ids: _): return nil
        }
    }

    public var bodyParamaters: [String: Any] {
        switch self {
        case .targets(ids: _): return [:]
        }
    }

    public var bodyEncoding: BodyEncoding {
        switch self {
        case .targets(ids: _): return .jsonSerializationData
        }
    }
}

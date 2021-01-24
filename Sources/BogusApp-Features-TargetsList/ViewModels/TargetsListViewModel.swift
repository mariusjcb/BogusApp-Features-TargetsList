//
//  TargetsListViewModel.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import Foundation
import BogusApp_Common_Models
import BogusApp_Common_Utils

public struct TargetsListViewModelActions {
    public let showChannelsForSelectedTarget: (_ selectedTargets: [TargetSpecific]) -> Void
    
    public init(showChannelsForSelectedTarget: @escaping ([TargetSpecific]) -> Void) {
        self.showChannelsForSelectedTarget = showChannelsForSelectedTarget
    }
}

public protocol TargetsListViewModelInput {
    func didSetValue(at index: Int, active: Bool)
    func didTapNext()
}

public protocol TargetsListViewModelOutput {
    var itemsObservable: Observable<[TargetsListItemViewModel]> { get }
    var loadingObservable: Observable<Bool> { get }
    var errorObservable: Observable<String> { get }
    var title: String { get }
}

public protocol TargetsListViewModel: TargetsListViewModelInput & TargetsListViewModelOutput { }

public final class DefaultTargetsListViewModel: TargetsListViewModel {
    
    private let fetchTargetsListUseCase: FetchTargetsListUseCase
    private let actions: TargetsListViewModelActions
    
    private var targets: [TargetSpecific] = [] {
        didSet { items = targets.map(TargetsListItemViewModel.init) }
    }
    
    public let title = NSLocalizedString("Select specifics...", comment: "")
    
    @Observable private var items: [TargetsListItemViewModel] = []
    @Observable private var loading: Bool = false
    @Observable private var error: String = ""
    
    // MARK: - OUTPUT
    
    public var itemsObservable: Observable<[TargetsListItemViewModel]> { _items }
    public var loadingObservable: Observable<Bool> { _loading }
    public var errorObservable: Observable<String> { _error }
    
    public init(fetchTargetsListUseCase: FetchTargetsListUseCase, actions: TargetsListViewModelActions) {
        self.fetchTargetsListUseCase = fetchTargetsListUseCase
        self.actions = actions
        
        fetchTargets()
    }
    
    private func fetchTargets(ids: [UUID] = []) {
        loading = true
        fetchTargetsListUseCase.fetchTargets(ids: ids) { result in
            switch result {
            case .success(let targets):
                self.targets = targets
            case .failure(let error):
                self.error = NSLocalizedString("Failed loading", comment: "") + " [\(error.localizedDescription)]"
            }
            self.loading = false
        }
    }
    
    // MARK: - INPUT
    
    public func didSetValue(at index: Int, active: Bool) {
        items[index].selected = active
        print(items[index].selected, index)
    }
    
    public func didTapNext() {
        let targets = self.items.enumerated().filter { $0.element.selected }.map { self.targets[$0.offset] }
        actions.showChannelsForSelectedTarget(targets)
    }
    
}

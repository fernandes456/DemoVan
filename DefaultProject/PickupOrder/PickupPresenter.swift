//
//  PickupPresenter.swift
//  DefaultProject
//
//  Created by Geraldo Fernandes on 23/06/18.
//  Copyright © 2018 Geraldo Fernandes. All rights reserved.
//

import Foundation

protocol PickupViewControllerType: class {
    func showOrder()
}

struct PickupPresenter {
    weak var delegate: PickupViewControllerType?
    
    init(delegate: PickupViewControllerType) {
        self.delegate = delegate
    }
}

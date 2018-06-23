//
//  PickupOrderViewController.swift
//  DefaultProject
//
//  Created by Geraldo Fernandes on 23/06/18.
//  Copyright © 2018 Geraldo Fernandes. All rights reserved.
//

import Foundation
import UIKit

class PickupViewController: UIViewController {
    
    @IBOutlet weak var orderLabel: UILabel!
    var presenter: PickupPresenter!
    @IBOutlet weak var bottomOrderDetailConstraint: NSLayoutConstraint!
    @IBOutlet weak var orderDetailHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       self.presenter = PickupPresenter(delegate: self)
        bottomOrderDetailConstraint.constant = -orderDetailHeightConstraint.constant
    }
}

extension PickupViewController: PickupViewControllerType {
    func showOrder() {
        UIView.animate(withDuration: 0.4) {
            self.bottomOrderDetailConstraint.constant = 0
        }
    }
}

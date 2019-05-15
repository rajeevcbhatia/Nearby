//
//  BaseViewController.swift
//  Nearby
//
//  Created by Rajeev Bhatia on 15/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {

    func showLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            MBProgressHUD.showAdded(to: strongSelf.view, animated: true)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
        }
    }
    
}

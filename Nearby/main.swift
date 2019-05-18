//
//  main.swift
//  Nearby
//
//  Created by Rajeev Bhatia on 18/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

private func delegateClassName() -> String? {
    return NSClassFromString("XCTestCase") == nil ? NSStringFromClass(AppDelegate.self) : nil
}


UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, delegateClassName())

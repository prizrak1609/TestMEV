//
//  Storyboards.swift
//  TestMK
//
//  Created by Dima Gubatenko on 13.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

enum Storyboards {

    enum Name {
        static let main = "Main"
        static let detailInfo = "DetailInfo"
    }

    static var main: UIViewController? {
        return UIStoryboard(name: Name.main, bundle: nil).instantiateInitialViewController()
    }

    static var detailInfo: UIViewController? {
        return UIStoryboard(name: Name.detailInfo, bundle: nil).instantiateInitialViewController()
    }
}

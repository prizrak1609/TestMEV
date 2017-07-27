//
//  DetailInfoController.swift
//  TestMEV
//
//  Created by Dima Gubatenko on 27.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

final class DetailInfoController: UIViewController {
    @IBOutlet fileprivate weak var movieNameLabel: UILabel!
    @IBOutlet fileprivate weak var movieReleaseDateLabel: UILabel!
    @IBOutlet fileprivate weak var moviePosterImageView: UIImageView!

    var model: MovieModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let model = model else { return }
        movieNameLabel.text = NSLocalizedString("Movie title: ", comment: "DetailInfoController") + model.title
        movieReleaseDateLabel.text = NSLocalizedString("Release date: ", comment: "DetailInfoController") + model.releaseDateString
        if let url = URL(string: model.largeURLPath) {
            moviePosterImageView.af_setImage(withURL: url)
        }
    }
}

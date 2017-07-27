//
//  MovieBaseInfoCell.swift
//  TestMEV
//
//  Created by Dima Gubatenko on 27.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit
import AlamofireImage

final class MovieBaseInfoCell: UITableViewCell {
    @IBOutlet fileprivate weak var movieImageView: UIImageView!
    @IBOutlet fileprivate weak var movieNameLabel: UILabel!
    @IBOutlet fileprivate weak var movieRatingLabel: UILabel!
    @IBOutlet fileprivate weak var movieYearLabel: UILabel!

    static let height: CGFloat = 100

    var model: MovieModel? {
        didSet {
            guard let model = model else { return }
            if let url = URL(string: model.thumbURLPath) {
                movieImageView.af_setImage(withURL: url)
            }
            movieNameLabel.text = model.title
            movieRatingLabel.text = model.raiting
            movieYearLabel.text = model.releaseDateString
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
